#' Running selectInput for corona app
#'
#' @description This function changes the selectInput function of the Shiny app based on the desired input 
#' 
#' @param id The variable we wish to include in the selectInput
#' 
#' @param column The specific column from the data set we wish to extract the values to appear as the options for the selectInput 
#' 
#' @examples 
#' selectInput01("continent", corona_cont$continent)
#' 
#'
#' 
#' @export
selectInput01 <-
  function(id, column){
    
    shiny::selectInput(id, paste("select the", id), choices = column)
  }
