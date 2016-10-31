#' A function to scrape Wahlrecht.de
#' 
#' germanpolls() is a function that gets polling data from [Wahlrecht.de](http://www.wahlrecht.de) for seven polling organisations and ten parties.
#' @importFrom dplyr %>%
#' @importFrom rvest html_table
#' @importFrom xml2 read_html
#' @importFrom dplyr filter
#' @importFrom dplyr rename
#' @importFrom dplyr mutate
#' @importFrom dplyr select
#' @importFrom purrr map
#' @importFrom purrr map_at
#' 
#' @examples
#' polling_data <- germanpolls() 
#' 
#' @export
#'

germanpolls <- function() {
  
  # scrape data
  institute <- c("allensbach", "emnid", "forsa", "politbarometer", "gms", "dimap", "insa")
  parteien <- c("cdu.csu", "spd", "grüne", "fdp", "linke", "afd", "sonstige", "nw_un", "piraten", "fw")
  
  
  df <-
    purrr::map_df(institute, function(i) {
      
      # keep calm!
      cat(".")
      
      page <- paste0("http://www.wahlrecht.de/umfragen/", i, ".htm") %>% xml2::read_html()
      data.frame(page %>% rvest::html_table(fill = TRUE), stringsAsFactors=FALSE)
    })
  
  
  # clean data
  names(df) <- tolower(names(df))
  
  df <- df %>%
    dplyr::filter(grepl("%", cdu.csu)) %>%
    dplyr::filter(!grepl("Bundestagswahl", befragte)) %>%
    dplyr::rename(institut = x1, datum2 = datum, nw_un = nichtwähler.unentschl.) %>%
    dplyr::mutate(datum = ifelse(is.na(x.), datum2, x.)) %>%
    dplyr::select(institut, datum, befragte, zeitraum, cdu.csu, spd, grüne, fdp, linke, afd, sonstige, nw_un,piraten,fw) %>%
    dplyr::mutate(typ = ifelse(
      grepl("O • ", befragte), "online",
      ifelse(grepl("T • ", befragte), "telefon", "keineangabe")))
  
  # gsub
  df <- df %>% purrr::map(gsub, pattern = " %|≈|O • |T • |[?]", replacement = "")
  df <- df %>% purrr::map(gsub, pattern = ",", replacement = ".")
  df <- df %>% purrr::map_at("befragte", gsub, pattern = "[.]", replacement = "")
  
  # classes
  df <- df %>% purrr::map_at(parteien, as.numeric)
  df <- df %>% purrr::map_at("befragte", as.numeric)
  df$datum <- as.Date(df$datum, "%d.%m.%Y")
  df <- df %>% as.data.frame()
  
  df
  
}
