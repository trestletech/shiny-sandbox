shinyUI(bootstrapPage(

  selectInput(inputId = "method",
      label = "Method to use to reconstruct the network:",
      choices = c("GeneNet"),
      selected = "GeneNet"),

  
  
  plotOutput(outputId = "main_plot", height = "600px"),

  # Display this only if the density is shown
  
  sliderInput(inputId = "con_weight",
        label = "Connection threshold:",
        min = 0.0, max = 1, value = .6, step = 0.1)
  

))
