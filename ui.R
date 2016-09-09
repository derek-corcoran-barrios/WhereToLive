library(shiny)
library(raster)
library(rworldmap)
library(rgdal)
library(leaflet)
data("countriesCoarse")


shinyUI(fluidPage(
  
  titlePanel("Where should you live according to your climate preferences?"),
  
  
  sidebarLayout(
    sidebarPanel(
      h3("Select your climate preferences"),
      p("Using worldclim database, and knowing your climate prefeneces, you can now using this tool get an idea of where in the world you should live."),
      p("Just use the sliders to anwer the simple questions we ask and you will get a map together with a downloadable table of where the climate suits you."),
      selectInput(inputId = "degrees", label = "Temp units:", choices = 
                    c("Celcius"= "Celcius",
                      "Fahrenheit" = "Fahrenheit")),
      submitButton("Update View", icon("refresh")),
      conditionalPanel(condition = "input.degrees == 'Celcius'",
                       sliderInput(inputId = "MaxTempC",
                                   label = "What's the average maximum temperature you want to endure during the summer?",
                                   min = 0,
                                   max = 50,
                                   value = 30),
                       sliderInput(inputId = "MinTempC",
                                   label = "What's the average minimum temperature you want to endure during the winter?",
                                   min = -40,
                                   max = 60,
                                   value = 0),
                       sliderInput(inputId = "RangeTempC",
                                   label = "What's your prefered temperature range?",
                                   min = -10,
                                   max = 30,
                                   value = c(0, 20)),
                       sliderInput(inputId = "RangePPC",
                                   label = "What's your prefered precipitation range?",
                                   min = 0,
                                   max = 5000,
                                   value = c(0, 5000))),
      
      conditionalPanel(condition = "input.degrees == 'Fahrenheit'",
                       sliderInput(inputId = "MaxTempF",
                                   label = "What's the average maximum temperature you want to endure during the summer?",
                                   min = 0,
                                   max = 120,
                                   value = 90),
                       sliderInput(inputId = "MinTempF",
                                   label = "What's the average minimum temperature you want to endure during the winter?",
                                   min = -40,
                                   max = 60,
                                   value = 32),
                       sliderInput(inputId = "RangeTempF",
                                   label = "What's your prefered temperature range?",
                                   min = -40,
                                   max = 90,
                                   value = c(32, 70)),                       
                       sliderInput(inputId = "RangePPF",
                                   label = "What's your prefered precipitation range?",
                                   min = 0,
                                   max = 200,
                                   value = c(0, 200))),
      sliderInput(inputId = "Population",
                  label = "how big of a town do you want to live in (Population)?",
                  min = 0,
                  max = 20000000,
                  value = c(0, 20000000, by = 1)))
    ,
    
    # Show a plot of the generated distribution
    mainPanel(
      leafletOutput("map", width = "100%", height = 400),
      downloadButton('downloadPlot', 'Download Plot'),
      dataTableOutput("visFun"),
      downloadButton('downloadData', 'Download Table')
    )
  )
))