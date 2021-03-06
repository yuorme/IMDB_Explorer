IMDB_Explorer
=============

https://yuorme.shinyapps.io/IMDB_Explorer/

###Introduction and Credits
This [ShinyApp](https://www.shinyapps.io/) allows for interactive exploration of Hadley Wickham\'s IMDB Movie database (see codebook for more details). It was inspired by [Garrett Grolemund's](https://github.com/garrettgman) excellent ['Movie Explorer'](http://shiny.rstudio.com/gallery/movie-explorer.html) app. These plots are currently rendered using `ggplot2` instead of `ggvis` and therefore lacks the interactive tooltip functionality of the original. Code has been modified from the ggplot2-based [Diamond Explorer](https://github.com/rstudio/shinyapps/blob/master/guide/guide.md)

###Plot Tab
The default inputs generate a time-series scatterplot of movie length plotted by year with a line plotting the smoothed conditional mean. Two other interesting comparisons I've discovered using this tool are **year (x) vs. rating (y)**, and **length (x) vs. rating (y)**. The options present in the sidebar should be reasonably intuitive, especially for users familiar with `ggplot2` functionality. A brief description of each input is listed below:

####Axes
- X and Y axes can be set to one of six numerical variables (year, length, budget, user rating, votes). If X and Y are set to different variables, a **scatterplot** is generated. If X and Y are set to the same variable, a **histogram** is generated.

####Subset
- Sliders can be used to subset the original dataset according to four criteria (votes, user rating, year, length)

####Aesthetics
- Points can be coloured by one of eight factor variables (MPAA rating, and 7 genres) or six numerical variables (year, length, budget, user rating, votes). 
- The transparency and size of the points can be set by sliders. 
- Finally, the smoothed conditional mean can be toggled on or off using the checkbox.

####Facets
- Plots can be facetted by rows and columns using one of eight factor variables (MPAA rating, and 7 genres)

####Reactive Count and Summary Statistics
- Subsetting the data will trigger updating of the reactive Counts and Summary Statistics Boxes below the plot. These result from the output of the `nrows` and `summary` functions, respectively.

###Table Tab

Returns a reactively-subsetted, searchable and sortable table using the `shiny::renderDataTable` function. This function makes use of the Javascript library DataTables to generate the output. 

###Code
https://github.com/yuorme/IMDB_Explorer
