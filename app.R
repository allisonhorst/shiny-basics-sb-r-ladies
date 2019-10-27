# Spooky Shiny app!
# SB R-Ladies 2019-10-30
# Prepared by Allison Horst

library(tidyverse)
library(shiny)
library(shinythemes)

spooky <- read_csv("spooky_data.csv")

ui <- fluidPage(
  theme = shinytheme("slate"),
  titlePanel("I am adding a title!"),
  sidebarLayout(
    sidebarPanel("put my widgets here",
                 selectInput(inputId = "state_select",
                             label = "Choose a state:",
                             choices = unique(spooky$state)
                 ),
                 radioButtons(inputId = "region_select",
                              label = "Choose region:",
                              choices = unique(spooky$region_us_census))
    ),
    mainPanel("put my outputs here",
              p("State's top candies:"),
              tableOutput(outputId = "candy_table"),
              p("Region’s top costumes:"),
              plotOutput(outputId = "costume_graph")
    )
  )
)

server <- function(input, output) {

# Create reactive object state_candy that changes based on state_select widget selection
  state_candy <- reactive({
    spooky %>%
      filter(state == input$state_select) %>%
      select(candy, pounds_candy_sold)
  })

# Render a reactive table that uses state_candy reactive object (and note the parentheses after state_candy -- do that if calling a reactive object!)
  output$candy_table <- renderTable({
    state_candy()
  })

# Create a reactive object region_costume that only contains observations for the region selected in the region_select widget, then finds counts by costume & rank
  region_costume <- reactive({
    spooky %>%
      filter(region_us_census == input$region_select) %>%
      count(costume, rank)
  })

# Render a reactive graph with the counts of top costumes for each region:
  output$costume_graph <- renderPlot({
    ggplot(region_costume(), aes(x = costume, y = n)) +
      geom_col(aes(fill = rank)) +
      coord_flip() +
      scale_fill_manual(values = c("black","purple","orange")) +
      theme_minimal()
  })
}

# Put them together!
shinyApp(ui = ui, server = server)
