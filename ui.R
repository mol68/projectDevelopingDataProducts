library(shiny)
shinyUI(pageWithSidebar(
	titlePanel('Understanding confidence intervals through simulation'),
	sidebarPanel(
		h2('Simulation parameters'),
		sliderInput('mu', 'Mean:',value = 0, min = -10, max = 10, step = 0.05),
		sliderInput('sigma', 'Standard deviation:',value = 1, min = 0.05, max = 10, step = 0.05),
		sliderInput('conf', 'Confidence level:',value = 90, min = 89.9, max = 99.9, step = 0.1),
		sliderInput('n', 'Sample size:',value = 10, min = 5, max = 500, step = 1),
		sliderInput('numsim', 'Number of samples:',value = 100, min = 50, max = 500, step = 5)
	),
	mainPanel(
		h3('Confidence interval for the mean',align = "center",style = "color:grey"),		
		h4('Normal population with known variance',align = "center",style = "color:grey"),
		h6('For a given confidence level, several samples of the same size will lead to different numerical intervals, all with the same length because of the known variance',align = "center",style = "color:grey"),
		h6('With a large number of samples, the percentage of intervals containing the true value of the mean approximates the confidence level',align = "center",style = "color:grey"),
		plotOutput("ics")
		)
))
