library(shiny)
library(dplyr)
library(plotly)

ui <- fluidPage(

    titlePanel("Harjoitustehtävä kurssille DevOpsWithDocker"),
    
    plotlyOutput("performancePlot")
    
)

server <- function(input, output) {

    output$performancePlot <- renderPlotly({
        data_large <- read.csv(url("https://query1.finance.yahoo.com/v7/finance/download/^GSPC?period1=1559308065&period2=1590930465&interval=1d&events=history"))
        
        data_small <- read.csv(url("https://query1.finance.yahoo.com/v7/finance/download/^RUT?period1=1559308065&period2=1590930465&interval=1d&events=history"))
        
        data <- data_large %>%
            select(Date, Close) %>%
            rename(LargeCap = Close) %>%
            inner_join(data_small, by = "Date") %>%
            rename(SmallCap = Close) %>%
            select(Date, LargeCap, SmallCap) %>%
            filter(Date >= "2019-12-31") %>%
            na.omit()
        
        data <- data %>%
            mutate(LargeCap = LargeCap / data$LargeCap[1] * 100) %>%
            mutate(SmallCap = SmallCap / data$SmallCap[1] * 100)
        
        plot_ly(type = 'scatter', x= ~data$Date, y= ~data$LargeCap, mode='lines', name = 'Suuret yhtiöt') %>%
            add_trace(y = ~data$SmallCap, name = 'Pienet yhtiöt',mode = 'lines') %>%
            layout(title = "Pienten ja suurten yhtiöiden tuotto",
                   xaxis = list(title = "Aika"),
                   yaxis = list (title = "Indeksoitu tuotto"))
    })
    
}

shinyApp(ui = ui, server = server)
