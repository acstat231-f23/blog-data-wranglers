library(shiny)
library(leaflet)
library(dplyr)

ui <- fluidPage(
  titlePanel("Sports Team Analysis"),  # Title of the app
  selectInput("league", "Choose a League:", choices = c("NFL", "NHL", "NBA", "MLB")),  # Dropdown for selecting a league
  selectInput("variable", "Select Variable:", choices = c("Payroll" = "payroll", 
                                                          "Win Percentage" = "win_percentage", 
                                                          "Value" = "value")),  # Dropdown for selecting a variable to display
  leafletOutput("map")
)

server <- function(input, output) {
  
  # Read data
  data <- read.csv("wrangled_data.csv")
  
  # Rename Variables for popups
  variableNames <- c(payroll = "Payroll", win_percentage = "Win Percentage", value = "Value")
  
  filteredData <- reactive({
    data %>% filter(league == input$league)  # Filter data by selected league
  })
  
  # Show the map
  output$map <- renderLeaflet({
    leaflet(filteredData()) %>%
      addTiles() %>%
      addCircleMarkers(
        lng = ~longitude, lat = ~latitude,  # Set marker positions based on longitude and latitude
        radius = ~scales::rescale(get(input$variable), to = c(5, 15)),  # Adjust marker size based on selected variable
        popup = ~paste(team, "<br>", variableNames[[input$variable]], ": ", get(input$variable))  # Add popups with team info
      )
  })
}

shinyApp(ui = ui, server = server)