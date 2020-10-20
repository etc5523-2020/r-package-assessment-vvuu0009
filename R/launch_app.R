#' Running Shiny Application
#'
#' @description This function runs the Coronavirus Shiny Application exploring the state of Coronavirus as at July 31 2020 
#'
#' @return The Shiny Application exploring the state of Coronavirus as at July 31 2020 
#'
#' @import shiny DT plotly coronavirus magrittr ggplot2
#' 
#' @example 
#' launch_app()
#'
#' @export
launch_app <- function(){
  shiny::runApp("inst/app/CoronaShiny.R")
}
