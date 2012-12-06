reactiveWebGL <- function (outputId) 
{
  HTML(paste("<div id=\"", outputId, "\" class=\"shiny-webgl-output\"></div>", sep=""))
}

getColorPalettes <- function(){
  #reach into RColor Brewer's var's to get the list of all the non-qualitative color palettes they offer
  c(RColorBrewer:::divlist,
    RColorBrewer:::seqlist)
}

shinyUI(pageWithSidebar(    
  headerPanel("WebGL Demo"),
  
  sidebarPanel(
    selectInput(inputId = "palette", label="Color Palette", choices=getColorPalettes()),
        
    checkboxInput(inputId= "PCA", label="Display principal components.", value=FALSE),
    conditionalPanel("input.PCA == true", 
      selectInput(inputId = "pcaCount", label="Principal components to display:", choices=1:3)
    ),
                
    HTML("<hr />"),
    helpText(HTML("All source available on <a href = \"https://github.com/trestletech/shiny-sandbox/tree/master/rgl\">Github</a>"))
  ),
  
  
  mainPanel(        
    reactiveWebGL(outputId = "webGL"),
    tags$head(tags$script(src="rgl.js", type="text/javascript")),
    tags$head(tags$script(src="CanvasMatrix.js", type="text/javascript"))
  )
))
