reactiveNetwork <- function (outputId) 
{
  HTML(paste("<div id=\"", outputId, "\" class=\"shiny-network-output\"><svg /></div>", sep=""))
}


googleAnalytics <- function(account="UA-36850640-1"){
  HTML(paste("<script type=\"text/javascript\">

    var _gaq = _gaq || [];
  _gaq.push(['_setAccount', '",account,"']);
  _gaq.push(['_setDomainName', 'rstudio.com']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

  </script>", sep=""))
}


shinyUI(pageWithSidebar(    
  headerPanel("Reconstruct Gene Networks"),
  
  sidebarPanel(
    #selectInput(inputId = "dataSource",
    #            label = "Source of the gene expression data:",
    #            choices = c("Local", "Remote"),
    #            selected = "Remote"),
    
    checkboxInput(inputId= "dataSource", label="Use a file stored on my local machine.", value=FALSE),
    
    conditionalPanel(
      condition = "input.dataSource == false",
      textInput(inputId="url", label="File URL:", value="./sampleExp.csv"),
      helpText(HTML("<div style=\"text-indent: 25px\">Download the sample dataset <a href=\"sampleExp.csv\">here</a></div>"))
    ),
    
    conditionalPanel(
      condition = "input.dataSource == true",            
      fileInput(inputId = "file", label="Network to reconstruct:"),
      helpText(HTML("<div style=\"color: red; font-weight: bold\">Warning:</div> Local file uploads in 
                    Shiny are <strong>very</strong> experimental. I have had success using this
                    feature from the latest version of Firefox but, at the time of writing, it
                    does not seem to be working from Chrome or IE.
                    <p>If you have trouble using this feature but want to analyze your own 
                    dataset, you can upload the file to a public URL using a tool like 
                    <a href=\"http://dropbox.com\">Dropbox</a> or one of the many free upload
                    sites."))
    ),
      
    HTML("<hr />"),
    
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
             will display more connections"),
    
    HTML("<hr />"),
    helpText(HTML("All source available on <a href = \"https://github.com/trestletech/shiny-sandbox/tree/master/grn\">Github</a>"))
  ),
  
  
  mainPanel(    
    includeHTML("graph.js"),
    reactiveNetwork(outputId = "mainnet") ,
    googleAnalytics()
  )
  
  

))
