#' Running Shiny Application
#'
#' @description This function runs the Coronavirus Shiny Application
#'
#' @return The Shiny Application 
#'
#' @import shiny
#'
#' @export
launch_app <- function(){
  shiny::runApp("inst/app/CoronaShiny.R")
}
