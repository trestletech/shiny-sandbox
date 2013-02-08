log <- function(text, file="log.txt"){
  log <- file(file, "at")
  writeLines(text, con=log)
  print(text)
  close(log)
}

shinyServer(function(input, output) {
  
  log("Server init.")
    
    
  
  
  
  output$main_plot <- reactivePlot(function() {
    log("Getting dataset...")
    
    if (input$dataset == "Geyeser"){
     dataset <- (faithful$eruptions)
    }
    if (input$dataset == "NYC Wind"){
      dataset <- (airquality$Wind)
    }
    
    log("Setting data name...")
    
    if (input$dataset == "Geyeser"){
      dataName <- ("Eruption Duration (min)")
    }
    if (input$dataset == "NYC Wind"){
      dataName <- ("Wind Speed (mph)")
    }
    
    
    log("Plotting hist...")
    
    hist(dataset,
      probability = TRUE,
      breaks = as.numeric(input$n_breaks),
      xlab = dataName,
      main = "Histogram of Data")

    if (input$individual_obs) {
      rug(dataset)
    }

    if (input$density) {
      dens <- density(dataset,
          adjust = input$bw_adjust)
      lines(dens, col = "blue")
    }

  })
})
