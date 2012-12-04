reactiveNetwork <- function (outputId) 
{
  HTML(paste("<div id=\"", outputId, "\" class=\"shiny-network-output\"><svg /></div>", sep=""))
}



shinyUI(pageWithSidebar(    
  headerPanel("Reconstruct Gene Networks"),
  
  sidebarPanel(
    checkboxInput(inputId="sampleData", label="Use Sample Data", value=TRUE),
    
    conditionalPanel(
      condition = "input.sampleData == false",      
      fileInput(inputId = "file", label="Network to reconstruct:"),      
      selectInput(inputId = "orientation",
          label="One row represents a single:",
          choices = c("Sample", "Gene"),
          selected = "Sample")
    ),
      
    selectInput(inputId = "method",
        label = "Method to use to reconstruct the network:",
        choices = c("GeneNet"),
        selected = "GeneNet"),
  
    sliderInput(inputId = "con_weight",
                label = "Connection threshold:",
                min = 0.0, max = 1, value = .25, step = 0.05)
  ),
  
  mainPanel(    
    includeHTML("graph.js"),
    reactiveNetwork(outputId = "mainnet"),
    verbatimTextOutput("debug")
  )
  
  

))
