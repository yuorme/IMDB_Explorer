## IMDB Movie Explorer ##
## Author: David Yu ##
## http://github.com/yuorme ##
## Dataset is Hadley Wickham's IMDB Movie dataset included with ggplot2

library(shiny)
library(ggplot2)

movies <- movies

#convert genre columns from int to factors
for (i in 18:24) {
    movies[ ,i] <- as.factor(movies[ ,i])  
}

#log-votes weighted ratings - keeps causing errors server side
#movies$weightedRating <- log(movies$votes, 100) * movies$rating

#obtain meanVotes per year
#yearVote <- ddply(movies, "year", summarize, meanVotes = mean(votes))

shinyServer(function(input, output) {

    #subset data for the plot
    dat <- reactive(function() {
        movies[(movies$rating >= input$rating[1] &
                    movies$rating <= input$rating[2] &
                    movies$votes >= input$votes &
                    movies$year >= input$year[1] &
                    movies$year <= input$year[2] &
                    movies$length >= input$length[1] &
                    movies$length <= input$length[2])                
               , ]
    })
    
    #generates data for the summary statistics
    ### should make this subsettable by facets in the future
    dat2 <- reactive(function() {
        movies[(movies$rating >= input$rating[1] &
                    movies$rating <= input$rating[2] &
                    movies$votes >= input$votes &
                    movies$year >= input$year[1] &
                    movies$year <= input$year[2] &
                    movies$length >= input$length[1] &
                    movies$length <= input$length[2])                
            , c(input$x, input$y)]
    })
    
    #output plot
    output$plot <- renderPlot(function() {         
        
        #plots scatterplot or histogram depending on whether input x and y are equal
        if (input$x != input$y) {
            p <- ggplot(dat(), aes_string(x=input$x, y=input$y)) 
            p <- p + geom_point(alpha=input$alpha, size=input$size) + theme(legend.position="bottom")  
            p <- p + ggtitle(paste("Scatterplot of", input$x, "vs.", input$y))
        }
        else {
            p <- ggplot(dat(), aes_string(x=input$x)) 
            p <- p + geom_histogram() + theme(legend.position="right")
            p <- p + ggtitle(paste("Histogram of", input$x))
        }
        
        #ggplot title formatting
        p <- p + theme(plot.title = element_text(color="steelblue", size=18, face="bold"))
        
        if (input$color != 'None')
            p <- p + aes_string(color=input$color, fill=input$color)
        
        facets <- paste(input$facet_row, '~', input$facet_col)
        if (facets != '. ~ .')
            p <- p + facet_grid(facets)
        
        if (input$smooth & input$x != input$y)
            p <- p + geom_smooth()
        
        print(p)
                
    }, height=700)
    
    #output number of columns
    output$n_movies <- renderText({ nrow(dat()) })
    
    #output summary statistics
    ### should make this subsettable by facets in the future
    output$summary <- renderTable({ summary(dat2()) })    
    
    #output datatable
     output$table <- renderDataTable({
        dat()
        }, 
        options = list(aLengthMenu = c(15, 20, 30, 50, 100), 
                    iDisplayLength = 20))

})