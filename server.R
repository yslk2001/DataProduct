#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
# http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)

diam <- CO2 
# Define server logic required to draw a plot
shinyServer(function(input, output) {
        
  # the user's choice
        
        output$Plant <- renderText({ 
                paste("Plant: ", input$Plant)
        })
        output$conc <- renderText({ 
                paste("CONC: ", input$conc)
        })
        output$Treatment <- renderText({ 
                paste("Treatment: ", input$Treatment)
        })
        
        output$distPlot <- renderPlot({
               
                d  <- filter(CO2, grepl(input$Plant, Plant), grepl(input$Treatment, Treatment), grep(input$conc, conc))
                # build linear regression model
                fit <- lm( uptake~conc, d )
                # predict the CO2 uptake rate
                pred <- predict(fit, newdata = data.frame(conc = input$conc,
                                                          Plant= input$Plant,
                                                          Treatment = input$Treatment
                ))
                # Draw the plot using ggplot2
                p <- ggplot(data=d , aes(x=conc, y = uptake))+
                        geom_point(aes(Plant = Plant), alpha = 0.1)+
                        geom_smooth(method = "lm")+
                        geom_vline(xintercept = input$conc, color = "red")+
                        geom_hline(yintercept = pred, color = "yellow")
                p
        })
        output$result <- renderText({
                # render the text for the prediction 
                d  <- filter(CO2, grepl(input$Plant, Plant), grepl(input$Treatment, Treatment))
                fit <- lm( uptake~conc, d )
                pred <- predict(fit, newdata = data.frame(conc = input$conc,
                                                          Plant = input$Plant,
                                                         Treatment = input$Treatment ))
                
                result <- paste(round(pred, digits = 2) )
                result
        })
        
})

