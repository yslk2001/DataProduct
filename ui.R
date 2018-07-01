#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)


shinyUI(fluidPage(
  
  #  title of this shiny APP
        
        
  titlePanel(title = h2("Developing a Shiny App -- CO2 uptake rate predication", align = "center")),
  
  # select input  
  sidebarLayout(
          sidebarPanel(
                helpText("This App predicts the CO2 uptake rate using the information 
                          given below, based on the prediction model of CO. In order to get the prediction of CO2 update rate, 
                          you will need to select the different value/category from the 
                          following factors."),
                h3(helpText("Please Select:")),
                
                numericInput("conc", label = h4("Conc"), 250, min= 0, max= 1000, step = 250),   

                selectInput("Plant", label = h4("Plant"), 
                            choices = list (   "Qn1", "Qn2",
                     "Qn3", "Mc1","Mc2", "Mc3" ) ),
                                           
                 selectInput("Treatment" , label = h4("Treatment"), 
                             choices = list("nonchilled"= "nonchilled", "chilled" = "chilled" ))

                           ),



mainPanel(
h3("You have chosen: "),
h4(textOutput("conc")),
h4(textOutput("Plant")),
h4(textOutput("Treatment")),
br(),
br(),
plotOutput("distPlot"),
h3("Predicted CO2 uptake rate:"),
h4(textOutput("result"))
)

)
))

