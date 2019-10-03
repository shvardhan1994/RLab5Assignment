library(shiny)
get_data <- read_excel("2014_riksdagsval_per_kommun.xls")
ui <- fluidPage(
  titlePanel("Comprehensive statistics on the 2014 election in Sweden"),
  sidebarLayout(
    sidebarPanel(
      textInput("County_name","County"),
      textInput("Municipality_name","Municipality")
      
    ),
    mainPanel(plotOutput("p"))
  )
)
server <- function(input, output) {

  
  output$p <- renderPlot({
    get_data_df <- as.data.frame(get_data)
    get_data_df$LAN <- NULL
    get_data_df$KOM <- NULL
    names(get_data_df)[names(get_data_df) == "LÄN"] <- "County"
    names(get_data_df)[names(get_data_df) == "KOMMUN"] <- "Municipality"
    
    
    PartyVoteShare <- function(County_name, Municipality_name){
      if(is.character(County_name) & is.character(Municipality_name)){
        
        get_req_row_data <- get_data_df[get_data_df$County == reactive(input$County_name) & get_data_df$Municipality == reactive(input$Municipality_name), ]
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
    
    #PartyVoteShare(County_name = "Blekinge län",Municipality_name = "Karlshamn")

    PartyVoteShare(County_name = reactive(input$County_name),Municipality_name = reactive(input$Municipality_name))
    
    
    
  })
  
  
}
shinyApp(ui = ui, server = server)