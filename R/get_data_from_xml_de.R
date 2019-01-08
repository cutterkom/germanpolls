#' Get data of Germany
#'
#' Function to get data from German wide polls: http://www.wahlrecht.de/umfragen/bundesweite.xml
#' @return dataframe
#' @importFrom xml2 read_xml
#' @importFrom xml2 xml_find_all
#' @importFrom xml2 xml_children
#' @importFrom xml2 xml_name
#' @importFrom xml2 xml_text
#' @importFrom magrittr %>%
#' @importFrom purrr map_dfc
#' @importFrom purrr map
#' @importFrom dplyr mutate
#' @importFrom dplyr select
#' @importFrom dplyr data_frame
#' @export



get_data_from_xml_de <- function() {
  
  ## find polls in XML file
  url <- "http://www.wahlrecht.de/umfragen/bundesweite.xml"
  print(url)
  xml <- xml2::read_xml(url)
  
  ## find variables
  rows <- xml %>% xml_find_all("//umfragen/*")
  vars <- rows %>% xml_children() %>% xml_name() %>% unique()
  print(vars)
  ## helper data frame
  df_rows <- data_frame(row = seq_along(rows), node = rows)
  
  ## find features in each row/poll
  df <- map_dfc(vars, function(i){
    df_rows %>% 
      mutate(!!i := node %>% map(~ xml_find_all(., paste0(".//", i))) %>% map(~ xml_text(.)))
  }) %>% select(vars)
  return(df)
  
}