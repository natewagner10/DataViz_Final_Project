library(shiny)
library(shinydashboard)
library(readr)

filePath = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv"
dff10 <- read_csv(filePath) %>% filter(state == "Florida")
dashboardPage(
    dashboardHeader(title = "FL Covid-19"),
    dashboardSidebar(),
    dashboardBody(
        tabItems()
    )
)