library(rgl)

reactiveWebGL <- function(func){
  reactive(function(){
    func()
    
    source("webGLParser.R")
    extractWebGL()    
  })
}

shinyServer(function(input, output) {
  output$webGL <- reactiveWebGL(function() {
    plot3d(1:10, 1:10, 1:10)
    return()
  })
})
