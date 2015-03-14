library(shiny)
library(markdown)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

#  mainPanel(

  titlePanel("The margin of error for competing options", "Swinging at the margin"),
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
                  value = 30)),
                column(3,sliderInput("right",
                  "Percentage voting option 2:",
                  min = 10,
                  max = 100,
                  step = 1,
                  value = 35)),
               column(3,sliderInput("n",
                  "Number of voters polled:",
                  min = 100,
                  max = 1200,
                  step = 10,
                  ticks = F,
                  value = 500)),
               column(3,sliderInput("novote",
                  "Percentage of voters with no preference:",
                  min = 0,
                  max = 20,
                  step = 1,
                  ticks = F,
                  value = 5)))
      ),
      plotOutput("plot", height="400px")
    )
  ),
  mainPanel(withMathJax(includeMarkdown("propdiff.md")), width=12)
))

