
library(shiny);

shinyUI(fluidPage(
   fluidRow( # introduction 
      tags$h1("Car accidents in UK",align="center"), #,style = "color:blue"
      column(8,
             tags$br(),
             tags$div(
                tags$p("Car accidents are a serious problem which to date caused many deaths. 
                       On 31 January 1893 the mandatory wearing of seatbelts was introduced.."),
                tags$p(tags$b("Seatbelts"),"[",tags$sup("1,2"),"] data set collects time 
                       series of car accidents happened in Great Britain between January 1969 
                       and December 1984. Monthly observations of  the following quantities 
                       have been recordered:")
             ),
             tags$ul(#style="font-size:13px",
                tags$li(tags$b("DriversKilled"),": car drivers killed"), 
                tags$li(tags$b("drivers"),": car drivers killed or seriously injured"), 
                tags$li(tags$b("front"),": front-seat passengers killed or seriously injured"),
                tags$li(tags$b("rear"),": rear-seat passengers killed or seriously injured"), 
                tags$li(tags$b("kms"),": distance driven"), 
                tags$li(tags$b("PetrolPrice"),": petrol price"),
                tags$li(tags$b("VanKilled"),": number of van (‘light goods vehicle’) drivers"),
                tags$li(tags$b("law"),": 1 when the law was in effect, 0 otherwise")
             ),
             tags$div(
                tags$p("The multiple time series was originally analyzed in 1986 by Harvey and Durbin 
                [",tags$sup("3"),"]."),
                tags$p("Here a simple exploratory analysis is performed."),
                tags$h3("Exploratory time series analysis",align="center")
             )
      ),
      column(4,
             tags$h4("References:"),
             tags$ol(style="font-size:13px",
                tags$li("Harvey, A.C. (1989)", 
                        tags$em("Forecasting, Structural Time Series Models and the Kalman Filter."),
                        "Cambridge University Press, pp. 519–523."), 
                tags$li("Durbin, J. and Koopman, S. J. (2001)",
                        tags$em("Time Series Analysis by State Space Methods."),
                        " Oxford University Press."), 
                tags$li("Harvey, A. C. and Durbin, J. (1986)", tags$em("The effects of seat belt 
                        legislation on British road casualties: A case study in structural 
                        time series modelling."),"Journal of the Royal Statistical Society 
                        series B, 149, 187–227)")
             )
      )
   ),
   fluidRow(# plot data
      column(8,
             tags$p("Data time series are plotted below. Vertical blue lines allow to make
                      easier the visualization and eventually locate cyclic patterns."),
             plotOutput("plot_data", width = 600, height = 600)
      ),
      column(4,
             wellPanel(
                helpText("Select how often the time series is visually cut."),
                sliderInput("sl_cut_data","cut points [months]",min = 1, max = 120, value = 60,step=1)   
             )
      )
   ),
   fluidRow(# exploratory analysis
      column(8,
             tags$h4("Exploratory analysis: moving average"),
             tags$p("The average of each time series is calculated over windows of
                      variable time-length. For each time point, i.e. each month, the average 
                     over the window length centered in that time is calculated and plotted.
                    The beginning of each year is indicated by a vertical grey line."),
             plotOutput("plot_ma", width = 600, height = 600)
             ),
      column(4,
             tags$br(),
             wellPanel(
                helpText("Select the window length below and see how the moving average changes."),
                sliderInput("sl_ordMA","window length [months]",min = 1, max = 60, value = 24,step=1)
                )
             )
   ),
   fluidRow(
      column(8,
             tags$h4("Exploratory analysis: cross-correlation"),
             tags$p("The cross-correlation values between the drivers time series and the other 
                    time series are calculated with variable time lags."),
             plotOutput("plot_cc", width = 600, height = 600)
             
      ),
      column(4,
             tags$br(),
             wellPanel(
                helpText("Select the maximum value of lag calculated."),
                # selectInput("tx_cc1", label="Variable 1",
                #             c("DriversKilled"=1,"drivers"=2,"front"=3,"rear"=4,
                #               "kms"=5,"PetrolPrice"=6,"VanKilled"=7,"law"=8)),
                # selectInput("tx_cc2", label="Variable 2",
                #                c("DriversKilled"=1,"drivers"=2,"front"=3,"rear"=4,
                #                  "kms"=5,"PetrolPrice"=6,"VanKilled"=7,"law"=8)),
                sliderInput("sl_lagmax","Max lag",min=1,max=36,value = 12,step=1),
                actionButton("act_cc","View")
             )
      )
   ),
   tags$br(),
   tags$div(tags$h6("Build by C. Todaro with ",
       tags$a(href='https://cran.r-project.org/web/packages/shiny/index.html'," R package shiny"),
       align="center"))
))
