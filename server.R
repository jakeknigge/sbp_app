library(shiny)
library(rmarkdown)
library(markdown)

# Define server logic required to summarize and view the selected
# dataset
shinyServer(function(input, output) {
      
      output$ui_param_1 <- renderUI({
            if (is.null(input$baseMeasure))
                  return()
            
            switch(input$baseMeasure,
                  "normal" = sliderInput(inputId = "locationParam", 
                                          label = "Select the normal's mean:", 
                                          min = -20, max = 20, value = 0, step = 1),
                  "gamma" = sliderInput(inputId = "locationParam", 
                                          label = "Select the gamma's shape parameter:", 
                                          min = 1, max = 20, value = 3, step = 0.5),
                  "beta" = sliderInput(inputId = "locationParam", 
                                          label = "Select the beta's first shape parameter:", 
                                          min = 1, max = 10, value = 2, step = 0.5),
                  "cauchy" = sliderInput(inputId = "locationParam", 
                                          label = "Select the cauchy's location parameter:", 
                                          min = -20, max = 20, value = 0, step = 1)
            )
      })
      
      output$ui_param_2 <- renderUI({
            if (is.null(input$baseMeasure))
                  return()
            
            switch(input$baseMeasure,
                   "normal" = sliderInput(inputId = "scaleParam", 
                                          label = "Select the normal's standard deviation:", 
                                          min = 1, max = 10, value = 2, step = 1),
                   "gamma" = sliderInput(inputId = "scaleParam", 
                                          label = "Select the gamma's rate parameter:", 
                                          min = 1, max = 20, value = 5, step = 1),
                   "beta" = sliderInput(inputId = "scaleParam", 
                                          label = "Select the beta's second shape parameter:", 
                                          min = 1, max = 10, value = 3, step = 0.5),
                   "cauchy" = sliderInput(inputId = "scaleParam", 
                                          label = "Select the cauchy's scale parameter:", 
                                          min = 1, max = 15, value = 3, step = 1)
            )
      })
      
      # Return the requested base measure
      baseMeasureInput <- reactive({
            switch(input$baseMeasure,
                   # Update base mesasure based on user's selections
                   "normal" = rnorm(n = input$n, 
                                    mean = input$locationParam, 
                                    sd = input$scaleParam),
                   "gamma" = rgamma(n =input$n, 
                                    shape = input$locationParam, 
                                    rate = input$scaleParam),
                   "beta" = rbeta(n = input$n, 
                                  shape1 =  input$locationParam, 
                                  shape2 = input$scaleParam),
                   "cauchy" = rcauchy(n = input$n, 
                                      location = input$locationParam, 
                                      scale = input$scaleParam))
      })
      
      stickBreakingWeights <- reactive({
            # Sample beta weights
            betas <- rbeta(input$n, 1, input$alpha)
            
            # Create dummy vector for product calculation
            sticks <- 1 - betas
            
            # Initialize product results vector
            stick_prod <- rep(0, input$n)
            
            # Calculate products before pi loop
            # Remove loop and replace with vectorized code
            #for(i in 1:(input$n)){
            #      stick_prod[i] <- prod(sticks[1:i])
            #}
            stick_prod <- cumprod(sticks)
            
            # Stick-breaking weights
            pi <- rep(0, input$n)
            pi[1] <- betas[1]
            
            # Remove loop and replace with vectorized code
            #for(i in 2:(length(pi)-1)){
            #      pi[i] <- betas[i] * stick_prod[i-1]
            #}
            pi[2:(length(pi)-1)] <- betas[2:(length(pi)-1)] * stick_prod[1:(length(pi)-2)]
            
            # Allocate remaining mass to last pi weight
            pi[length(pi)] <- 1 - sum(pi[1:(input$n)-1])
            pi
      })
      
      ## Generate a summary of the dataset
      summaryData <-  reactive({
            data.frame(Statistic = c("minimum", "mean", "maximum", "longest stick"), 
                        Value = as.character(
                              c(round(min(baseMeasureInput()), 3), 
                                round(sum(stickBreakingWeights() * baseMeasureInput()), 3),
                                round(max(baseMeasureInput()), 3),
                                round(max(stickBreakingWeights()), 3)),
                       stingsAsFactors = FALSE))
      })
      
      output$summary <- renderTable({
            summaryData()
      })
      
      # Fill in the spot we created for a plot
      output$sbpPlot <- renderPlot({
            # Render a plot
            plot(x = baseMeasureInput(), y = stickBreakingWeights(),
                  ylab = "atom weights",
                  xlab = "atom locations",
                  type = "h",
                  col = "orange", 
                  lwd = 3,
                  axes = TRUE,
                  frame.plot = FALSE
                 )
            # Add points to plot
            points(baseMeasureInput(), 
                   stickBreakingWeights(), 
                   pch = 19,
                   cex = 1.5,
                   col = "orange")
      })
})
