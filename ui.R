library(shiny)
 
shinyUI(fluidPage(
    
    titlePanel("Distribution of Sample Means and Confidence Intervals"),
  
    sidebarLayout(
        sidebarPanel(
            
            sliderInput("mu", strong("Mean:"), value=0, min=-10, max=10),
            br(),
            sliderInput("sd", strong("Sigma:"), value=5, min=1, max=10),
            br(),      
            sliderInput("n", strong("Sample size:"), value=50, min=1, max=200),
            br(),
            sliderInput("nosim", strong("Number of repetitions:"), value=500, min=100, max=10000),
            br(),
            helpText("This is a simple application that generates and plots the distribution of 
                    sample means. The sample distributions are taken from a normally distributed
                    population. You can set the mean and sigma value of the population, the size of
                    generated samples, and the number of generated samples. The application then
                    displays the selected input values, computes the mean of the distribution of 
                    sample means and the proportions of 95% CI of the mean that contain the true
                    population value. The plots of the population, a typical sample with
                    depicted sample mean and 95% CI of the mean (black arrow in the 2nd plot), and  
                    histogram of sample means, are also generated.")
        ),
    
        mainPanel(
            tableOutput("table"),
            plotOutput("plot")            
        )
    )
))