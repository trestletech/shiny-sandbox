reactiveNetwork <- function (outputId) 
{
  pre(id = outputId, class = "shiny-network-output")
}



shinyUI(pageWithSidebar(    
  headerPanel("Reconstruct Gene Networks"),
  
  sidebarPanel(
    fileInput(inputId = "file", label="Network to reconstruct:"),
    
    selectInput(inputId = "method",
        label = "Method to use to reconstruct the network:",
        choices = c("GeneNet"),
        selected = "GeneNet"),
  
    sliderInput(inputId = "con_weight",
                label = "Connection threshold:",
                min = 0.0, max = 1, value = .25, step = 0.05)
  ),
  
  mainPanel(    
    HTML("<script type=\"text/javascript\">var networkOutputBinding = new Shiny.OutputBinding();
  $.extend(networkOutputBinding, {
    find: function(scope) {
      return $(scope).find('.shiny-network-output');
    },
    renderValue: function(el, data) {
      $(el).text(data);
    }
  });
  Shiny.outputBindings.register(networkOutputBinding, 'trestletech.networkbinding');</script>"),
    reactiveNetwork(outputId = "main_net"),
    verbatimTextOutput("debug")
  )
  
  

))
