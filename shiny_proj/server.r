# library(ggplot2)

#trim <- function (x) gsub("^\\s+|\\s+$", "", x)
shinyServer(
  function(input, output) {
#     output$year <- renderPrint({
#       tech<-input$tech
#       print(tech)
#       print(c('a','b'))
#       })
    
    output$price_plot <- renderPlot({
      ticker<-input$ticker
      year1<-format(input$fromdate,"%Y")
      month1<-toString(as.numeric(format(input$fromdate,"%m"))-1)
      day1<-format(input$fromdate, "%d")
      year2<-format(input$todate, "%Y")
      month2<-toString(as.numeric(format(input$todate, "%m"))-1)
      day2<-format(input$todate, "%d")
      
      #########################################
      str=paste(c("http://ichart.yahoo.com/table.csv?s=",ticker,"&a=",month1,"&b=",day1,"&c=",year1,"&d=",month2,"&e=",day2,"&f=",year2,"&g=d&ignore=.csv"),collapse = '')
      #str=paste("http://ichart.yahoo.com/table.csv?s=",ticker,"&a=0&b=1&c=2014&d=5&e=20&f=2014&g=d&ignore=.csv")
      con=url(str)
      htmlCode=readLines(con)
      close(con)
      date<-rep(0,length(htmlCode))
      price<-rep(0,length(htmlCode))
      for (i in 2:length(htmlCode)) {
        tmp=htmlCode[i]
        tmp2=unlist(strsplit(tmp,","))
        date[length(htmlCode)-i+2]=tmp2[1]
        price[length(htmlCode)-i+2]=tmp2[7]
      }
      date=as.Date(date[2:length(htmlCode)])
      price=as.numeric(price[2:length(htmlCode)])
      ma5<-rep(0,length(price))
      for (i in 5:length(price)){
        ma5[i]=mean(price[(i-4):i])
      }
      ma10<-rep(0,length(price))
      for (i in 10:length(price)){
        ma10[i]=mean(price[(i-9):i])
      }
      ma20<-rep(0,length(price))
      sd20<-rep(0,length(price))
      for (i in 20:length(price)){
        ma20[i]=mean(price[(i-19):i])
        sd20[i]=sd(price[(i-19):i])
      }
      bb1=ma20+sd20*2
      bb2=ma20-sd20*2
      ######################################
      tech<-input$tech
      ######################################
      index<-input$idx
      if (index!="")
      { str=paste(c("http://ichart.yahoo.com/table.csv?s=",index,"&a=",month1,"&b=",day1,"&c=",year1,"&d=",month2,"&e=",day2,"&f=",year2,"&g=d&ignore=.csv"),collapse = '')
        #str=paste("http://ichart.yahoo.com/table.csv?s=",index,"&a=0&b=1&c=2014&d=5&e=20&f=2014&g=d&ignore=.csv")
        con=url(str)
        htmlCode1=readLines(con)
        close(con)
        date<-rep(0,length(htmlCode))
        idx<-rep(0,length(htmlCode))
        for (i in 2:length(htmlCode)) {
          tmp=htmlCode1[i]
          tmp2=unlist(strsplit(tmp,","))
          date[length(htmlCode)-i+2]=tmp2[1]
          idx[length(htmlCode)-i+2]=tmp2[7]
        }
        date=as.Date(date[2:length(htmlCode)])
        idx=as.numeric(idx[2:length(htmlCode)])  
        scalar=idx[1]/price[1]
        idx_=idx/scalar 
        
        plot(date,price, type = "l",col='black')
        lines(date,idx_, col="orange")
        if ("ma5" %in% tech){lines(date[20:length(price)],ma5[20:length(price)], col="pink")}
        if ("ma10" %in% tech){lines(date[20:length(price)],ma10[20:length(price)], col="plum")}
        if ("bb" %in% tech){
          lines(date[20:length(price)],bb1[20:length(price)], col="grey")
          lines(date[20:length(price)],bb2[20:length(price)], col="grey")}
        title(paste(ticker,"stock price plot"))
        legend("topleft", c(ticker,index,"5 Day Moving Avg","10 Day Moving Avg","Bollinger Bands"),
               lty=c(1,1,1,1,1),col=c("black","orange","pink","plum","grey"))} 

      if (index==""){ 
        plot(date[20:length(price)],price[20:length(price)], type = "l",col='black')
        if ("ma5" %in% tech){lines(date[20:length(price)],ma5[20:length(price)], col="pink")}
        if ("ma10" %in% tech){lines(date[20:length(price)],ma10[20:length(price)], col="plum")}
        if ("bb" %in% tech){
          lines(date[20:length(price)],bb1[20:length(price)], col="grey")
          lines(date[20:length(price)],bb2[20:length(price)], col="grey")}
        title("stock price")
        legend("topleft", c(ticker,"5 Day Moving Avg","10 Day Moving Avg","Bollinger Bands"),
               lty=c(1,1,1,1),col=c("black","pink","plum","grey"))}    

    })
    output$volume_plot <- renderPlot({
      ticker<-input$ticker
      year1<-format(input$fromdate,"%Y")
      month1<-toString(as.numeric(format(input$fromdate,"%m"))-1)
      day1<-format(input$fromdate, "%d")
      year2<-format(input$todate, "%Y")
      month2<-toString(as.numeric(format(input$todate, "%m"))-1)
      day2<-format(input$todate, "%d")
      
      str=paste(c("http://ichart.yahoo.com/table.csv?s=",ticker,"&a=",month1,"&b=",day1,"&c=",year1,"&d=",month2,"&e=",day2,"&f=",year2,"&g=d&ignore=.csv"),collapse = '')
      #str=paste("http://ichart.yahoo.com/table.csv?s=",ticker,"&a=0&b=1&c=2014&d=5&e=20&f=2014&g=d&ignore=.csv")
      con=url(str)
      htmlCode=readLines(con)
      close(con)
      date<-rep(0,length(htmlCode))
      volume<-rep(0,length(htmlCode))
      for (i in 2:length(htmlCode)) {
        tmp=htmlCode[i]
        tmp2=unlist(strsplit(tmp,","))
        date[length(htmlCode)-i+2]=tmp2[1]
        volume[length(htmlCode)-i+2]=tmp2[6]
      }
      date=as.Date(date[2:length(htmlCode)])
      volume=as.numeric(volume[2:length(htmlCode)])
      
      plot(date,volume,"h",main=paste(ticker,"volume plot")) 
    }, height = 300)
  }
)