shinyUI(
  pageWithSidebar(
    headerPanel("Investor's Helper"),
    sidebarPanel(
      #h3('input box'),
      textInput("ticker", "please enter a ticker", 'AAPL'),
      dateInput("fromdate", "From Date:",value="2014-01-01",format = "yyyy-mm-dd"),
      dateInput("todate", "To Date:",value="2014-06-30",format = "yyyy-mm-dd"),
      
      "You may simply enter some ticker in the text box,",
      "select a period and submit, you will see the daily",
      "stock price and trading volumne plots of the specified ticker, period.", 
      "Some tickers are MSFT (Microsoft), AMZN (Amazon), FB (Facebook), etc.",
      br(),br(),
      radioButtons("idx", 
                   "Compare with an index?",
                   c("NO"="",
                     "S&P 500" = "^GSPC",
                     #"Dow Jones"="^DJI",
                     "NASDAQ" = "^IXIC")),
      checkboxGroupInput("tech", 
                   "Add some technical overlays?",
                   c("5 Day Moving Average" ="ma5",
                     "10 Day Moving Average"="ma10",
                     "Bollinger Bands" = "bb")),
      br(),
      submitButton('Submit')
    ),
    mainPanel(
      #h3('output box'),
      #verbatimTextOutput("year"),
      plotOutput('price_plot'),
      plotOutput('volume_plot')
    )
  )
)