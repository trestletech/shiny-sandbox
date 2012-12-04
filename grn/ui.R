reactiveNetwork <- function (outputId) 
{
  HTML(paste("<div id=\"", outputId, "\" class=\"shiny-network-output\"><svg /></div>", sep=""))
}



shinyUI(pageWithSidebar(    
  headerPanel("Reconstruct Gene Networks"),
  
  sidebarPanel(
    selectInput(inputId = "dataSource",
                label = "Source of the gene expression data:",
                choices = c("Local", "Remote"),
                selected = "Remote"),
    
    conditionalPanel(
      condition = "input.dataSource == Remote",
      textInput(inputId="url", label="File URL:", value="./sampleExp.csv"),
      helpText(HTML("<div style=\"text-indent: 25px\">Download the sample dataset <a href=\"sampleExp.csv\">here</a></div>"))
    ),
    
    conditionalPanel(
      condition = "input.dataSource == Local",      
      fileInput(inputId = "file", label="Network to reconstruct:")      
    ),
      
    selectInput(inputId = "orientation",
                label="One row represents a single:",
                choices = c("Sample", "Gene"),
                selected = "Sample"),
    
    selectInput(inputId = "method",
        label = "Method to use to reconstruct the network:",
        choices = c("GeneNet"),
        selected = "GeneNet"),
  
    sliderInput(inputId = "con_weight",
                label = "Connection threshold:",
                min = 0.0, max = 1, value = .15, step = 0.05),
    
helpText("Use the slider to set the number of connections which 
             will be displayed in the graph. Higher, more stringent 
             thresholds will include fewer connections, while lower thresholds 
             will display more connections")
  ),
  
  mainPanel(    
    includeHTML("graph.js"),
    reactiveNetwork(outputId = "mainnet")    
  )
  
  

))
