# Spooky Shiny app!
# SB R-Ladies 2019-10-30
# Prepared by Allison Horst

library(shiny)
library(tidyverse)

scary_data <- read_csv("costume_candy.csv")

top_costumes <- scary_data %>%
  count(costume_rank1) %>%
  arrange(-n)

# Create the user interface:
ui <- fluidPage(
  titlePanel("A spooky Shiny app!"),
  sidebarLayout(
    sidebarPanel("put my widgets here",
                 radioButtons(inputId = "region",
                              label = "Choose region in US",
                              choices = unique(scary_data$region_us_census)
                 )
                 ),
    mainPanel("put my graph here")
  )
)

# Create the server:
server <- function(input, output) {}

# Combine them into an app:
shinyApp(ui = ui, server = server)

