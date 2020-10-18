#' Running selectInput for corona app
#'
#' @description This function changes the selectInput function of the Shiny app based on the desired input 
#'
#' 
#'   @export
selectInput01 <-
  function(id, column){
    
    shiny::selectInput(id, paste("select the", id), choices = column)
  }
