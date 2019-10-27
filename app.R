# Spooky Shiny app!
# SB R-Ladies 2019-10-30
# Prepared by Allison Horst

library(shiny)
library(shinythemes)
library(tidyverse)
library(glue)

spooky <- read_csv("spooky_data.csv")

# Create the user interface:
ui <- fluidPage(
  theme = shinytheme("slate"),
  titlePanel("A spooky Shiny app!"),
  sidebarLayout(
    sidebarPanel("put my widgets here",
                 selectInput(inputId = "state_select",
                              label = "Choose state:",
                              choices = unique(spooky$state)
                 ),
                 radioButtons(inputId = "region_select",
                              label = "Choose a region:",
                              choices = unique(spooky$region_us_census))
                 ),
    mainPanel(h1("Happy Halloween!"),
              p("State's top candies:"),
              tableOutput(outputId = "candy_table"),
              p("Region's top costumes:"),
              plotOutput(outputId = "costume_graph")
              )
)
)

# Create the server:
server <- function(input, output) {

state_candy <- reactive({
    spooky %>%
      filter(state == input$state_select) %>%
    select(candy, pounds_candy_sold)
  })

region_costume <- reactive({
  spooky %>%
    filter(region_us_census == input$region_select) %>%
    count(costume, rank)

})

output$candy_table <- renderTable({
  state_candy()
})

output$costume_graph <- renderPlot({
  ggplot(region_costume(), aes(x = costume, y = n)) +
    geom_col(aes(fill = rank)) +
    coord_flip() +
    scale_fill_manual(values = c("black","purple","orange")) +
    theme_minimal()
})

}

# Combine them into an app:
shinyApp(ui = ui, server = server)

