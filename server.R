library(shiny)
library(UsingR)
data(ToothGrowth)

ToothGrowth$dose <- as.factor(ToothGrowth$dose)

shinyServer(function(input, output) {
    
  myXY <- reactive({
    paste("len ~", "as.integer(", input$inRadio,")")
  })
  
  myFit <- reactive({
    lm(as.formula(myXY()), data=ToothGrowth)
  })
   
  output$hist_plot <- renderPlot({
    hist(ToothGrowth$len,
         probability=TRUE,
         breaks=as.numeric(input$n_breaks),         
         xlab='tooth length', 
         col='lightblue',
         main='Histogram of Tooth Length')
    
    if (input$density=="Density") {
      dens <- density(ToothGrowth$len, adjust=input$bw_adjust)
      lines(dens, col="red")
    }
    
  })
  
  output$text <- renderText({   
    paste("Regression Model: ", "len ~", input$inRadio)
  })
  
  output$rg_plot <- renderPlot ({
    with(ToothGrowth, {plot(as.formula(myXY()), main="Regression Plot", xlab=input$inRadio, ylab="tooth length", col="blue")
                       abline(myFit(), col="red")
    })
  }) 
  
  output$doc <- renderText({   
    
    "Documentation:

    DATA EXPLORER application is used to perform exploratory data analysis on the ToothGrowth data set.
    
    1. \"Histogram\" tab: shows the tooth length distribution.
           - \"Select number of bins\": Select number of bins (10, 20, 35,or 50) for the histogram.
           - \"Show density estimate\": Select either to show the density plot in the histogram or not.
           - \"Adjust density bandwidth\": Shown only when \"Density\" is selected in the \"Show density estimate\".  
                                         Adjust the density bandwidth from 0.1 to 1.5 for the histogram.

    2. \"Plot\" tab: shows the linear regression models of length vs. supp and length vs. dose. 
           - \"Select predictor\": Select the predictor (\"supp\" or \"dose\") for the \"len\" outcome of
                                 the linear regression plot."    
    
  })  
  
})



