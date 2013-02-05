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
        
    path <- input$url
      
    #translate relative paths to server-friendly paths
    if (substr(input$url, 0, 2) == "./"){
      path <- paste("./www/", substring(input$url, 3), sep="")
    }      
       
    
    data <- read.csv(path, row.names=1)
    
    #ensure that each row is a gene.
    if (input$orientation == "Sample"){
      data <- t(data)
    }
    data
  })
  
  output$mainnet <- reactiveAdjacencyMatrix(function() {
    
    data <- data()
    
    if (input$method == "GeneNet"){      
      net <- buildGenenet(data)
      net <- abs(net)
    }
    
    net[net < input$con_weight] <- 0
    
    net

  })
})
