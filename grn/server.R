
library(GeneNet)
library(igraph)

shinyServer(function(input, output) {

  data <- reactive(function(){
    #df <- input$file
    #path <- df$datapath     
    data <- read.csv("/home/qbrc/data.csv", row.names=1)
    data
  })
  
  output$debug <- reactivePrint(function(){input$file})
  
  output$main_plot <- reactivePlot(function() {
  
    if(is.null(input$file)){
      plot.new()
      plot.window(xlim=0:1, ylim=0:1)
      text(.5, .5, "You must upload data before we can display it.")
      return()  
    }
    
    data <- read.csv("/home/qbrc/data.csv", row.names=1)
    
    if (input$method == "GeneNet"){      
      net <- ggm.estimate.pcor(data)
      net <- abs(net)      
    }
    
    rownames(net) <- rownames(data)
    
    net[net < input$con_weight] <- 0
    
    gr <- graph.adjacency(net, mode="undirected", diag = FALSE, weighted=TRUE)
    
    
    plot(gr)

  })
})
