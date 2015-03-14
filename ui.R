library(shiny)
library(markdown)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

#  mainPanel(

  titlePanel("The margin of error for a yes/no option", "Swinging at the margin"),
  hr(),

  sidebarLayout(
    sidebarPanel(includeMarkdown("intro.md")
    ),
    mainPanel(
      wellPanel(fluidRow(
                column(3,sliderInput("left",
                  "Percentage voting option 1:",
                  min = 10,
                  max = 100,
                  step = 1,
                  value = 42)),
                column(3,sliderInput("right",
                  "Percentage voting option 2:",
                  min = 10,
                  max = 100,
                  step = 1,
                  value = 48)),
               column(3,sliderInput("n",
                  "Number of voters polled:",
                  min = 100,
                  max = 1200,
                  step = 10,
                  ticks = F,
                  value = 1000)),
               column(3,sliderInput("novote",
                  "Percentage of voters with no preference:",
                  min = 0,
                  max = 20,
                  step = 1,
                  ticks = F,
                  value = 10)))
      ),
      plotOutput("plot", height="400px")
    )
  ),
  mainPanel(withMathJax(includeMarkdown("propdiff.md")), width=12)
))

