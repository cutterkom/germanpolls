#' Get data of Bundesländer
#'
#' Function to get data from states.
#' @param url url of XML file, auto-generated from `region`
#' @return data frame
#' @importFrom xml2 read_xml
#' @importFrom xml2 xml_find_all
#' @importFrom xml2 xml_children
#' @importFrom xml2 xml_name
#' @importFrom xml2 xml_attrs
#' @importFrom xml2 xml_text
#' @importFrom magrittr %>%
#' @importFrom purrr set_names
#' @importFrom purrr flatten
#' @importFrom purrr map
#' @importFrom purrr map_df
#' @importFrom readr type_convert
#' @export

get_data_from_xml_laender <- function(url) {
  df <- xml2::read_xml(url) %>% 
    xml2::xml_find_all("//umfragen/*") %>% 
    purrr::map_df(~purrr::flatten(c(xml2::xml_attrs(.x), 
                                    purrr::map(xml2::xml_children(.x), 
                                               ~purrr::set_names(as.list(xml2::xml_text(.x)), xml2::xml_name(.x)))))) %>%
    
    type_convert()
  
  return(df)
}
