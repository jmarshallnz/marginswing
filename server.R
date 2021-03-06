library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot

  design_eff   <- 1

  col   <- c("blue", "red")

  draw_poly <- function(x, y, col, ypos=0) {
    polygon(c(x[1], x, x[length(x)]), ypos+c(0, y, 0), col=col, border=col)
  }

  fade_col <- function(col, alpha) {
    rgb(t(col2rgb(col)), alpha=alpha*255, maxColorValue=255)
  }

  # alternate: use normal approximation.
  # se(p_i) = sqrt(p_i*(1-p_i)/n)

  output$plot <- renderPlot({
    # compute effective sample size
    n <- input$n * (1-input$novote*0.01) / design_eff

    p <- c(input$right, input$left)*0.01

    # TODO: validate slider input: Must have right + left < 1
    if (sum(p) > 1) { # limit
    }

  se_p <- sqrt(p*(1-p)/n)

  s <- diff(p)
  se_s <- sqrt((sum(p) - diff(p)^2)/n)

  # suitable range is +/- 4 s.e.
  xmin <- min(p - 4*se_p, p[2] + s - 4*se_s)
  xmax <- max(p + 4*se_p, p[2] + s + 4*se_s)

  x <- seq(xmin, xmax, length.out=1000)
  y1 <- dnorm(x, p[1], se_p[1])
  y2 <- dnorm(x, p[2], se_p[2])
  ys <- dnorm(x, p[2] + s, se_s)
  pn <- pnorm(0, s, se_s)
  ymax <- max(y1, y2)*1.05

  z <- qnorm(0.975)

    plot_xmin <- c(25, 75)
    plot_ymax <- 30
    plot_cex  <- 1.3
    par(mai=c(0.5,0.1,0.1,0.1), mfrow=c(2,1))
    plot(NULL,xlab="F", ylab="", xlim=plot_xmin, ylim=c(0,plot_ymax), type="l", yaxt="n", main="")
    draw_poly(x*100, y1, fade_col(col[1], 0.3))
    draw_poly(x*100, y2, fade_col(col[2], 0.3))
    abline(v=p[1]*100, col=col[1], lwd=2)
    abline(v=p[2]*100, col=col[2], lwd=2)
    xpos <- plot_xmin[2]
    text(xpos, plot_ymax*0.95, "Option 1 vs Option 2", adj=c(1,0.5), cex=1.5)
    text(xpos, plot_ymax*0.80, sprintf("Option 1: %2.1f \U00b1 %2.2f", p[2]*100, se_p[2]*100*z), col=col[2], adj=c(1,0.5), cex=plot_cex)
    text(xpos, plot_ymax*0.65, sprintf("Option 2: %2.1f \U00b1 %2.2f", p[1]*100, se_p[1]*100*z), col=col[1], adj=c(1,0.5), cex=plot_cex)

    plot(NULL,xlab="F", ylab="", xlim=plot_xmin-p[2]*100, ylim=c(0,plot_ymax), type="l", yaxt="n", main="")
    xl <- (x - p[2])*100
    col <- data.frame(light=c(0.3,0.5), dark=c(0.7,1.0))
    if (sum(xl >= 0) < length(xl)*0.5)
      col <- col[2:1,]
    draw_poly(xl[xl >= 0], ys[xl >= 0], fade_col("black", col$light[1]))
    draw_poly(xl[xl < 0], ys[xl < 0], fade_col("black", col$light[2]))
    abline(v=0, col="black", lwd=2)
    abline(v=s*100, col="black", lwd=1)
    text(xpos - p[2]*100, plot_ymax*0.95, "Difference (Option 1 - Option 2)", adj=c(1,0.5), cex=1.5)
    text(xpos - p[2]*100, plot_ymax*0.80, sprintf("Swing: %2.1f \U00b1 %2.2f", s*100, se_s*100*z), adj=c(1,0.5), cex=plot_cex) 
    text(xpos - p[2]*100 - 2, plot_ymax*0.65, "Option 1 wins: ", adj=c(1,0.5), cex=plot_cex, col=fade_col("black", col$dark[1]))
    text(xpos - p[2]*100 - 2, plot_ymax*0.65, sprintf("%2.1f%%", (1-pn)*100), adj=c(0,0.5), cex=plot_cex, col=fade_col("black", col$dark[1]))
    text(xpos - p[2]*100 - 2, plot_ymax*0.50, "Option 2 wins: ", adj=c(1,0.5), cex=plot_cex, col=fade_col("black", col$dark[2]))
    text(xpos - p[2]*100 - 2, plot_ymax*0.50, sprintf("%2.1f%%", pn*100), adj=c(0,0.5), cex=plot_cex, col=fade_col("black", col$dark[2]))
  })

})

