
url <- "https://data.val.se/val/val2014/statistik/2014_riksdagsval_per_kommun.xls"
httr::GET(url = url, httr::write_disk(tfo <- tempfile(fileext = ".xls")))
get_data_temp_s <- readxl::read_excel(tfo, 1L, col_names = TRUE)
get_data_s <- get_data_temp_s[-1,]
colnames(get_data_s) <- c(get_data_s[1,])
get_data_s <- get_data_s[-1,]
colnames(get_data_s) <- c("LAN","KOM","County","Municipality","M","MPER","C","CPER","FP","FPPER","KD","KDPER","S","SPER","V","VPER","MP","MPPER","SD","SDPER","FI","FPPER","OVR","OVRPER","BL","BLPER","OGPER","OG")
ui <- shiny::fluidPage(
  shiny::titlePanel("Comprehensive statistics on the 2014 election in Sweden"),
  shiny::sidebarLayout(
    shiny::sidebarPanel(
      shiny::selectInput("Municipality_name","Municipality",
                  unique(as.character(get_data_s$Municipality))),
      shiny::actionButton("button_mun", "Municipality Results"),
      shiny::selectInput("County_name","County",
                  unique(as.character(get_data_s$County))),
      shiny::actionButton("button_coun", "County Results")
      
    ),
    shiny::mainPanel(shiny::plotOutput("p"),
                     shiny::br(),
                     shiny::br(),
              shiny::plotOutput("p2"))
  )
)
server <- function(input, output) {
  shiny::observeEvent(input$button_mun, {
    
    output$p <- shiny::renderPlot({
      source("./MunicipalityResults.r")
      MunicipalityResults(Municipality_name = (input$Municipality_name))
      
    })
  })

  shiny::observeEvent(input$button_coun, {
    
    output$p2 <- shiny::renderPlot({
      source("./CountyResults.R")
      CountyResults(County_name = (input$County_name))
    

    }) 
  }) 
  
}
shiny::shinyApp(ui = ui, server = server)