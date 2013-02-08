log <- function(text, file="log.txt"){
  log <- file(file, "at")
  writeLines(text, con=log)
  print(text)
  close(log)
}

shinyServer(function(input, output) {
  
  log("Server init.")
  
  getData <- reactive(function(){
    log("Getting dataset...")
    
    if (input$dataset == "Geyeser"){
      return(faithful$eruptions)
    }
    if (input$dataset == "NYC Wind"){
      return(airquality$Wind)
    }
  })
  
  dataName <- reactive(function(){
    log("Setting data name...")
    
    if (input$dataset == "Geyeser"){
      return("Eruption Duration (min)")
    }
    if (input$dataset == "NYC Wind"){
      return("Wind Speed (mph)")
    }
  })
  
  output$main_plot <- reactivePlot(function() {
    log("Plotting hist...")
    
    hist(getData(),
      probability = TRUE,
      breaks = as.numeric(input$n_breaks),
      xlab = dataName(),
      main = "Histogram of Data")

    if (input$individual_obs) {
      rug(getData())
    }

    if (input$density) {
      dens <- density(getData(),
          adjust = input$bw_adjust)
      lines(dens, col = "blue")
    }

  })
})
