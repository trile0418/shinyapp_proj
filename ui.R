library(shiny)
library(markdown)

shinyUI(navbarPage("DATA EXPLORER",
  tabPanel("Histogram",                 
    sidebarPanel(
      br(),
      selectInput(inputId="n_breaks", label="Select number of bins:",
                  choices=c(10, 20, 35, 50), selected = 20),    
      br(),      
      radioButtons(inputId="density", label=("Show density estimate:"), 
                   c("Density" = "Density", "No Density" = "No Density")),
      br(),
      # Display this only if the density is shown
      conditionalPanel(condition='input.density == "Density"',
                       sliderInput(inputId="bw_adjust", label="Adjust density bandwidth:",
                                   value=0.5, min=0.1, max=1.5, step=0.05))
    ),    
    mainPanel(    
      plotOutput(outputId="hist_plot")    
    )  
  ),

  tabPanel("Plot",     
    sidebarPanel(
      br(),
      radioButtons(inputId="inRadio", label="Select predictor:", c("supp" = "supp", "dose" = "dose"))    
    ),    
    h4(textOutput('text')),
    mainPanel(  
      plotOutput('rg_plot')   
    )
  ),
  
  tabPanel("Documentation",     
    verbatimTextOutput('doc')
  )
  
  
  
  
  
  
  

))

