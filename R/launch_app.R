#' Running Shiny Application
#'
#' @description This function runs the Coronavirus Shiny Application exploring the state of Coronavirus as at July 31 2020 
#'
#' @return The Shiny Application exploring the state of Coronavirus as at July 31 2020 
#'
#' @import shiny
#' 
#' @example 
#' launch_app()
#'
#' @export
launch_app <- function(){
  appDir <- system.file("app", package = "CoronaShiny")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `CoronaShiny`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}
