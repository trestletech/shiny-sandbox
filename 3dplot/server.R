library(rgl)
library(RColorBrewer)
library(colorspace)

reactiveWebGL <- function(func){
  reactive(function(){
    func()
    
    source("webGLParser.R")
    extractWebGL()    
  })
}

shinyServer(function(input, output) {
  points <- reactive(function(){
    points <- read.csv(txt <- textConnection(input$points), header=FALSE)
    close(txt)
    points
  })
    
  output$webGL <- reactiveWebGL(function() {
    data <- points()
    
    col <- "#FFFFFF"
    if (ncol(data) >= 4){
      col <- data[,4]
    }
    
    if (input$type == "Line"){
      plotType <- "l"
    } else{
      plotType <- "p"
    }
    
    plot3d(data[,1:3], type=plotType, col=col,
           xlab=input$xlab,
           ylab=input$ylab,
           zlab=input$zlab)
    
    
  })
})
