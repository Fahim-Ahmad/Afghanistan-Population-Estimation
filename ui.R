library(shinydashboard)
library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(data.table)

cso <- read.csv("Afghanistan Population Estimation.csv")
csow <- read.csv("Afghanistan Population Estimation, wide format.csv")
names(csow) <- c("Province","District","Type","1383", "1384", "1385", "1386", "1387", "1388", "1389", "1390", "1391", "1392", "1393", "1394", "1395", "1396")

ui <- dashboardPage( skin = "purple",
                     dashboardHeader(title = "Afghanistan Population Estimation, by province and district (1383-1396)", titleWidth = 700),
                     dashboardSidebar(
                       sidebarMenu(
                         menuItem("Plot", tabName = "onevar", icon = icon("line-chart")),
                         menuItem("data table", tabName = "twovar", icon = icon ("table")),
                         menuItem("Source code", icon = icon("cog", lib = "glyphicon"), 
                                  href = "https://github.com/Fahim-Ahmad/Afghanistan-Population-Estimation") 
                       ),
                       br(),
                       selectInput("var1", "Select province", choices = unique(cso$province), selected = "Kabul"),
                       radioButtons("pop", "", choices = c("Total Population", "Urban Population", "Rural Population"), selected = "Total Population"),
                       br()
                     ),
                     dashboardBody(
                       tabItems(
                         tabItem(tabName = "onevar", 
                                 fluidRow( plotlyOutput("plot")
                                 )),
                         
                         tabItem(tabName = "twovar" ,
                                 fluidRow( dataTableOutput("table")
                                 ))))
)
