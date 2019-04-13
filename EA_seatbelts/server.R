
library(shiny);library(dplyr);
library(forecast);library(zoo)

shinyServer(function(input,output) {
   data(Seatbelts);
   dates<-yearmon(time(Seatbelts))
   variable_names<-dimnames(Seatbelts)[[2]] 
   
   output$plot_data<-renderPlot({
      cuts<-input$sl_cut_data
      par(mfrow = c(8,1), oma = c(2,2,2,0) + 0.1,mar = c(0,0,1,1) + 0.1)
      for (i in 1:8){
         plot(Seatbelts[,i],main=variable_names[i],xlab="time")
         abline(v=dates[seq(1,nrow(Seatbelts),by=cuts)],col="blue",lwd=1)
      }
      title(main="Time series",outer = TRUE)
   })
   
   output$plot_ma<-renderPlot({
      ordMA<-input$sl_ordMA;
      vpos<-dates[seq(1,nrow(Seatbelts),by=12)]
      movingAv<-ma(Seatbelts,order=ordMA);
      par(mfrow = c(8,1), oma = c(2,2,2,0) + 0.1,mar = c(0,1,1,0) + 0.1)
      for (i in 1:8){
         abline(v=vpos,col="darkgrey",lwd=2)
         plot.ts(movingAv[,i],main=variable_names[i])
      }
      title(main=paste0("moving average over a ",ordMA," months window"),outer = TRUE)
   })
   
   
   lagCC<-eventReactive(input$act_cc,{
      input$sl_lagmax
   })
   
   output$plot_cc<-renderPlot({
      par(mfrow = c(8,1), oma = c(2,2,2,0) + 0.1,mar = c(0,0,1,1) + 0.1)
      for (i in 1:8){
         ccf(Seatbelts[,2],Seatbelts[,i],lag.max=lagCC(),type="correlation")
         title(main=variable_names[i])
      }
      title(main = paste0("Cross-correlation of drivers and ..."),outer = TRUE)
      
   })
})
