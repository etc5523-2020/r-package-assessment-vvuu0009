## code to prepare `coronavirus_july20` dataset goes here

library(coronavirus)
library(tidyr)
library(magrittr)
library(dplyr)
library(countrycode)

data("coronavirus")

coronavirus_july20 <- coronavirus %>%
  mutate(continent = countrycode(sourcevar = country, 
                                              origin = "country.name",
                                              destination = "continent")) %>%
  group_by(date,country,continent, type) %>%
  summarise(cases = sum(cases)) %>%
  pivot_wider(names_from = type,
                     values_from = cases) %>%
  group_by(country) %>%
  mutate('Total Confirmed' = cumsum(confirmed),
                'Total Deaths' = cumsum(death),
                'Total Recovered' = cumsum(recovered)) %>%
  filter(date == "2020-07-31") %>%
  select(-date,-confirmed,-death,-recovered) %>%
  arrange(-`Total Confirmed`) %>%
  rename(Country = country, Continent = continent) %>%
  mutate(`Total Confirmed`= as.numeric(`Total Confirmed`),
                `Total Deaths` = as.numeric(`Total Deaths`),
                `Total Recovered` = as.numeric(`Total Recovered`))

usethis::use_data(coronavirus_july20, overwrite = TRUE)
