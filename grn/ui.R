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
    textInput(inputId="url", label="File URL:", value="./sampleExp.csv"),
    helpText(HTML("<div style=\"text-indent: 25px\">Unfortunately, Shiny isn't playing nicely with file uploads at the time of writing, so I've disabled the custom file uploads temporarily. However, you can post your expression file online using any one of the free file hosting sites now available and provide the URL here to process it in this app! <p>You can also download the sample dataset <a href=\"sampleExp.csv\">here</a>.</div>")),
          
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
