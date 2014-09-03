library(shiny)
library(markdown)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

#  mainPanel(

  titlePanel("The margin of error for the left/right swing", "Swinging at the margin"),
  hr(),

  sidebarLayout(
    sidebarPanel(
                 withMathJax(includeMarkdown("propdiff.md"))
    ),
    mainPanel(
      wellPanel(fluidRow(
                column(3,sliderInput("left",
                  "Percentage of vote for the left:",
                  min = 10,
                  max = 100,
                  step = 0.5,
                  value = 39)),
                column(3,sliderInput("right",
                  "Percentage of vote for the right:",
                  min = 10,
                  max = 100,
                  step = 0.5,
                  value = 48)),
               column(3,sliderInput("n",
                  "Number of voters polled:",
                  min = 0,
                  max = 1200,
                  step = 1,
                  ticks = F,
                  value = 809)),
               column(3,sliderInput("novote",
                  "Percentage of voters with no preference:",
                  min = 0,
                  max = 20,
                  step = 0.5,
                  ticks = F,
                  value = 6.5)))
      ),
      plotOutput("plot")
    )
  )
))

