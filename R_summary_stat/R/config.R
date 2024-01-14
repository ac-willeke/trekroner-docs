#' @title Configure the Catalog and Parameters
#' @description Loads the catalog and parameters into a list structure.
#' @author Willeke A'Campo <willeke.acampo@nina.no>
#' @version 0.1.0
#' @import config
#' @exports load_catalog, load_parameters
#' @source source("path/to/config.R")
#' @example  
#' catalog_filepath = file.path(getwd(), "config/catalog.yaml")
#' parameters_filepath = file.path(getwd(), "config/parameters.yaml")
#' parameters <- load_parameters(parameters_filepath)
#' catalog <- load_catalog(catalog_filepath)  

# Check if the script is being run from an R Markdown document
# Code to run when not used from R Markdown
import::here(log_info, .from = logger)
import::here(load_dot_env, .from = dotenv)
import::here(str_extract, .from = stringr)
import::here(read_yaml, .from = yaml)
import::here(export, .from = modules)


# VARIABLES ------------------------------------------------------------------ #

# variable expression to match the env var name
var_expression <- "\\$\\{([^}]+)\\}"

# FUNCTION ------------------------------------------------------------------ #
# ' Log the configuration
log_config <- function(message) {
  # private function
  logger::log_info(message, logger = "configure")
}

# FUNCTION ------------------------------------------------------------------- #
#' Load the .env file

load_env <- function() {
  # private function
  # get the list of all environment variables
  user_profile <- Sys.getenv("USERPROFILE")
  env_file <- file.path(user_profile, ".env")
  dotenv::load_dot_env(env_file)
}
# ---------------------------------------------------------------------------- #

# FUNCTION ------------------------------------------------------------------- #
# ' Translate environment variables in a string
# ' @param var_expression: the regular expression to match the env var name
# ' @param str: the string to translate
# ' @return: the translated string
# ' @example
# ' translate_env_vars("\\$\\{([^}]+)\\}", "Hello ${USER}")
# ' [1] "Hello John Doe"

translate_env_vars <- function(var_expression, str) {
  # private function
  # load the .env file
  load_env()
  
  # get the list of env variable names
  lst_env_var_names <- names(Sys.getenv())
  
  # loop through env variable names, if the env var name is found in the string
  # replace the env var name with its value
  for (name in lst_env_var_names) {
    if (grepl(var_expression, str)) {
      
      # find the sub string in the str that matches the expression
      substring <- stringr::str_extract(str, var_expression, group = 1)
      
      # if name == sub string, replace sub string with its value
      if (name == substring) {

        
        # get value of env var
        env_var <- Sys.getenv(name)
        
        # replace the sub string with the env var value
        translated_value <- gsub(var_expression, env_var, str)
        #log_config(paste("String:", str, "translated to:", translated_value))
        return(translated_value)
      }
    }
    else {
      return(str)
    }
  }
}
# ---------------------------------------------------------------------------- #

# FUNCTION ------------------------------------------------------------------- #
# ' Load the catalog
# ' @param yaml_dict: the dictionary of the catalog
# ' @return: the updated dictionary of the catalog
# ' @example
# ' catalog <- load_catalog(yaml_dict)
# ' catalog$raw_data$filepath


load_catalog <- function(catalog_filepath) {
  # iterate over YAML dictionary and for each file path string, 
  # translate the environment variables
  
  yaml_dict <- yaml::read_yaml(catalog_filepath)
  
  for (key_x in names(yaml_dict)) {
    for (key_y in names(yaml_dict[[key_x]])) {
      if (is.character(yaml_dict[[key_x]][[key_y]])) {
        new_value <- translate_env_vars(
          var_expression, yaml_dict[[key_x]][[key_y]]
        )
        yaml_dict[[key_x]][[key_y]] <- new_value
      } else {
        for (key_z in names(yaml_dict[[key_x]][[key_y]])) {
          if (is.character(yaml_dict[[key_x]][[key_y]][[key_z]])) {
            new_value <- translate_env_vars(
              var_expression, yaml_dict[[key_x]][[key_y]][[key_z]]
            )
            yaml_dict[[key_x]][[key_y]][[key_z]] <- new_value
          }
        }
      }
    }
  }
  # return the UPDATED YAML dictionary
  log_config("Catalog loaded.")
  return(yaml_dict)
}

# FUNCTION ------------------------------------------------------------------- #
# ' Load the parameters
# ' @param parameters_filepath: the filepath of the parameters
# ' @return: the updated dictionary of the parameters
# ' @example
# ' parameters <- load_parameters(parameters_filepath)
# ' parameters$raw_data$filepath

load_parameters <- function(parameters_filepath) {
  
  yaml_dict <- yaml::read_yaml(parameters_filepath)
  
  # return the UPDATED YAML dictionary
  log_config("Parameters loaded.")
  return(yaml_dict)
}

# FUNCTION
#' set the font for ggplot2
#' @param font_path: the path to the font
#' @param font_name: the name of the font
#' @param base_size: the base size of the font
#' @return: the updated dictionary of the parameters
#' @example
#' catalog <- load_catalog(catalog_filepath)
#' font_path <- catalog$fonts$filepath
#' .set_font(font_path, font_name = "Arial", base_size = 12)

set_font <- function(font_path, font_name = "Arial", base_size = 12) {
  # Try to set theme to Arial
  tryCatch({
    ggplot2::theme_set(
        ggplot2::theme_minimal(
            base_family = font_name, 
            base_size = base_size
            ))
    logger::log_info(paste0("Font set to: ", font_name))
  }, error = function(e) {
    # Log the error
    logger::log_error("Error setting font, trying to load font...")
    # If setting theme to Arial fails, try to load the font
    tryCatch({
      extrafont::loadfonts(device = "all")
      ggplot2::theme_set(
          ggplot2::theme_minimal
          (base_family = font_name,
              base_size = base_size
              ))
    }, error = function(e) {
      # Log the error
      logger::log_error("Error loading font, trying to import font...")
      # If loading the font fails, import the font
      extrafont::font_import(
          pattern = font_name, 
          paths = font_path, 
          recursive = TRUE, 
          prompt = FALSE
          )
      extrafont::loadfonts(device = "all")
      ggplot2::theme_set(
          ggplot2::theme_minimal(
              base_family = font_name, 
              base_size = base_size
              ))
    })
  })
}

# FUNCTION ------------------------------------------------------------------- #
# ' Read parquet file into a data frame, if the file does not exist,
# ' read the csv file and write it to parquet
# ' @param csv_file: the filepath of the csv file
# ' @param pqt_file: the filepath of the parquet file
# ' @return: the data frame
# ' @example
# ' df <- read_or_convert_to_parquet(csv_file, pqt_file)

convert_csv_to_parquet <- function(csv_file, pqt_file, sep=";", lut_df) {
  if (file.exists(pqt_file)) {
    logger::log_info(paste0("Reading parquet file: ", pqt_file))
    return(arrow::read_parquet(pqt_file))
  } 
  
  logger::log_error(paste0("Parquet file does not exist: ", pqt_file))
  df <- utils::read.csv(
    file = csv_file, 
    header = TRUE, 
    sep = sep, 
    dec = ",", 
    stringsAsFactors = FALSE
    )
  
  type_cols <- list(
    FLOAT = c(),
    DOUBLE = c(),
    SHORT = c(),
    LONG = c(),
    TEXT = c()
  )
  
  # add data types to list
  for (i in 1:nrow(lut_df)) {
    # if FLOAT add to FLOAT
    if (lut_df$data_type[i] == "FLOAT") {
      type_cols$FLOAT <- c(type_cols$FLOAT, lut_df$data_type[i])
    }
    # else if DOUBLE add to DOUBLE
    else if (lut_df$data_type[i] == "DOUBLE") {
      type_cols$DOUBLE <- c(type_cols$DOUBLE, lut_df$data_type[i])
    }
    else if (lut_df$data_type[i] == "SHORT") {
      type_cols$SHORT <- c(type_cols$SHORT, lut_df$data_type[i])
    }
    else if (lut_df$data_type[i] == "LONG") {
      type_cols$LONG <- c(type_cols$LONG, lut_df$data_type[i])
    }
    else if (lut_df$data_type[i] == "TEXT") {
      type_cols$TEXT <- c(type_cols$TEXT, lut_df$data_type[i])
    }
  }
  
  for (col in type_cols$FLOAT) {
    if (col %in% names(df)) {
      df[, col] <- as.numeric(df[, col])
      df[, col] <- round(df[, col], 3)
    }
  }
  for (col in type_cols$DOUBLE) {
    if (col %in% names(df)) {
      df[, col] <- as.numeric(df[, col])
    }
  }
  for (col in type_cols$SHORT) {
    if (col %in% names(df)) {
      df[, col] <- as.integer(df[, col])
    }
  }
  for (col in type_cols$LONG) {
    if (col %in% names(df)) {
      df[, col] <- as.integer(df[, col])
    }
  }
  for (col in type_cols$TEXT) {
    if (col %in% names(df)) {
      df[, col] <- as.character(df[, col])
    }
  }
  
  logger::log_info(paste0("Writing parquet file: ", pqt_file))
  arrow::write_parquet(df, pqt_file)
  
  return(df)
}


convert_excel_to_parquet <- function(excel_file, sheet=NULL, pqt_file, lut_df) {
  if (file.exists(pqt_file)) {
    logger::log_info(paste0("Reading parquet file: ", pqt_file))
    return(arrow::read_parquet(pqt_file))
  } 
  
  logger::log_error(paste0("Parquet file does not exist: ", pqt_file))
  
  # read excel file 
  df <- readxl::read_excel(
    excel_file, 
    sheet = sheet,
    col_names = TRUE,
    col_types = NULL,
    na = "",
    skip = 0
    )
  
  type_cols <- list(
    FLOAT = c(),
    DOUBLE = c(),
    SHORT = c(),
    LONG = c(),
    TEXT = c()
  )
  
  # add data types to list
  for (i in 1:nrow(lut_df)) {
    # if FLOAT add to FLOAT
    if (lut_df$data_type[i] == "FLOAT") {
      type_cols$FLOAT <- c(type_cols$FLOAT, lut_df$data_type[i])
    }
    # else if DOUBLE add to DOUBLE
    else if (lut_df$data_type[i] == "DOUBLE") {
      type_cols$DOUBLE <- c(type_cols$DOUBLE, lut_df$data_type[i])
    }
    else if (lut_df$data_type[i] == "SHORT") {
      type_cols$SHORT <- c(type_cols$SHORT, lut_df$data_type[i])
    }
    else if (lut_df$data_type[i] == "LONG") {
      type_cols$LONG <- c(type_cols$LONG, lut_df$data_type[i])
    }
    else if (lut_df$data_type[i] == "TEXT") {
      type_cols$TEXT <- c(type_cols$TEXT, lut_df$data_type[i])
    }
  }

  for (col in type_cols$FLOAT) {
    if (col %in% names(df)) {
      df[, col] <- as.numeric(df[, col])
      df[, col] <- round(df[, col], 3)
    }
  }
  for (col in type_cols$DOUBLE) {
    if (col %in% names(df)) {
      df[, col] <- as.numeric(df[, col])
    }
  }
  for (col in type_cols$SHORT) {
    if (col %in% names(df)) {
      df[, col] <- as.integer(df[, col])
    }
  }
  for (col in type_cols$LONG) {
    if (col %in% names(df)) {
      df[, col] <- as.integer(df[, col])
    }
  }
  for (col in type_cols$TEXT) {
    if (col %in% names(df)) {
      df[, col] <- as.character(df[, col])
    }
  }
  
  logger::log_info(paste0("Writing parquet file: ", pqt_file))
  arrow::write_parquet(df, pqt_file)
  
  return(df)
}

# MODULE EXPORTS ------------------------------------------------------------- #
# Use Config.R in other R scripts
# config <- modules::use(file.path(src_path, "config.R"))
# parameters <- config$load_parameters(parameters_filepath)
# catalog <- config$load_catalog(catalog_filepath)

# Define '.__exports__' for use with 'import::from(module, .__exports__)'
.__exports__ <- c("load_parameters", "load_catalog", "set_font", "convert_csv_to_parquet", "convert_excel_to_parquet")


# Use Config.R in Markdown documents 
# source(file.path(src_path, "config.R"))
# parameters <- load_parameters(parameters_filepath)
# catalog <- load_catalog(catalog_filepath)