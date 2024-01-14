#' @title NINA plot
#' @description Create a common plots and figures according to NINA style
#' @author Willeke A'Campo <willeke.acampo@nina.no>
#' @version 0.1.0
#' @import ggplot2
#' @exports probability_plot

# FUNCTION ------------------------------------------------------------------- #
#' Create a probability plot
#' @param data_summary: data_summary frame with two columns: Var1 and Perc
#' @param title: title of the plot
#' @param ylab: label of the y-axis
#' @param xlab: label of the x-axis
#' @param fill: color of the bars
#' @return: a ggplot object
#' @example
#' data_summary <- data.frame(Var1 = c("A", "B", "C"), Perc = c(10, 20, 30))
#' probability_plot(data, "Title", "Y-label", "X-label", "#004022")

probability_plot <- function(
    data_summary, Var1, title, ylab = "Sannsynlighet (%)", xlab = "", fill = "#004022", ymax = 25) {

  # Create the probability plot
  plot <- ggplot2::ggplot(data_summary, ggplot2::aes(
            # !! is used to unquote the variable name 
            # var_name <- "my_var" unquote: my_var 
            x = stats::reorder(!!rlang::sym(Var1), -Perc),
            y = Perc)) +
            ggplot2::geom_bar(
              stat = "identity", 
              fill = fill,
              color = fill,
              alpha = 1) +
            ggplot2::geom_text(ggplot2::aes(
                label = paste0(Perc, "%")),
                vjust = -0.5, 
                size = 3, 
                color = "#000000") +
            ggplot2::labs(title = title, x = xlab, y = ylab) + 
            ggplot2::scale_x_discrete(expand = c(0,1)) +
            ggplot2::scale_y_continuous(expand = c(0,0), limits = c(0, ymax)) 

  # Return the plot
  return(plot)
}



# ---------------------------------------------------------------------------- #
# FUNCTION: scale the normal distribution to the histogram
# ---------------------------------------------------------------------------- #
#' scale the normal distribution to the histogram
#' @param data: data frame with one column
#' @param x: name of the column
#' @param bin_step: width of the bins
#' @param xlim: limits of the x-axis
#' @return: a data frame with two columns: x and y
#' @example
#' data <- data.frame(x = rnorm(100))
#' dnorm_scaled(data, "x", 1, c(-5, 5))

dnorm_scaled <- function(data, x = NULL, bin_step = 1, xlim = NULL) {
  .x <- stats::na.omit(data[,x])
  if (is.null(xlim))
    xlim = c(min(.x), max(.x))
  x_range = seq(xlim[1], xlim[2], length.out = 101)
  stats::setNames(
    data.frame(
    x = x_range,
    y = stats::dnorm(x_range, mean = mean(.x), sd = stats::sd(.x)) * length(.x) * bin_step),
    c(x, "y"))
}

# Function to calculate the bins
#' calculate the bins of a histogram
#' @param df: data frame
#' @param column_name: name of the column
#' @param bin_method: method to calculate the bins 
#' fd: Freedman-Diaconis rule (best for skewed data)
#' sqrt: square root of the number of observations (best for normal data)
#' 

calculate_bins <- function(df, column_name, bin_method= "fd") {

  # print col_names df
  #print(colnames(df))
  filtered_data <- df[!is.na(df[[column_name]]),]
  n_trees <- length(filtered_data[[column_name]])

  # set to numeric to avoid error
  if (bin_method == "fd") {
    fd_rule <- 2 * stats::IQR(filtered_data[[column_name]], na.rm = TRUE) / (n_trees^(1/3))
    bin_step <- round(fd_rule)
  } else if (bin_method == "sqrt") {
    bin_step <- round(sqrt(n_trees))
  } else {
    stop("Invalid bin_method. Choose 'fd' or 'sqrt'.")
  }

  # Make sure bin_step is even
  if (bin_step %% 2 != 0) {
    bin_step <- bin_step + 1
  }

  # set to numeric to avoid error
  bin_max = round(max(df[[column_name]]))

  logger::log_info(paste0(column_name, ": ",  df[["class"]][1]))
  logger::log_info(paste0("bin_step: ", bin_step))
  logger::log_info(paste0("bin_max: ", bin_max))


  # create temp data
  temp_data <- filtered_data
  temp_data$crown_area[temp_data$height_total_tree > bin_max] <- bin_max
  df_capped <- as.data.frame(temp_data)

  return(list(
    df_capped = df_capped,
    bin_max = bin_max, 
    bin_step = bin_step
    ))
}

.calculate_labels <- function(bin_max, bin_step) {
  # calc bin labels 
  bin_edges <- seq(0, bin_max, by = bin_step)
  bin_labels <- round(bin_edges, 2)

  # Select 8 labels at equally spaced intervals
  selected_indices <- round(seq(1, length(bin_labels), length.out = 8))
  #selected_labels <- bin_labels[selected_indices]
  bin_labels[-selected_indices] <- ""
  bin_labels <- c(bin_labels, paste0(" "))
  
  return(bin_labels)
}

# ---------------------------------------------------------------------------- #
# FUNCTION: CREATE HISTOGRAM
# ---------------------------------------------------------------------------- #
# 2. Plot histogram
histogram <- function(data, value_col, bin_max, bin_step, ymax, title, axis_title_x){
  
  # calc mean
  mean_value <- mean(data[[value_col]], na.rm = TRUE)

  # calc ticks and labels 
  bin_labels <- .calculate_labels(bin_max, bin_step)
  breaks <- seq(0, bin_max, by = bin_step)
  non_empty_label_positions <- which(bin_labels != "")
  breaks <- breaks[non_empty_label_positions]
  labels <- bin_labels[non_empty_label_positions]

  # set first label to 0
  labels[1] <- "0"
  
  plot <- ggplot2::ggplot(data, ggplot2::aes(x = !!rlang::sym(value_col))) + 
    ggplot2::geom_histogram(
      bins = bin_max/bin_step,
      color = "#fa9502", 
      fill = "#fa9502", 
      alpha = 0.2) + 
    ggplot2::geom_vline(ggplot2::aes(xintercept = mean_value), 
      color = "#79000f", 
      linetype = "solid", 
      size = 0.7) +
    ggplot2::geom_line(
      data = ~ dnorm_scaled(.,value_col, bin_step = bin_step), 
      ggplot2::aes(y = y), 
      color = "#425563") +
    ggplot2::labs(
      title = title, 
      x = axis_title_x, 
      y = ggplot2::element_blank()) +
    ggplot2::scale_x_continuous(
      limits = c(0, bin_max), 
      breaks = breaks, 
      labels = labels,
      expand = c(0,0)) + 
    ggplot2::scale_y_continuous(
      expand = c(0,0),
      limits = c(0,ymax))
  return(plot)
}


# ---------------------------------------------------------------------------- #
# FUNCTION: BARPLOT WITH MEAN PER GROUP
# ---------------------------------------------------------------------------- #

barplot <- function(df, x_title, y_title, pal_continuous, angle, ymax) {


  # Create the barplot
  ggplot2::ggplot(df, ggplot2::aes(x = class, y = mean, fill = class)) +
    ggplot2::geom_bar(stat = "identity") +
    ggplot2::labs(x = x_title, y = y_title) +
    ggplot2::scale_fill_manual(values = pal_continuous) +
    ggplot2::scale_y_continuous(limits = c(0, ymax), expand = c(0,0)) +
    # rotate x-axis labels
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = angle, vjust = 0.5, hjust=1))
}


# MODULE EXPORTS ------------------------------------------------------------- #
# Define '.__exports__' for use with 'import::from(module, .__exports__)'
.__exports__ <- c("probability_plot", "histogram", "calculate_bins", "barplot")
