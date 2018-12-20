# Get data für Deutschland

get_data_from_xml_de <- function() {
  
  ## find polls in XML file
  url <- "http://www.wahlrecht.de/umfragen/bundesweite.xml"
  print(url)
  xml <- xml2::read_xml(url)
  
  ## find variables
  rows <- xml %>% xml_find_all("//umfragen/*")
  vars <- rows %>% xml_children() %>% xml_name() %>% unique()
  
  ## helper data frame
  df_rows <- data_frame(row = seq_along(rows), node = rows)
  
  ## find features in each row/poll
  map_dfc(vars, function(i){
    df_rows %>% 
      mutate(!!i := node %>% map(~ xml_find_all(., paste0(".//", i))) %>% map(~ xml_text(.)))
  }) %>% select(vars)
  
}