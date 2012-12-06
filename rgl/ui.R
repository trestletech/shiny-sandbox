reactiveWebGL <- function (outputId) 
{
  HTML(paste("<div id=\"", outputId, "\" class=\"shiny-webgl-output\"></div>", sep=""))
}

shinyUI(pageWithSidebar(    
  headerPanel("WebGL Demo"),
  
  sidebarPanel(
    checkboxInput(inputId= "dataSource", label="Use a file stored on my local machine.", value=FALSE),
    HTML("<hr />"),
        
    HTML("<hr />"),
    helpText(HTML("All source available on <a href = \"https://github.com/trestletech/shiny-sandbox/tree/master/grn\">Github</a>"))
  ),
  
  
  mainPanel(        
    reactiveWebGL(outputId = "webGL"),
    tags$head(tags$script(src="rgl.js", type="text/javascript")),
    tags$head(tags$script(src="CanvasMatrix.js", type="text/javascript"))
  )
))
