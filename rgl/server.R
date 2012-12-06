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

#' Computes the proportion of variance explained by the given number 
#' of principal components
#' @param pca the input matrix
#' @param components the number of components
#' @return the proportion of variance explained 
propVar <- function(pca, components=1){
  #proportion of variance explained by the given number of components
  pv <- pca$sdev^2/sum(pca$sdev^2)[1]
  return(sum(pv[1:components]))
}

#' Calculates the principal components of the given matrix. Has the side-effect
#' of plotting these components on the open RGL device.
#' @param matrix The input matrix
#' @param pca the number of principal components to compute
#' @return the proportion of variance for the computed PCs
calcPCA <- function(matrix, pca=1){
  #from Hans Borchers, http://r.789695.n4.nabble.com/Fit-a-3-Dimensional-Line-to-Data-Points-td863596.html
  N <- nrow(matrix)
  
  meanX <- apply(matrix, 2, mean)
  Xpca <- princomp(matrix)
  
  endpts <- list()
  for (pc in 1:pca){
    dirVector <- Xpca$loadings[, pc]
    t <- c(min(Xpca$score[, pc])-.2, max(Xpca$score[, pc])+.2)
    endpts[[pc]] <- rbind(meanX + t[1]*dirVector, meanX + t[2]*dirVector)
  }
  
  for (pc in 1:pca){
    plot3d(endpts[[pc]][,1], endpts[[pc]][,2], endpts[[pc]][,3], type="l", add=TRUE, aspect=FALSE)
  }
  
  pv <- propVar(Xpca, pca)
  pv  
}

shinyServer(function(input, output) {
  palette <- reactive(function(){
    #load the selected palette
    pal <- brewer.pal(9, input$palette)
    
    #divide into RGB channels
    rgb <- hex2RGB(pal)@coords * 255    
    
    rgb
  })
  
  output$r2 <- reactiveText(function() {
    rgb <- palette()
    #plot and compute the PCs, if desired
    if (input$PCA){
      r2 <- calcPCA(rgb, input$pcaCount)
    } else{
      r2 <- 0
    }
    paste("R2 value: ", format(r2, digits=4))
  })
  
  output$webGL <- reactiveWebGL(function() {
    rgb <- palette()
    
    plot3d(rgb, col=hex(RGB(rgb/255)), type="l", xlab="Red", ylab="Green", zlab="Blue")
    
    #plot and compute the PCs, if desired
    if (input$PCA){
      calcPCA(rgb, input$pcaCount)
    }
    
  })
})
