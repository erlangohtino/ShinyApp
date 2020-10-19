#' Shiny user interface for the Central Limit App
#' Data Science Course 9 project
#' 
#' This is the user-interface definition of a Shiny web application that
#' executes a number of runs of a random variable distribution simulation,
#' takes the means and pushes these averages in a histogram of means, which,
#' according to the Central Limit Theorem, should look like a gaussian.
#'
#' @param Samples The number of samples in each base distribution
#' @param Runs The number of samples in each base distribution
#' @param Distrib The kind of base distribution to simulate (exponential,
#'                uniform or log-normal)
#' @author Emilio González
#' @details In the user interface, there is a sidebar with the parameters of
#' the simulation: two slide bars are presented to choose the
#' number of samples in the distribution for each simulation and the number of
#' simulations to be conducted. There is also a choice of the base distribution
#' (exponential, uniform or log-normal). The distributions have been chosen to
#' have a similar mean for plotting purposes. A sample distribution is also
#' displayed at the bottom of the sidebar to show what an individual element
#' would look like; its mean, an others alike, will be accrued in a subsequent
#' histogram, which is depicted in the main panel of the window. The theoretical
#' and computed means are displayed as well. The range of this histogram is also
#' shown at the bottom.
#' 
#' @seealso shiny
#' @export
#' @import shiny              

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("The Central Limit Theorem"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("Samples",
                        "Number of samples:",
                        min = 5,
                        max = 100,
                        value = 40),
    
            sliderInput("Runs",
                        "Number of simulation runs:",
                        min = 20,
                        max = 300,
                        value = 200),
            radioButtons("Distrib","Distribution type",
                         c("Exponential"="exp","Uniform"="unif","Log-normal"="lnorm")),
            plotOutput("basePlot")
        ),
    
    # Show a plot of the generated distribution
        mainPanel(
            h5("This web application executes a number of runs of a random
            variable distribution simulation, takes the means and pushes these
            averages into a histogram, which, according to the Central Limit
            Theorem, should look like a gaussian."),
            div(),
            h5("Select in the sidebar the number of samples in each simulated
               distribution and the number of runs. You can also select the
               type of distribution to be simulated (displayed at the bottom of
               the sidebar)."),
            div(),
            plotOutput("distPlot"),
            h4("Range of the output:"),
            textOutput("text1")
        )
    )
))
