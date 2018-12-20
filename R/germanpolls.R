# implement:
# parteien: übersetzung?
# germanpolls_latest(): nur der letzte 


# mv,Mecklenburg-Vorpommern
# be,Berlin
# he,Hessen
# ni,Niedersachsen
# nw,Nordrhein-Westfalen
# rp,Rheinland-Pfalz
# sl,Saarland
# hb,Bremen
# hh,Hamburg
# sn,Sachsen
# st,Sachsen-Anhalt
# sh,Schleswig-Holstein
# th,Thüringen
# by,Berlin
# bw,Baden-Württemberg
# bb,Brandenburg


## wrapper function 

source("R/get_data_from_xml_de.R")
source("R/get_data_from_xml_laender.R")

regions <- read.csv("data/regions.csv")

germanpolls <- function(region = "de") {

  library(purrr)
  library(dplyr)
  library(XML)
  library(xml2)
  library(RCurl)
  
  if(region == "de") {
    df <- get_data_from_xml_de()
  } else if (region == "eu") {
    print("No XML yet, please go to http://www.wahlrecht.de/umfragen/europawahl.htm")
  } else {
    url <- paste0("http://www.wahlrecht.de/umfragen/xml/land_", region, ".xml")
    if(url.exists(url) == TRUE) {
      df <- get_data_from_xml_laender(url)
    } else(print("No XML, sorry"))
  }
}