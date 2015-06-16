setwd("D:/Downloads/DataScience/Coursera/Developing_Data_Products/Rcodes/Project")

library(shiny)
shinyUI(fluidPage(
  
  headerPanel("Tooth Length vs. Vitamin C: Data Explorer"),
  
  br(), br(), br(),
  
  plotOutput(outputId="hist_plot"),
    
  br(),
 
  fluidRow(
    column(3,
      selectInput(inputId="n_breaks",
                  label="Select number of bins in histogram:",
                  choices=c(10, 20, 35, 50), selected = 20)
    ),    
    column(3,
      checkboxInput(inputId="density", label=strong("Show density estimate"), value=TRUE)
    ),
    column(4,
      # Display this only if the density is shown
      conditionalPanel(condition = "input.density == TRUE",
                       sliderInput(inputId="bw_adjust",
                       label="Adjust density bandwidth:",
                       value=0.5, min=0, max=2, step=0.05)
      )
    )    
  ),
  
  br(), hr(), br(),

  h4(textOutput('text')),
  plotOutput('rg_plot'),   
          
  radioButtons("inRadio", "Select predictor:",
               c("supp" = "supp",
                 "dose" = "dose")
  )

           
))

