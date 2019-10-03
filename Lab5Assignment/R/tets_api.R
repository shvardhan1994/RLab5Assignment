library(httr)
library(jsonlite)
library(lubridate)
install.packages("XML")
library(XML)
url <- "http://api.thenmap.net"
path <- "v2/world-2/data/2009"

raw.result <- GET(url = url, path = path)
names(raw.result)
this.raw.content <- rawToChar(raw.result$content)
substr(this.raw.content, 1, 100)
raw.result$status_code
this.content <- fromJSON(this.raw.content)
head(this.content)
colnames(this.content)
#*****************************************************************************************************
url_info <- "http://api.thenmap.net"
path_info <- "v2/world-2/info/2009"

raw.result_info <- GET(url = url_info, path = path_info)
names(raw.result_info)
this.raw.content_info <- rawToChar(raw.result_info$content)
substr(this.raw.content_info, 1, 100)
raw.result_info$status_code
this.content_info <- fromJSON(this.raw.content_info)

this.content.df_info <- do.call(what = "rbind",
                           args = lapply(this.content_info, as.data.frame))

#*****************************************************************************************************
url_geo <- "http://api.thenmap.net"
path_geo <- "v2/world-2/geo/2009"

raw.result_geo <- GET(url = url_geo, path = path_geo)
names(raw.result_geo)
this.raw.content_geo <- rawToChar(raw.result_geo$content)
substr(this.raw.content_geo, 1, 100)
raw.result_geo$status_code
this.content_geo <- fromJSON(this.raw.content_geo)

this.content.df_geo <- do.call(what = "cbind",
                                args = lapply(this.content_geo, as.data.frame))


#*****************************************************************************************************
url_svg <- "http://api.thenmap.net"
path_svg <- "v2/world-2/svg/2009"

raw.result_svg <- GET(url = url_svg, path = path_svg)
names(raw.result_svg)
this.raw.content_svg <- xmlParse(raw.result_svg)
#substr(this.raw.content_svg, 1, 100)
#raw.result_svg$status_code
#this.content_svg <- fromJSON(this.raw.content_svg)

#this.content.df_svg <- do.call(what = "cbind",
                               #args = lapply(this.content_geo, as.data.frame))
library(XML)
library(methods)
xml_data <- xmlToDataFrame(this.raw.content_svg)



