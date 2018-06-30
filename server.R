library(shinydashboard)
library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(data.table)

cso <- read.csv("Afghanistan Population Estimation.csv")
csow <- read.csv("Afghanistan Population Estimation, wide format.csv")
names(csow) <- c("Province","District","Type","1383", "1384", "1385", "1386", "1387", "1388", "1389", "1390", "1391", "1392", "1393", "1394", "1395", "1396")

server<- shinyServer(function(input, output) {
  
  output$plot1 <- renderPlotly(
    ggplotly(cso %>% filter(province==input$var1) %>% ggplot(aes(x=year, y=total_both, color=district)) + geom_line() +ylab("Total Population") + xlab("") +scale_x_continuous(breaks=c(seq(1383,1396,by=1))))        
  )
  output$plot <- renderPlotly(
    
    if (input$pop == "Total Population") {
      ggplotly(cso %>% filter(province==input$var1) %>% ggplot(aes(x=year, y=total_both, color=district)) + geom_line() +ylab("") + xlab("") +scale_x_continuous(breaks=c(seq(1383,1396,by=1))))        
    } else if (input$pop == "Urban Population"){
      ggplotly(cso %>% filter(province==input$var1) %>% ggplot(aes(x=year, y=urban_total, color=district)) + geom_line() +ylab("") + xlab("") +scale_x_continuous(breaks=c(seq(1383,1396,by=1))))
    } else if (input$pop == "Rural Population") {
      ggplotly(cso %>% filter(province==input$var1) %>% ggplot(aes(x=year, y=rural_total, color=district)) + geom_line() +ylab("") + xlab("") +scale_x_continuous(breaks=c(seq(1383,1396,by=1))))
    }
  )
  
  output$table <- renderDataTable(
    data.table(csow)
  )
})
