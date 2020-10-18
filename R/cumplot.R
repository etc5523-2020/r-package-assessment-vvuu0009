#' 
#' @export
cumplot <- function(Type,Continent){
  corona_cont %>%
    dplyr::filter(type == Type) %>%
    dplyr::filter(continent == Continent) %>%
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
                  y = paste("Daily", Type , "Cases"))
}
