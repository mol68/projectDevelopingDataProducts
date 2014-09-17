library(shiny)
simulation<-function(mu,sigma,n,conf,numsim){
	a<-qnorm((100-conf)/200, mean = 0, sd = 1, lower.tail = TRUE)
	samples<-NULL
	extinf<-NULL
	extsup<-NULL
	include<-0
	for (i in 1:numsim)
	{
	samples[[i]]<-rnorm(n, mean = mu, sd = sigma)
	extinf[i]<-mean(samples[[i]])+a*sigma/sqrt(n)
	extsup[i]<-mean(samples[[i]])-a*sigma/sqrt(n)
	if ((extinf[i]<mu) & (extsup[i]>mu)) include<-include+1
	}
	intervals<-cbind(extinf,extsup)
	percent<-include*100/numsim
	return(list(intervals,percent))
}
	

shinyServer(
function(input, output) {
	output$ics <- renderPlot({
	muestra<-rep(NULL,1+input$numsim)
	par(mar=c(2,2,3,1))
	plot(muestra, xlim=c(-20,20), ylim=c(-6,1+input$numsim), xlab='', ylab='',main='')
	aux<-simulation(input$mu,input$sigma,input$n,input$conf,input$numsim)
	for (i in 1:input$numsim) segments(aux[[1]][i,1], i, aux[[1]][i,2], i, col = "#3399CC")
	abline(v=input$mu, col = "#FF6600", lty=1, lwd=2)
	text(input$mu+1.6, -3, paste("True mean value"),col = "#FF6600")
	mtext(paste("Intervals containing the true mean value = ", round(aux[[2]], 2),"%"),line= 1.5,cex=1.3,col = "#3366CC")
	mtext(paste("Interval length = ", round(aux[[1]][1,2]-aux[[1]][1,1], 2)),line= 0.2,cex=1.3,col = "#3366CC")
	})
})

