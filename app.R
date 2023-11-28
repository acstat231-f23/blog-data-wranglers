library(shiny)
library(leaflet)
library(dplyr)

ui <- fluidPage(
  titlePanel("Sports Team Analysis"),
  selectInput("league", "Choose a League:", choices = c("NFL", "NHL", "NBA", "MLB")),
  selectInput("variable", "Select Variable:", choices = c("payroll", "win_percentage", "value")),
  leafletOutput("map")
)

server <- function(input, output) {
  
  data <- read.csv("wrangled_data.csv")
  
  filteredData <- reactive({
    data %>% filter(league == input$league)
  })
  
  output$map <- renderLeaflet({
    leaflet(filteredData()) %>%
      addTiles() %>%
      addCircleMarkers(
        lng = ~longitude, lat = ~latitude,
        popup = ~paste(team, "<br>", input$variable, ": ", get(input$variable))
      )
  })
}

shinyApp(ui = ui, server = server)
