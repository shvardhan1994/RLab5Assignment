#' This function loads data from API and performs functionality based on the data.
#' @description In this package, we connect to a web API and fetch data from API, a functionality is created where in user inputs Municipality Name and  party wise vote distribution is plotted. The same functionality is called in shiny app making it a reactive input output program.
#' @param Municipality_name Takes this as argument and party wise vote distribution is plotted.
#' @import ggplot2
#' @examples
#' \dontrun{ 
#' PartyVoteShare(Municipality_name = "Karlshamn")
#' }
#' @return Returns the plot with party wise vote distribution of the municipality user entered.
#' @export 




#library(httr)
#library(ggplot2)
#library(shiny)
#library(readxl)


#function to plot results based on Municipality Name

MunicipalityResults <- function(Municipality_name){
  url <- "https://data.val.se/val/val2014/statistik/2014_riksdagsval_per_kommun.xls"
  httr::GET(url = url, httr::write_disk(tf <- tempfile(fileext = ".xls")))
  get_data_temp <- readxl::read_excel(tf, 1L, col_names = TRUE)
  get_data <- get_data_temp[-1,]
  colnames(get_data) <- c(get_data[1,])
  get_data <- get_data[-1,]
  get_data_df <- as.data.frame(get_data)
  get_data_df$LAN <- NULL
  get_data_df$KOM <- NULL
  colnames(get_data_df) <- c("County","Municipality","M","MPER","C","CPER","FP","FPPER","KD","KDPER","S","SPER","V","VPER","MP","MPPER","SD","SDPER","FI","FPPER","OVR","OVRPER","BL","BLPER","OGPER","OG")
  if( is.character(Municipality_name) & Municipality_name %in% get_data_df$Municipality ){
    
    get_req_row_data <- get_data_df[get_data_df$Municipality == Municipality_name, ]
    sub_df <- get_req_row_data[,-c(1,2,4,6,8,10,12,14,16,18,20,22,24,26,27,28,29,30,31)]
    t_sub_df <- t(sub_df)
    row.names(t_sub_df) <-c("M","C","FP","KD","S","V","MP","SD","FI","OVR","BL","OG")
    x_axis <- row.names(t_sub_df)
    y_axis <- as.vector(t_sub_df[,1])
    partynames <- c("M = Moderates","C = The Center Party","FP = The Liberal Party","KD = The Christian Democrats",
                    "S = Labor-Socialdemokraterna","V = The Left","MP = The environmental party the Greens","SD = Sweden Democrats",
                    "FI = Feminist Initiative","OVR = Other parties","BL = Invalid voices - blank","OG = Invalid votes - others")
    PartyNames <- vector()
    TotalVotes <- vector()
    fun1_df <- data.frame(PartyNames = x_axis, TotalVotes = y_axis  )
    p<-ggplot2::ggplot(data=fun1_df, ggplot2::aes(x=PartyNames, y=TotalVotes, fill=partynames)) +
      ggplot2::geom_bar(stat="identity") + 
      ggplot2::geom_text(aes(label=TotalVotes), vjust=1.6, color="black", size=3.5) + 
      ggplot2::theme_minimal() + ggplot2::labs(title = "Municipality Result")
    return(p)
  } else stop("Input arguments are not character type : Check your Input")
}



#MunicipalityResults(Municipality_name = "Karlshamn")

