## IMDB Movie Explorer ##
## Author: David Yu ##
## http://github.com/yuorme ##
## Dataset is Hadley Wickham's IMDB Movie dataset included with ggplot2

library(shiny)
library(ggplot2)

dat <- movies

shinyUI(pageWithSidebar(
    
    headerPanel("IMDB Movie Explorer"),
    
    sidebarPanel(
        
        # Scatterplot Axes
        wellPanel(
        helpText(HTML("<font color='steelblue'><b>AXES</b></font>")),
        selectInput('x', 'X', names(dat[ ,c(2:6)])), #x-axis data with default set to names(dat)[2]
        selectInput('y', 'Y', names(dat[ ,c(2:6)]), names(dat)[[3]]), #y-axis data with default set to names(dat)[3] 
        HTML("Default output is scatterplot. Set X = Y for histogram. View 'Help' Tab for more details.")
        ),
            
        # Subsetting the data 
        wellPanel(
        helpText(HTML("<font color='steelblue'><b>SUBSET</b></font>")),
        sliderInput('votes', 'Minimum IMDB Votes', min=50, max=10000, 
                    value=500, step=50, round=FALSE),
        sliderInput('rating', 'IMDB User Rating', min=min(dat$rating), max=max(dat$rating),
                    value=c(min(dat$rating), max(dat$rating)), step=0.5, round=FALSE),
        sliderInput('year', 'Year Released', min=min(dat$year), max=max(dat$year), 
                    value=c(min(dat$year), max(dat$year)), step=1, round=FALSE),
        sliderInput('length', 'Length (minutes)', min=min(dat$length), max=350, 
                    value=c(min(dat$length), 350), step=10, round=FALSE)
        ),
        
        # ggplot2 aesthetics
        wellPanel(
        helpText(HTML("<font color='steelblue'><b>AESTHETICS</b></font>")),        
        selectInput('color', 'Colour by', c('None', names(dat[ ,c(17:24, 2:6)]))), #color by factor variables       
        sliderInput('alpha', 'Set Transparency', min=0, max=1,
                    value=0.3, step=0.05),
        sliderInput('size', 'Set Point Size', min=1, max=5,
                    value=2, step=0.5),
        helpText(HTML("<font color='steelblue'><b>SMOOTH</b></font>")),
        checkboxInput('smooth', 'Smooth', value=TRUE)
        ),

        
        #ggplot2 faceting
        wellPanel(
        helpText(HTML("<font color='steelblue'><b>FACETS</b></font>")),
        selectInput('facet_row', 'Facet Row', c(None='.', names(dat[ ,17:24]))), #facet by by factor variables
        selectInput('facet_col', 'Facet Column', c(None='.', names(dat[ ,17:24]))) #facet by by factor variables
        ),
        
        width=3
        
    ),
    
    mainPanel(
        tabsetPanel(
            
            tabPanel('Plot', plotOutput('plot', height="auto")),
            tabPanel('Table',  dataTableOutput("table")),
            tabPanel('Help', includeHTML('docs/help.html')),
            tabPanel('Codebook', includeHTML('docs/codebook.html'))
            
        )
    )
))