# Spooky Shiny app!
# SB R-Ladies 2019-10-30
# Prepared by Allison Horst

library(shiny)
library(shinythemes)
library(tidyverse)

spooky <- read_csv("spooky_data.csv")

# TESTING::::
costume_rank_test <- spooky %>%
    filter(costume == "Wonder Woman") %>%
    count(rank)

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
                 radioButtons(inputId = "costume_select",
                              label = "Choose a costume:",
                              choices = c("Wonder Woman", "Witch", "Clown"))
                 ),
    mainPanel(h1("Happy Halloween!"),
              p("Then some paragraph text."),
              tableOutput(outputId = "candy_table"),
              plotOutput(outputId = "costume_graph")
              )
)
)

# Create the server:
server <- function(input, output) {

# Make a reactive expression to filter the data based on the user-selected state
# That's input 'state_select'

state_candy <- reactive({
    spooky %>%
      filter(state == input$state_select)
  })

costume_ranks <- reactive({
  spooky %>%
    filter(costume == input$costume_select) %>%
    count(rank)
})

# OK, so when the input is selected, the data frame should only contain the observations for that state! & we'll use that subset to make a graph of candies...

output$candy_table <- renderTable({
  state_candy()
})

output$costume_graph <- renderPlot({
  ggplot(costume_ranks(), aes(x = rank, y = n)) +
    geom_col()
})

}

# Combine them into an app:
shinyApp(ui = ui, server = server)

