reactiveWebGL <- function (outputId) 
{
  HTML(paste("<div id=\"", outputId, "\" class=\"shiny-webgl-output\"></div>", sep=""))
}

getColorPalettes <- function(){
  #reach into RColor Brewer's var's to get the list of all the color palettes they offer
  c(RColorBrewer:::divlist,                  
    RColorBrewer:::quallist,                  
    RColorBrewer:::seqlist)
}

shinyUI(pageWithSidebar(    
  headerPanel("WebGL Demo"),
  
  sidebarPanel(
    selectInput(inputId = "palette", label="Color Palette", choices=getColorPalettes()),
        
    checkboxInput(inputId= "firstPCA", label="Display the first principal component.", value=FALSE),
    checkboxInput(inputId= "firstPCA", label="Display the second principal component.", value=FALSE),
                
    HTML("<hr />"),
    helpText(HTML("All source available on <a href = \"https://github.com/trestletech/shiny-sandbox/tree/master/rgl\">Github</a>"))
  ),
  
  
  mainPanel(        
    reactiveWebGL(outputId = "webGL"),
    tags$head(tags$script(src="rgl.js", type="text/javascript")),
    tags$head(tags$script(src="CanvasMatrix.js", type="text/javascript"))
  )
))
