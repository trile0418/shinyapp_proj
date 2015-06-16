library(shiny)
library(UsingR)
data(ToothGrowth)

shinyServer(function(input, output) {

  myXY <- reactive({
    paste("len ~", "as.integer(", input$inRadio,")")
  })
  
  myFit <- reactive({
    lm(as.formula(myXY()), data=ToothGrowth)
  })  

  myFit2 <- reactive({
    t.test(as.formula(myXY()), paired=F, var.equal=F, data=dat)
  })  
    
  output$hist_plot <- renderPlot({
    hist(ToothGrowth$len,
         probability=TRUE,
         breaks=as.numeric(input$n_breaks),         
         xlab='tooth length', 
         col='lightblue',
         main='Histogram of Tooth Length')
    
    if (input$density) {
      dens <- density(ToothGrowth$len, adjust=input$bw_adjust)
      lines(dens, col="red")
    }
      
  })
     
  output$text <- renderText({   
    paste("Regression Model: ", "len ~", input$inRadio)
  })
  
  output$rg_plot <- renderPlot ({
    with(ToothGrowth, {plot(as.formula(myXY()), xlab=input$inRadio, ylab="tooth length", col="blue")
                abline(myFit(), col="red")
    })
  })  
     
})


