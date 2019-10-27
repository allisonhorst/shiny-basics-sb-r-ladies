# Basics of building Shiny apps in R
### Santa Barbara R-Ladies meetup (2019-10-30)
Allison Horst

**Objectives:**

- Introduce general Shiny structure (ui + server)
- Create widgets for user selection
- Understand basics of reactivity (reactive inputs & rendered outputs)
- Build a reactive app

---------

### Requirements & Materials

- [Slides for this session](https://docs.google.com/presentation/d/1QVgvVsVoYOXjqHKKx2o-cMOYLdh7FAq8Hyv_y-dSZmI/edit?usp=sharing) 
- [Teaching key for this session](https://docs.google.com/document/d/1Je6tCd5ZFUCSa3ZG3gAsjLQBCdOFBbO1kzG06psKxJQ/edit?usp=sharing)

- **Required R packages:**

    - `tidyverse`
    - `shiny`
    - `shinythemes`

- **Data:**

    - `spooky_data.csv`

Data in `spooky_data.csv` are curated from two sources: 

1. Candy Store (candystore.com) data for 2019 [candy sales by state](https://www.candystore.com/blog/facts-trivia/halloween-candy-map-popular/).
2. Costume rankings by state (2017) from [Google Frightgeist](https://frightgeist.withgoogle.com/)



### Other resources

- [Mastering Shiny](https://mastering-shiny.org/) (in development) by Hadley Wickham 
- Introduction to [Building a Shiny app](https://deanattali.com/blog/building-shiny-apps-tutorial/) by Dean Attali
- Many useful tutorials and examples: https://shiny.rstudio.com/tutorial/
- Cool examples of what you can do with Shiny: https://shiny.rstudio.com/gallery/
- Click here for different [widget options](https://shiny.rstudio.com/gallery/widget-gallery.html)
