#' Get data of German polls from wahlrecht.de. 
#'
#' This is the main function to parse XML files from Wahlrecht.de to extract polling data. 
#' It catches all XML elements that can be found.
#' Not all regions have XML available, their data can't be accessed with this function.
#' @param region string, all available regions are documented in the readme
#' @return dataframe
#' @examples
#' germanpolls(region = "de")
#' germanpolls(region = "by")
#' @importFrom RCurl url.exists
#' @export

germanpolls <- function(region = "de") {
  
  if(region == "de") {
    df <- get_data_from_xml_de()
  } else if (region == "eu") {
    print("No XML yet, please go to http://www.wahlrecht.de/umfragen/europawahl.htm")
  } else {
    url <- paste0("http://www.wahlrecht.de/umfragen/xml/land_", region, ".xml")
    if(RCurl::url.exists(url) == TRUE) {
      df <- get_data_from_xml_laender(url)
    } else(print("No XML, sorry"))
  }
}

