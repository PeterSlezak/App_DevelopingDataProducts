library(shiny)

shinyServer(function(input, output) {
    
    means<-NULL
    CIcoverage<-NULL
    
    # Generate a plot
    output$plot <- renderPlot(width=650,height=600,{

        far="red"   # plot colour
        n<-input$n;       nosim<-input$nosim
        avg<-input$mu;    sd<-input$sd
        x<-rnorm(input$n, input$mu, input$sd)
    
        #Generate sample means
        means<<-1:nosim
        CIcoverage<<-1:nosim
        
        for (i in 1:nosim) {
            means[i] <<-mean(rnorm(n, avg, sd))
            ll<-means[i]-1.96*sd/sqrt(n)
            ul<-means[i]+1.96*sd/sqrt(n)
            if(ll < avg & ul > avg){ 
                CIcoverage[i]<<-1
            }else{CIcoverage[i]<<-0}
        }
    
        # x-axis limits
        xmin=-55 #10+(4*10)
        xmax=55  #10-(4*10)
        

        par(mfrow=c(3,1),mar=c(3,5,2,0), bty='n') 
        
        # Plot population distribution
        x0 = seq(xmin,xmax,length.out=1000);
        y0 = dnorm(x0, avg, sd)
        y0=y0/sum(y0)
        plot(x0, y0, type="l", lwd=2, col=far, main="Population Distribution", xlab="", 
             ylab="Probability", cex.lab=2, cex.axis=2, cex.main=2) 
 
        # plot typical data sample with mean and 95%CI of the mean
        stripchart(round(x,0), xlim=c(xmin,xmax), method='stack', main="Typical Data Sample", 
            col=far, pch=15, cex.axis=2, cex.main=2, cex=1, at=0.001)
        points(mean(x),0.4, pch=18, col='black', cex=1.5)
        ll<-mean(x)-1.96*sd/sqrt(n)
        ul<-mean(x)+1.96*sd/sqrt(n)
        arrows(ll, 0.4, ul, 0.4, cex=3, code=3, angle=20, length=0.05)

        # plot histogram of sample means
        hist(means, main="Distribution of Sample Means", warn.unused = FALSE, border=far, 
            xlab="", xlim=c(xmin,xmax), cex.lab=2, cex.axis=2, cex.main=2)
      })  

    output$table <- renderTable({
        value<-c(input$mu, input$sd, input$n, input$nosim, mean(means), mean(CIcoverage))
        info<-c("Population Mean", "Sigma", "Sample Size", "Number of repetitions", 
                "Mean of the Distribution of Sample Means", 
                "Proportion of 95% CIs covering the population mean value")
        format(data.frame(info, value), digits=5)
        
#     refresh<-reactive({
#         a<-input$n
#         b<-input$nosim
#         c<-input$mu
#         d<-input$sd
#         means<-NULL
#         CIcoverage<-NULL
#     })
    
#     output$CIcov<-renderPrint({
#         refresh()
#         mean(CIcoverage)
#     })
    
    })
})