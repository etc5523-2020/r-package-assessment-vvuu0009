library(magrittr)
library(plotly)
library(DT)

ui <- fluidPage(
    titlePanel("ETC5523: Shiny Assessment"),
    mainPanel(
        h3("About this Application"),
        textOutput("about"),
        br(),
        textOutput("about2"),
        h3(textOutput("heading")),
        textOutput("section1"),
        br(),
        selectInput("type","Select the case type", choices = corona_cont$type, selected = "confirmed"),
        selectInput("continent", "Select the continent",choices = corona_cont$continent, selected = "Africa"),
        plotOutput("cases"),
        dataTableOutput("sumtab"),
        br(),
        h3("Line Graph Showing Cumulative Confirmed Coronavirus Cases of the Top 6 Countries"),
        textOutput("section2"),
        plotly::plotlyOutput("p1"),
        verbatimTextOutput("hover"),
        h3("Line Graph Showing Cumulative Confirmed Coronavirus Cases of the Top Countries excluding the US"),
        textOutput("section3"),
        plotly::plotlyOutput("p2"),
        br(),
        h3("Cumulative Case Numbers by Country as at 31st July 2020"),
        textOutput("tab"),
        dataTableOutput("table"),
        h3("References"),
        br(),
        textOutput("refs"),
        br(),
        tableOutput("ref")
        
    ),
    includeCSS("styles.css")
)

server <- function(input, output) {
    
    output$about <- renderText({
        "Coronavirus disease (COVID-19) is an infectious disease caused by a newly discovered coronavirus (WHO, 2020) first reported in December 2019 in Wuhan City in China (AGDOH, 2020) Currently there are no specific vaccines or treatments for the disease, (AGDOH, 2020) causing many countries to enter quarantines and lockdowns to prevent the spread of the disease. 
        For the purposes of analysis I have chosen to assess the state of coronavirus across different continents and the top few countries as at the July 31st 2020."
    })
    
    output$about2 <- renderText({
        "Data has been taken from the coronavirus package from Github (Krispin and Byrnes, 2020) which contains data pulled from the Johns Hopkins University Center for Systems Science and Engineering (JHU CCSE) Coronavirus repository which aggregates data from sources such as the World Health Organization and European Center for Disease Prevention and Control (Krispin and Byrnes, 2020). 
        Data from the coronavirus package contains tabular data with dates, locations, case numbers and case type included daily confirmed, death and recovered."
    })
    
    output$heading <- renderText({
        paste("Line Graph Showing Daily", input$type, "Coronavirus Cases by Continent -", input$continent)
    })
    
    output$cases <- renderPlot({
        
        plot1 <- corona_cont %>%
            dplyr::filter(type == input$type) %>%
            dplyr::filter(continent == input$continent) %>%
            ggplot2::ggplot(aes(x = date, 
                                y = cases,
                                colour = continent)) +
            ggplot2::geom_line(color = "yellow") +
            ggplot2::theme(axis.title.x = element_text(margin = margin(t = 1)),
                           panel.grid.major = element_line(colour = "white", size = 0.1, linetype = "dashed"),
                           panel.grid.minor = element_line(colour = "white", size = 0.1, linetype = "dashed"),
                           legend.position = "none",
                           panel.background = element_rect(fill = "black"),
                           plot.background = element_rect(fill = "black", color = NA),
                           text = element_text(color = "white"),
                           axis.line = element_line(color = "white"),
                           axis.text = element_text(color = "white")) +
            ggplot2::labs(x = "Date",
                          y = paste("Daily", input$type , "Cases"))
        
        plot1 
    })
    
    output$sumtab <- renderDataTable({
        
        tab2 %>%
            dplyr::filter(continent == input$continent)%>% 
            DT::datatable( options = list(columnDefs = list(list(
                    className = 'dt-right', targets = c(2,3,4)
                )))) %>% 
            DT::formatStyle(columns = c(0,1,2,3,4,5), color = "white", backgroundColor = "black") %>%
            DT::formatStyle(columns = paste("Total", input$type), color = "white", backgroundColor = "grey")
        
        

    })
    
    output$p1 <- renderPlotly({
        
        p1
    })
    
    output$hover <- renderPrint({
        event_data("plotly_hover")
    })
    
    output$p2 <- renderPlotly({
        
        p2
    })
    
    output$table <- renderDataTable({
        
        tab
    })
    
    output$section1 <- renderText({
        "Below displays the line graph showing the daily coronavirus cases by each continent. 
        The case type and continent displayed wihtin the linegraph can be changed by using the input selector.
        To further compliment the graph data tables are displayed below showing the cumulative cases for the continent selected with the case type column highlighted.
        From the graph and table the Americas clearly has the highest trend in confirmed cases which is still trending upwards as at 31 July.
        Oceania clearly as the lowest counts across all categories, however, this category only has 4 countries compared to the 30-50 countries in eachother continent.
        Another intersting point to note from the Europe daily confirmed cases, we see a downward trend in cases during April but subsequently a pick up in mid Junesuggesting a second wave."
    })
    
    output$section2 <- renderText({
        "The plotly displays the linegraphs for the cumulative coronavirus cases for the 6 countries with the most cases as at 31 July 2020. From the plotly we can clearly see the US has highest cumulative cases across the whole period.
        In fact, in late June we see a significant pick up in cases showing the US has not currently managed to control the spread of cases also. 
        Notably we see in late June Brazil and India sees a significant pickup in cases. 
        The other three countries show significant counts in cases, however, it is hard to view their trends being overshadowed by the large levels of case numbers in the US."
    })
    
    output$section3 <- renderText({
        "To better view the trends across the top countries cumulative confirmed cases, the same plot has been produced restricted the time period from April onwards given the low levels appearing before April.
        Further, the US has been removed to better view the other 5 countries trends. From the plot we can see the trend in Russia and Mexico appear fairly stable. 
        Across the other 3 countries we see a sharpening increase in cases from mid June showing the lack of control over spread." 
    })
    
    output$tab <- renderText({
        "The table below shows the cumulative confirmed, death and recovered coronavirus cases as at 31st July 2020 for each country. 
        From the table we can clearly see the US has the highest total confirmed and death cases being significantly hiehgt than all other countries.
        Relatively, Australia has significantly lower case number ranking 69th in total confirmed cases as at 31st July. 
        However, updating to more recent figures may show different results given the recent spikes in Australian cases from their second wave."
    })
    
    output$refs <- renderText({
        "The following packages have been used to create this application Krispin and Byrnes (2020) Wickham et al. (2019) Sievert (2020) Arel-Bundock, Enevoldsen, and Yetman (2018) Zhu (2020) Xie, Cheng, and Tan (2020) Chang et al. (2020)"
    })
    
    output$ref <- renderTable(
        reftab
    )
    
}

shinyApp(ui = ui, server = server)
