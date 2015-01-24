library(shiny)

MASSIST<-read.csv("MASSIST_app.csv")
data<-MASSIST[,c(-1, -28)]

# Define the overall UI
shinyUI(
        
        # Set the layout
        fluidPage(
                
                # Give the page a title
                titlePanel("Survey Question Analysis"),
                
                # Generate a row with a sidebar
                sidebarLayout(      
                        
                        # Define the sidebar with multiple inputs
                        sidebarPanel(
                                p("This app generates a summary of uploaded survey data when each question is selected"),
                                selectInput("Question", "Question:", 
                                            choices=colnames(data), selected = colnames(data)[1]),
                                hr(),
                                checkboxInput(inputId = "table",
                                              label = strong("Show data table with frequency counts"),
                                              value = FALSE),
                                tableOutput("table"),
                                p("Use the Download Table button below to download the summary data for a question"),
                                downloadButton('downloadData', 'Download Table'),
                                hr(),
                                checkboxInput(inputId = "Grade",
                                              label = strong("Show grade distribution"),
                                              value = FALSE),
                                hr(),
                                helpText("Data collected in Fall 2014 (N =776)")
                        ,width=4),
                        
                        # Create a spot for the plots
                        mainPanel(
                                plotOutput("plot"),
                                plotOutput("grade")
                
                        )
                        
                )
        )
)