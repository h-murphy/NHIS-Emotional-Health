##### Hannah Murphy
##### Hannah Murphy
##### Final Project - Bubble Graph
##### Created 11/26/16
##### Modified 11/26/16

##### UI FILE

library(googleCharts)
# Use global max/min for axes so the view window stays
# constant as the user moves between years
xlim <- list(
  min = min(bubbledata$Age), #- 500,
  max = max(bubbledata$Age) #+ 500
)
ylim <- list(
  min = min(bubbledata$Score)-0.5,
  max = 2#max(bubbledata$Score) + 3
)

shinyUI(fluidPage(
  #mainPanel(
    tabsetPanel(
      tabPanel("Explore",
  # This line loads the Google Charts JS library
  googleChartsInit(),
  
  # Use the Google webfont "Source Sans Pro"
  tags$link(
    href=paste0("http://fonts.googleapis.com/css?",
                "family=Source+Sans+Pro:300,600,300italic"),
    rel="stylesheet", type="text/css"),
  tags$style(type="text/css",
             "body {font-family: 'Source Sans Pro'}"
  ),
  
  h3("Severity of Emotional Health Problems by Demographic Group"),
  
  googleBubbleChart("chart",
                    width="100%", height = "475px",
                    # Set the default options for this chart; they can be
                    # overridden in server.R on a per-update basis. See
                    # https://developers.google.com/chart/interactive/docs/gallery/bubblechart
                    # for option documentation.
                    options = list(
                      fontName = "Source Sans Pro",
                      fontSize = 13,
                      # Set axis labels and ranges
                      hAxis = list(
                        title = "Age (years)",
                        viewWindow = xlim
                      ),
                      vAxis = list(
                        title = "Response Severity",
                        viewWindow = ylim
                      ),
                      # The default padding is a little too spaced out
                      chartArea = list(
                        top = 50, left = 75,
                        height = "75%", width = "75%"
                      ),
                      # Allow pan/zoom
                      explorer = list(),
                      # Set bubble visual props
                      bubble = list(
                        opacity = 0.25, stroke = "none",
                        # Hide bubble label
                        textStyle = list(
                          color = "none"
                        )
                      ),
                      # Set fonts
                      titleTextStyle = list(
                        fontSize = 16
                      ),
                      tooltip = list(
                        textStyle = list(
                          fontSize = 12
                        )
                      )
                    )
                  ),
  #),
  checkboxGroupInput("raceGroup", label = h3("Race"), 
                      choices = list("White" = "White", "Black" = "Black", "Asian" = "Asian", "Native American" = "Native American", "Multiple" = "Multiple"),
                      selected = "White")
      
 #  checkboxGroupInput("sexGroup", label = h3("Sex"), 
 #                     choices = list("Male" = "Male", "Female" = "Female"),
 #                     selected = "Male")
      ),
 tabPanel("Test",
        #  h1("Hello World"),
          # Copy the line below to make a select box 
        sidebarPanel(
          selectInput("group1", label = h3("Select First Comparison Group:"), 
                      choices = list("White Men" = 1, "White Women" = 2, "Black Men" = 3, "Black Women" = 4, "Asian Men" = 5, "Asian Women" = 6, "Native American Men" = 7, "Native American Women" = 8, "Two or More Races Men" = 9, "Two or More Race Women" = 10), 
                      selected = 1),
          selectInput("group2", label = h3("Select Second Comparison Group:"), 
                   choices = list("White Men" = 1, "White Women" = 2, "Black Men" = 3, "Black Women" = 4, "Asian Men" = 5, "Asian Women" = 6, "Native American Men" = 7, "Native American Women" = 8, "Two or More Races Men" = 9, "Two or More Race Women" = 10), 
                   selected = 1),
             
          actionButton("test", label = "Run Test")
        ),
        mainPanel(
          dataTableOutput("ttestinfo"),
          plotOutput(outputId = "boxplot", height = "600px")
          )
        )
    )#)
))
