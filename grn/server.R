shinyServer(function(input, output) {

  output$main_plot <- reactivePlot(function() {
    library(GeneNet)
    library(igraph)
    
    data <- matrix(rnorm(400, .5, .3), ncol=20)
    data[data < 0] <- 0
    data[data > 1] <- 1
    
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
