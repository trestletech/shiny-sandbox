shinyServer(function(input, output) {
  
  output$debug <- reactivePrint(function(){"test"})
  
  output$main_plot <- reactivePlot(function() {
  
    library(GeneNet)
    library(igraph)
    
    
    if(!is.null(input$file)){
      plot.window(xlim=0:1, ylim=0:1)
      text(.5, .5, "You must upload data before we can display it.")
      return()  
    }
    
    #df <- input$file
    #path <- df$datapath     
    data <- read.csv("/home/qbrc/data.csv", row.names=1)
    
    for (i in 1:5){
      colA <- round(runif(1, 1,nrow(data)))
      colB <- round(runif(1, 1,nrow(data)))
      data[,colA] <- data[,colB] * 2
    }
    
    colnames(data) <- rownames(data) <- LETTERS[1:20]
    
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
