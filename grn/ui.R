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
      function get2DArray(size) {
          size = size > 0 ? size : 0;
          var arr = [];
      
          while(size--) {
              arr.push([]);
          }
      
          return arr;
      }

      //convert data to 2d array
      d2 = get2DArray(data.names.length);
      
      var curRow = 0;
      for (var i = 0; i < data.data.length; i++){
        d2[curRow].push(data.data[i]);
        if (d2[curRow].length == data.names.length){
          curRow++;
        }
      }

      data.data = d2;

      $(el).text(data.names);
    }
  });
  Shiny.outputBindings.register(networkOutputBinding, 'trestletech.networkbinding');</script>"),
    reactiveNetwork(outputId = "main_net"),
    verbatimTextOutput("debug")
  )
  
  

))
