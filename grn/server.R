
library(igraph)
library(ENA)

reactiveAdjacencyMatrix <- function(func){
  reactive(function(){
    
    val <- func()
    
    if (is.null(val)){
      return(list(names=character(), links=list(source=-1, target=-1)))
    }
    
    #TODO: re-arrange columns if necessary
    if (!all(rownames(val) == colnames(val))){
      stop("Colnames and rownames of your matrix must be identical")
    }
    
    diag(val) <- 0
    
    #make the matrix symmetric
    val <- symmetricize(val, method="avg")
    
    #now consider only the upper half of the matrix
    val[lower.tri(val)] <- 0
    
    conns <- cbind(source=row(val)[val>0]-1, target=col(val)[val>0]-1, weight=val[val>0])
    
    if (nrow(conns) == 0){
      conns <- list (source=-1, target=-1, weight=0)
    }
    
    list(names=rownames(val), links=conns)
    
  })

}

shinyServer(function(input, output) {

  data <- reactive(function(){
    if (input$sampleData == TRUE){
      data <- t(read.csv("sampleExp.csv", header=TRUE, row.names=1))
      return(data)
    }
    
    df <- input$file
    path <- df$datapath     
    data <- read.csv(path, row.names=1)
    
    #ensure that each row is a gene.
    if (input$orientation == "Sample"){
      data <- t(data)
    }
    data
  })
  
  output$mainnet <- reactiveAdjacencyMatrix(function() {
  
    
    
    if (is.null(input$file) && input$sampleData == FALSE){
      return()
    }
    
    data <- data()
    
    if (input$method == "GeneNet"){      
      net <- buildGenenet(data)
      net <- abs(net)
    }
    
    net[net < input$con_weight] <- 0
    
    net

  })
})
