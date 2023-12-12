library(shiny)
library(leaflet)
library(dplyr)

ui <- fluidPage(
  titlePanel("Sports Team Analysis"),
  selectInput("league", "Choose a League:", choices = c("NFL", "NHL", "NBA", "MLB")),
  selectInput("variable", "Select Variable:", choices = c("Payroll" = "payroll", 
                                                          "Win Percentage" = "win_percentage", 
                                                          "Value" = "value")),
  leafletOutput("map")
)

server <- function(input, output) {
  
  data <- read.csv("wrangled_data.csv")
  
  variableNames <- c(payroll = "Payroll", win_percentage = "Win Percentage", value = "Value")
  
  filteredData <- reactive({
    data %>% filter(league == input$league)
  })
  
  output$map <- renderLeaflet({
    leaflet(filteredData()) %>%
      addTiles() %>%
      addCircleMarkers(
        lng = ~longitude, lat = ~latitude,
        radius = ~scales::rescale(get(input$variable), to = c(5, 15)),
        popup = ~paste(team, "<br>", variableNames[[input$variable]], ": ", get(input$variable))
      )
  })
}

shinyApp(ui = ui, server = server)
