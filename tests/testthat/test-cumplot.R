test_that("cumplot", {
  
  x <- c("confirmed")
  y <- c("Asia")
  
  expect_equal(
    cumplot(x,y),
  
    corona_cont %>%
      dplyr::filter(type == "confirmed") %>%
      dplyr::filter(continent == "Asia") %>%
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
                    y = paste("Daily", "confirmed" , "Cases"))  
    
  )
  
  x <- c("death")
  y <- c("Europe")
  expect_equal(
    cumplot(x,y),
    
    corona_cont %>%
      dplyr::filter(type == "death") %>%
      dplyr::filter(continent == "Europe") %>%
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
                    y = paste("Daily", "death" , "Cases"))  
    
  )
})



