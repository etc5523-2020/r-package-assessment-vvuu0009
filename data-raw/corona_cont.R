## code to prepare `corona_cont` dataset goes here

library(coronavirus)
data("coronavirus")

corona_cont <- coronavirus %>%
  dplyr::mutate(continent = countrycode::countrycode(sourcevar = country, 
                                                     origin = "country.name",
                                                     destination = "continent")) %>%
  dplyr::group_by(date,continent,type) %>%
  dplyr::summarise(cases = sum(cases)) %>%
  tidyr::drop_na()

usethis::use_data(corona_cont, overwrite = TRUE)
