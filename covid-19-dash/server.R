library(shiny)
library(shinydashboard)
library(readr)
library(data.table)
shinyServer(function(input, output, session) {
    df_table <- reactiveFileReader(
        intervalMillis = 10000,
        session = session,
        filePath = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv",
        readFunc = fread)
    df_deaths <- reactiveFileReader(
        intervalMillis = 10000,
        session = session,
        filePath = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv",
        readFunc = fread)
    df_reovered <- reactiveFileReader(
        intervalMillis = 10000,
        session = session,
        filePath = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv",
        readFunc = fread)
    df_ann <- reactiveFileReader(
        intervalMillis = 10000,
        session = session,
        filePath = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv",
        readFunc = fread)
    df <- reactiveFileReader(
        intervalMillis = 10000, 
        session = session,
        filePath ='https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv',
        readFunc = fread)
    df_world <- reactiveFileReader(
        intervalMillis = 10000, 
        session = session,
        filePath ='https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv',
        readFunc = fread)
    country.pop <- reactiveFileReader(
        intervalMillis = 10000, 
        session = session,
        filePath ='https://raw.githubusercontent.com/datasets/population/master/data/population.csv',
        readFunc = fread)
    output$mydata <- renderDT({
        df <- df_table()
        df <- df %>% filter(state == 'Florida') %>% select(date, county,cases, deaths) %>% mutate(date=ymd(date))
        df <- df %>% filter(date == max(date)) %>% arrange(desc(cases))
        return(df)
    })
    tolisten <- reactive({
        list(input$day, input$County)
    })
    
   
})
