# require(rCharts)
# output$nvd3plot <- renderChart({
#   haireye = as.data.frame(HairEyeColor)
#   n1 <- nPlot(Freq ~ Hair, group = 'Eye', type = 'multiBarChart',data = subset(haireye, Sex = 'Male'))
#   n1$set(dom = 'nvd3plot', width = 600)
#   n1
# })

# require(rCharts)
# output$temp_plot <- renderChart({
#   x=c(1,2,3,4,5)
#   y=c(3,4,3,4,3)
#   z=c(2,2,3,3,2)
#   df<-data.frame(x,y,z)
#   p<-rPlot(y~x,data=df,type = "point")
#   p$set(dom="temp_plot",width=600)
#   p
# })

require(rCharts)
require(reshape2)
output$price_plot <- renderPlot({
   ticker<-input$ticker
   index<-input$idx
   
   str=paste("http://ichart.yahoo.com/table.csv?s=",ticker,"&a=0&b=1&c=2014&d=5&e=20&f=2014&g=d&ignore=.csv")
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
   
   df<-data.frame(date,price)
   m0<-mPlot(x = "date", y = "price", type = "Line", data = df)
   m0$set(dom = 'price_plot', width = 600)
   m0
     
#    df1<-data.frame(date,price,idx_)
#    m1 <- mPlot(x = "date", y = c("price", "idx_"), type = "Line", data = df1)
#    print(m1)
   #if (index==""){
#      df<-data.frame(date,price)
#      h<-hPlot(x="date",y="price",data=df,type="line")
#      h$set(dom ='price_plot', width = 600)
#      h
   #}
#    if (index!=""){
#      str=paste("http://ichart.yahoo.com/table.csv?s=",index,"&a=0&b=1&c=2014&d=5&e=20&f=2014&g=d&ignore=.csv")
#      con=url(str)
#      htmlCode1=readLines(con)
#      close(con)
#      date<-rep(0,length(htmlCode))
#      idx<-rep(0,length(htmlCode))
#      for (i in 2:length(htmlCode)) {
#        tmp=htmlCode1[i]
#        tmp2=unlist(strsplit(tmp,","))
#        date[length(htmlCode)-i+2]=tmp2[1]
#        idx[length(htmlCode)-i+2]=tmp2[7]
#      }
#      date=as.Date(date[2:length(htmlCode)])
#      idx=as.numeric(idx[2:length(htmlCode)])  
#      scalar=idx[1]/price[1]
#      idx_=idx/scalar 
#      
#      
#      df1<-data.frame(date,price,idx_)
#      dfmelt = melt(df1, id=c("date"))
#      h<-hPlot(x="date",y="value",group="variable",data =dfmelt,type ="line")
#      h$set(dom ='price_plot', width = 600)
#      h
#    }

})

output$price_print <- renderPrint({
  ticker<-input$ticker
  index<-input$idx
  print(ticker)  
  print(index)
})