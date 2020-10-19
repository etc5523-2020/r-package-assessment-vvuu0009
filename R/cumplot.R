#' Cumplot 
#' @description This function produces a line graph of coronavirus cases for a selected case type and continent with date on the x-axis and daily cases for the selected `Type` and `Continent` on the y-axis. 
#' 
#' @importFrom magrittr %>%
#' 
#' @param Type The case type to be plotted being: confirmed, death or recovered
#' @param Continent The Continent to be plotted being: Africa, America, Asia, Europe and Oceania 
#' 
#' @return The line plot plotting the date on the x-axis and daily cases for the selected `Type` and `Continent` on the y-axis
#' 
#' @examples 
#' 
#' cumplot("confirmed","Africa")
#' cumplot("death","Oceania")
#' 
#' @export
cumplot <- function(Type,Continent){
  corona_cont %>%
    dplyr::filter(type == Type) %>%
    dplyr::filter(continent == Continent) %>%
    ggplot2::ggplot(ggplot2::aes(x = date, 
                        y = cases,
                        colour = continent)) +
    ggplot2::geom_line(color = "yellow") +
    ggplot2::theme(panel.grid.major = ggplot2::element_line(colour = "white", size = 0.1, linetype = "dashed"),
                   panel.grid.minor = ggplot2::element_line(colour = "white", size = 0.1, linetype = "dashed"),
                   legend.position = "none",
                   panel.background = ggplot2::element_rect(fill = "black"),
                   plot.background = ggplot2::element_rect(fill = "black", color = NA),
                   text = ggplot2::element_text(color = "white"),
                   axis.line = ggplot2::element_line(color = "white"),
                   axis.text = ggplot2::element_text(color = "white")) +
    ggplot2::labs(x = "Date",
                  y = paste("Daily", Type , "Cases"))
}
