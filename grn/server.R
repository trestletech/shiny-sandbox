
library(GeneNet)
library(igraph)

reactiveAdjacencyMatrix <- function(func){
  reactive(function(){
        
    val <- func()
    #TODO: re-arrange columns if necessary
    if (!all(rownames(val) == colnames(val))){
      stop("Colnames and rownames of your matrix must be identical")
    }
    
    #warning: this will sacrifice the colnames, so we presuppose that they're identical
    list(names=rownames(val), data=as.numeric(val))
    
  })

}

shinyServer(function(input, output) {

  data <- reactive(function(){
    df <- input$file
    path <- df$datapath     
    data <- read.csv(path, row.names=1)
    data
  })
  
  output$debug <- reactivePrint(function(){})
  
  output$main_net <- reactiveAdjacencyMatrix(function() {
  
    if(is.null(input$file)){
      plot.new()
      plot.window(xlim=0:1, ylim=0:1)
      text(.5, .5, "You must upload data before we can display it.")
      return()  
    }
    
    data <- data()
    
    if (input$method == "GeneNet"){      
      net <- ggm.estimate.pcor(data)
      net <- abs(net)  
      net <- matrix(as.numeric(net), ncol=ncol(net))
      rownames(net) <- colnames(net) <- colnames(data)        
    }
    
    net[net < input$con_weight] <- 0
    
    net

  })
})
