#' Get data of Bundesländer
#'
#' Function to get data from states.
#' @param url url of XML file, auto-generated from `region`
#' @return data frame
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

get_data_from_xml_laender <- function(url) {
  
  ## find polls in XML file
  xml <- xml2::read_xml(url)
  rows <- xml %>% xml_find_all("//umfragen/*")
  
  ## find variables
  meta <-  rows %>% xml_children() %>% xml_name() %>% unique()
  parties <- xml %>% xml_find_all("//umfragen/*/werte") %>% xml_children() %>% xml_name() %>% unique()
  vars <- c(meta, parties)
  
  ## helper data frame
  df_rows <- data_frame(row = seq_along(rows), node = rows)
  
  ## find features in each row/poll
  df <- map_dfc(vars, function(i){
    df_rows %>% 
      mutate(!!i := node %>% map(~ xml_find_all(., paste0(".//", i))) %>% map(~ xml_text(.)))
  }) %>% select(vars, -werte)
  
  return(df)

}
