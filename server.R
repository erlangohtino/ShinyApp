#' Shiny user interface for the Central Limit App
#' Data Science Course 9 project
#' 
#' This is the server logic of a Shiny web application that
#' executes a number of runs of a random variable distribution simulation,
#' takes the means and pushes these averages in a histogram of means, which,
#' according to the Central Limit Theorem, should look like a gaussian.
#'
#' @param basePlot Histogram of the distributions being simulated.
#' @param distPlot Resulting means histogram
#' @param text1 Range of the histogram
#'
#' @author Emilio González
#' @details The distribution of the selected type is simulated the number of
#' runs specified, with the number of samples selected, and its average is
#' pushed into a vector which is later on plotted. The range of the resulting
#' distribution is output, to check that, the smaller the number of samples,
#' the higher the standard deviation. It also can be checked that the higher
#' the number of runs, the better a gaussian-like distribution is shaped.
#' The base distribution (using 500 samples) is also plotted, for information.
#' The theoretical mean of the distribution (red vertical line)
#' and the computed mean of the histogram (blue vertical line) are plotted as
#' well. In average, these two values are closer one another when the chosen
#' values are large.
#' 
#'  
#' @seealso shiny
#' @export
#' @import shiny              

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    # generate simulations based on input$Samples and input$Runs from ui.R
    set.seed(50)
    lambda<-0.2
    
    mns<-reactive({ 
    mns=NULL
    n <- input$Samples
    # Accumulate means into the mns structure
    for (i in 1 : input$Runs) mns = switch(input$Distrib,
                                           exp=c(mns, mean(rexp(n,lambda))),
                                           unif=c(mns,mean(runif(n,0,10))),
                                           lnorm=c(mns,mean(rlnorm(n,1.11)))
                                        )
    mns
    })
    
    # draw the histogram of the elementary distribution chosen
    output$basePlot <- renderPlot({
        
        dist<-switch(input$Distrib,
                     exp=rexp(500,0.2),
                     unif=runif(500,0,10),
                     lnorm=rlnorm(500,1.11))
        hist(dist,xlab="x", ylab="y",
             main="Base distribution")


    },        height=300)
    
    # draw the means histogram with the specified data
    output$distPlot <- renderPlot({

        hist(mns(), xlim=c(2,8), breaks=25,xlab="x", ylab="y",
             main="Distribution of the means (pdf)")

        # Compute the theoretical mean and the computed mean
        mu_mns <- mean(mns())
        mu_0<-switch(input$Distrib,
             exp=1/lambda,
             unif=5,
             lnorm=exp(1.11+0.5))

        # Display the theoretical mean and the computed mean.
        abline(v=mu_0, col="red",lwd=3)
        abline(v=mu_mns,col="blue",lwd=2)
        
    })
    
    # text1 is the range of the histogram
    output$text1<-renderText({range(mns())})

})
