#' @title NINA plots 
#' @description Creates plots and figures according to NINA style 
#' @author Willeke A'Campo <willeke.acampo@nina.no>
#' @version 0.1.0
#' @import nina_plot
#' @exports load_catalog, load_parameters
#' @source source("path/to/nina_plot.R")
#' @example  
#' catalog_filepath = file.path(getwd(), "config/catalog.yaml")
#' parameters_filepath = file.path(getwd(), "config/parameters.yaml")
#' parameters <- load_parameters(parameters_filepath)
#' catalog <- load_catalog(catalog_filepath)  

# Check if the script is being run from an R Markdown document



# import all ggplot fucntions from gglot 2


# ---------------------------------------------------------------------------- #
# FUNCTION: NINA THEME
# ---------------------------------------------------------------------------- #
# Avenir Next (Font Family = "sans")
# Font Size title (15)
# Font Size Axis Title (14)
# Font Size Axis Label (10)
# Font Size Legend Label (10)
# Color of Axis ("#828282") 
# Color of Axis Grid ("#d5d5d5")
# Color of Bars ("#fa9502") NINA orange
# Color of Normal distribution line (#425563) NINA grayblue
# Color of MEAN (#79000f) darkred 


# Define NINA themes
# Define NINA themes
theme_medium <- function() {
  ggplot2::theme(
    plot.title = ggplot2::element_text(color = "#000000", hjust = 0.5, size = 12),
    plot.subtitle = ggplot2::element_text(color = "#404040", hjust = 0.5, size = 10, face = "italic"),
    panel.border = ggplot2::element_blank(),
    panel.grid = ggplot2::element_blank(),
    panel.spacing = grid::unit(2, "lines"), 
    axis.line = ggplot2::element_line(color = "#425563", size = 0.15),
    axis.ticks = ggplot2::element_line(color = "#425563", size = 0.15),
    axis.title = ggplot2::element_text(color = "#000000", size = 12), 
    axis.title.y = ggplot2::element_text(margin = ggplot2::margin(t = 0, r = 20, b = 0, l = 0)),
    axis.title.x = ggplot2::element_text(margin = ggplot2::margin(t = 20, r = 0, b = 0, l = 0)),
    axis.text = ggplot2::element_text(color = "#000000", size = 9), 
    strip.text = ggplot2::element_text(color = "#404040", face = "bold"), 
    legend.position = "none",
    plot.margin = grid::unit(c(0.5, 0.5, 0.5, 0.5), "cm")
  )
}


theme_large <- function() {
  ggplot2::theme(
    plot.title = ggplot2::element_text(color = "#000000", hjust = 0.5, face = "bold", size = 20),
    plot.subtitle = ggplot2::element_text(color = "#404040", hjust = 0.5, size = 16, face = "italic"),
    panel.border = ggplot2::element_blank(),
    panel.grid = ggplot2::element_blank(),
    panel.spacing = grid::unit(2, "lines"), 
    axis.line = ggplot2::element_line(color = "#425563", size = 0.2),
    axis.ticks = ggplot2::element_line(color = "#425563", size = 0.2),
    axis.title.y = ggplot2::element_text(color = "#000000", size = 16, margin = ggplot2::margin(t = 0, r = 20, b = 0, l = 0)),
    axis.title.x = ggplot2::element_text(margin = ggplot2::margin(t = 20, r = 0, b = 0, l = 0)),
    axis.text.x = ggplot2::element_text(size = 14, color = "#000000", angle = 45, hjust = 1),
    axis.text.y = ggplot2::element_text(size = 14, color = "#000000"), 
    strip.text = ggplot2::element_text(color = "#000000", face = "bold"), 
    legend.position = "none",
    plot.margin = grid::unit(c(0.5, 0.5, 0.5, 0.5), "cm")
  )
}

# Define '.__exports__' for use with 'import::from(module, .__exports__)'
.__exports__ <- c("theme_medium", "theme_large")