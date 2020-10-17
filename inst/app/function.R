library(magrittr)

#Data
data("coronavirus")
  
#Wrangling 
corona_cont <- coronavirus %>%
  dplyr::mutate(continent = countrycode::countrycode(sourcevar = country, 
                                 origin = "country.name",
                                 destination = "continent")) %>%
  dplyr::group_by(date,continent,type) %>%
  dplyr::summarise(cases = sum(cases)) %>%
  tidyr::drop_na()

cum <- coronavirus %>%
  dplyr::filter(type == "confirmed") %>%
  dplyr::group_by(country, date) %>%
  dplyr::summarise(cases = sum(cases)) %>%
  dplyr::group_by(country) %>%
  dplyr::mutate('total confirmed' = cumsum(cases))

tab <- coronavirus %>%
  dplyr::group_by(date,country,type) %>%
  dplyr::summarise(cases = sum(cases)) %>%
  tidyr::pivot_wider(names_from = type,
              values_from = cases) %>%
  dplyr::group_by(country) %>%
  dplyr::mutate('Total Confirmed' = cumsum(confirmed),
         'Total Deaths' = cumsum(death),
         'Total Recovered' = cumsum(recovered)) %>%
  dplyr::filter(date == "2020-07-31") %>%
  dplyr::select(-date,-confirmed,-death,-recovered) %>%
  dplyr::arrange(-`Total Confirmed`) %>%
  dplyr::rename(Country = country) %>%
  dplyr::mutate(`Total Confirmed`= as.numeric(`Total Confirmed`),
         `Total Deaths` = as.numeric(`Total Deaths`),
         `Total Recovered` = as.numeric(`Total Recovered`)) %>%
  dplyr::mutate(`Total Confirmed`= scales::comma(`Total Confirmed`,1),
         `Total Deaths` = scales::comma(`Total Deaths`,1),
         `Total Recovered` = scales::comma(`Total Recovered`,1)) %>%
  DT::datatable( 
              options = list(columnDefs = list(list(
                className = 'dt-right', targets = c(2,3,4)
              )))) %>% 
  DT::formatStyle(columns = c(0,1,2,3,4), color = "white", backgroundColor = "black")

tab2 <- coronavirus  %>% group_by(date,country,type) %>%
  dplyr::summarise(cases = sum(cases)) %>%
  tidyr::pivot_wider(names_from = type,
              values_from = cases) %>%
  dplyr::group_by(country) %>%
  dplyr::mutate('Total confirmed' = cumsum(confirmed),
         'Total death' = cumsum(death),
         'Total recovered' = cumsum(recovered)) %>%
  dplyr::filter(date == "2020-07-31") %>%
  dplyr::select(-date,-confirmed,-death,-recovered) %>%
  dplyr::arrange(-`Total confirmed`) %>%
  dplyr::rename(Country = country) %>%
  dplyr::mutate(`Total confirmed`= scales::comma(`Total confirmed`,1),
         `Total death` = scales::comma(`Total death`,1),
         `Total recovered` = scales::comma(`Total recovered`,1))%>% 
  dplyr::mutate(continent = countrycode::countrycode(sourcevar = Country, 
                                 origin = "country.name",
                                 destination = "continent")) 



p1_data <- cum %>%
  dplyr::filter(country %in% c("US","Brazil","India","Russia","South Africa","Mexico")) 

p1_data$country <- p1_data$country %>% factor(levels = c("US","Brazil","India","Russia","South Africa","Mexico"))

reftab <- tibble::tibble(References = c("Arel-Bundock, Vincent, Nils Enevoldsen, and CJ Yetman. 2018. “Countrycode: An R Package to Convert Country Names and Country Codes.” Journal of Open Source Software 3 (28): 848. https://doi.org/10.21105/joss.00848.", 
                                "Chang, Winston, Joe Cheng, JJ Allaire, Yihui Xie, and Jonathan McPherson. 2020. Shiny: Web Application Framework for R. https://CRAN.R-project.org/package=shiny.",
                                "Krispin, Rami, and Jarrett Byrnes. 2020. Coronavirus: The 2019 Novel Coronavirus Covid-19 (2019-nCoV) Dataset. https://CRAN.R-project.org/package=coronavirus.",
                                "Sievert, Carson. 2020. Interactive Web-Based Data Visualization with R, Plotly, and Shiny. Chapman; Hall/CRC. https://plotly-r.com.",
                                "Wickham, Hadley, Mara Averick, Jennifer Bryan, Winston Chang, Lucy D’Agostino McGowan, Romain François, Garrett Grolemund, et al. 2019. “Welcome to the tidyverse.” Journal of Open Source Software 4 (43): 1686. https://doi.org/10.21105/joss.01686.",
                                "Xie, Yihui, Joe Cheng, and Xianying Tan. 2020. DT: A Wrapper of the Javascript Library ’Datatables’. https://CRAN.R-project.org/package=DT.",
                                "Zhu, Hao. 2020. KableExtra: Construct Complex Table with ’Kable’ and Pipe Syntax. https://CRAN.R-project.org/package=kableExtra.",
                                "Health, Australian Government Department of. 2020. “What You Need to Know About Coronavirus (Covid-19).” Australian Government Department of Health. Australian Government Department of Health. https://www.health.gov.au/news/health-alerts/novel-coronavirus-2019-ncov-health-alert/what-you-need-to-know-about-coronavirus-covid-19.",
                                "“Coronavirus.” n.d. World Health Organization. World Health Organization. https://www.who.int/health-topics/coronavirus#tab=tab_1."
))

p1 <- p1_data %>%
  ggplot2::ggplot(aes(x = date,
             y = `total confirmed`,
             colour = country)) +
  ggplot2::geom_line() +
  ggplot2::scale_color_manual(breaks = c("US","Brazil","India","Russia","South Africa", "Mexico"),
                     values = c("yellow","purple", "cyan4", "darkorange", "red", "blue")) +
  ggplot2::theme(axis.title.x = element_text(margin = margin(t = 25)),
        panel.background = element_rect(fill = "transparent"),
        plot.background = element_rect(fill = "transparent", color = NA),
        legend.background = element_rect(fill = "transparent"),
        text = element_text(color = "white"),
        axis.line = element_line(color = "white"),
        axis.text = element_text(color = "white")) +
  ggplot2::labs(y = "Cumulative Coronavirus Cases",
       x = "Date")


p2 <- p1_data %>%
  dplyr::filter(country %in% c("Brazil","India","Russia","South Africa", "Mexico")) %>%
  dplyr::filter(date <= "2020-06-30" & date >= "2020-04-01") %>%
  ggplot2::ggplot(aes(x = date,
             y = `total confirmed`,
             colour = country)) +
  ggplot2::geom_line() +
  ggplot2::scale_color_manual(breaks = c("Brazil","India","Russia","South Africa", "Mexico"),
                     values = c("purple", "cyan4", "darkorange", "red", "blue")) +
  ggplot2::theme(axis.title.x = element_text(margin = margin(t = 25)),
        panel.background = element_rect(fill = "transparent"),
        plot.background = element_rect(fill = "transparent", color = NA),
        legend.background = element_rect(fill = "transparent"),
        text = element_text(color = "white"),
        axis.line = element_line(color = "white"),
        axis.text = element_text(color = "white")) +
  ggplot2::labs(y = "Cumulative Coronavirus Cases",
       x = "Date")
