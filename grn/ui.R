shinyUI(bootstrapPage(

  selectInput(inputId = "method",
      label = "Method to use to reconstruct the network:",
      choices = c("GeneNet"),
      selected = "GeneNet"),

  fileInput(inputId = "file", label="Network to reconstruct:"),
  
  plotOutput(outputId = "main_plot", height = "500px"),

  verbatimTextOutput("debug"),
  
  sliderInput(inputId = "con_weight",
        label = "Connection threshold:",
        min = 0.0, max = 1, value = .25, step = 0.05)
  

))
