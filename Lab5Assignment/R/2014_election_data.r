install.packages("shiny")
library(shiny)
runExample("01_hello")

library(readxl)

#The files show votes in number and percent per election district and municipality, as well as blank and voter turnout.
get_data <- read_excel("2014_riksdagsval_per_kommun.xls")
class(get_data)
get_data_df <- as.data.frame(get_data)
get_data_df$LAN <- NULL
get_data_df$KOM <- NULL
names(get_data_df)[names(get_data_df) == "LÄN"] <- "County"
names(get_data_df)[names(get_data_df) == "KOMMUN"] <- "Municipality"
head(get_data_df)
county_levels <- as.vector(unique(get_data_df[,c("County")]))
municipality_levels <- as.vector(unique(get_data_df[,c("Municipality")]))


library(ggplot2)
library(tidyr)
#Function which takes in county name and municipality name and return plot that
#consists of total vote share each party has
PartyVoteShare <- function(County_name, Municipality_name){
if(is.character(County_name) & is.character(Municipality_name)){

county_x <- County_name
mun_y <- Municipality_name
get_req_row_data <- get_data_df[get_data_df$County == county_x & get_data_df$Municipality == mun_y, ]
sub_df <- get_req_row_data[-c(1,2,4,6,8,10,12,14,16,18,20,22,24,26,27,28,29,30,31)]
t_sub_df <- t(sub_df)
row.names(t_sub_df) <-c("M","C","FP","KD","S","V","MP","SD","FI","OVR","BL","OG")
x_axis <- row.names(t_sub_df)
y_axis <- as.vector(t_sub_df[,1])
partynames <- c("M = Moderates","C = The Center Party","FP = The Liberal Party","KD = The Christian Democrats",
                "S = Labor-Socialdemokraterna","V = The Left","MP = The environmental party the Greens","SD = Sweden Democrats",
                "FI = Feminist Initiative","OVR = Other parties","BL = Invalid voices - blank","OG = Invalid votes - others")

fun1_df <- data.frame(PartyNames = x_axis, TotalVotes = y_axis  )
p<-ggplot(data=fun1_df, aes(x=PartyNames, y=TotalVotes, fill=partynames)) +
  geom_bar(stat="identity") + 
  geom_text(aes(label=TotalVotes), vjust=1.6, color="black", size=3.5) + 
  theme_minimal()
return(p)
} else print("Input arguments are not character type : Check your Input")
}

PartyVoteShare(County_name = "Blekinge län",Municipality_name = "Karlshamn")
PartyVoteShare(County_name = "Blekinge län",Municipality_name = "Karlskrona")
PartyVoteShare(County_name = "Hallands län",Municipality_name = "Kungsbacka")
PartyVoteShare(County_name = "Hallands län",Municipality_name = 123)




County_name <- "abc"
get_data_df[get_data_df$County == County_name,]



 
