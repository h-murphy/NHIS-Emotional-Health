##### Hannah Murphy
##### Final Project - Bubble Graph
##### Created 11/26/16
##### Modified 11/27/16

##### SERVER FILE

# required packages 

library(shiny)
library(dplyr)

shinyServer(function(input, output, session) {
  
  # Provide explicit colors for regions, so they don't get recoded when the
  # different series happen to be ordered differently from year to year.
  # http://andrewgelman.com/2014/09/11/mysterious-shiny-things/
  defaultColors <- c("#3366cc", "#dc3912", "#ff9900", "#109618", "#990099", "#0099c6", "#dd4477")
  series <- structure(
    lapply(defaultColors, function(color) { list(color=color) }),
    names = levels(bubbledata$Race)
  )
  
  yearData <- reactive({
    # Filter to the desired year, and put the columns
    # in the order that Google's Bubble Chart expects
    # them (name, x, y, color, size). Also sort by region
    # so that Google Charts orders and colors the regions
    # consistently.
    #print(input$raceGroup)
    if(length(input$raceGroup) > 0){
      if(length(input$raceGroup) == 1){
      df <- bubbledata %.%
        filter(Race == input$raceGroup[1]) 
      }else if(length(input$raceGroup) == 2){
        df <- bubbledata %.%
          filter(Race == input$raceGroup[1] | Race == input$raceGroup[2])# %.%
      }else if(length(input$raceGroup) == 3){
        df <- bubbledata %.%
          filter(Race == input$raceGroup[1] | Race == input$raceGroup[2] | Race == input$raceGroup[3])# %.%
      }else if(length(input$raceGroup) == 4){
        df <- bubbledata %.%
          filter(Race == input$raceGroup[1] | Race == input$raceGroup[2] | Race == input$raceGroup[3] | Race == input$raceGroup[4])# %.%
      }else if(length(input$raceGroup) == 5){
        df <- bubbledata %.%
          filter(Race == input$raceGroup[1] | Race == input$raceGroup[2] | Race == input$raceGroup[3] | Race == input$raceGroup[4] | Race == input$raceGroup[5])# %.%
      }#%.%
       # filter(Sex == input$sexGroup) %.%
       # select(Bubble, Age, Score,
        #       Race, LogBubble) %.%
       # arrange(Race)
      
      #df$Score <- as.numeric(df$Score)
    }
      df
      #print(head(df))
   # }
    #else{
    #  df <- data.frame("Race" = "", "Age" = 0, "Score" = 0, "Sex" = "", "Bubble" = 0)
    #}
  })
  
  testData1 <- reactive({
    if(input$group1 == 1){
      testdf1 = testdata[testdata$Sex == "Male" & testdata$Race == "White",]
    }else if(input$group1 == 2){
      testdf1 = testdata[testdata$Sex == "Female" & testdata$Race == "White",]
    }else if(input$group1 == 3){
      testdf1 = testdata[testdata$Sex == "Male" & testdata$Race == "Black",]
    }else if(input$group1 == 4){
      testdf1 = testdata[testdata$Sex == "Female" & testdata$Race == "Black",]
    }else if(input$group1 == 5){
      testdf1 = testdata[testdata$Sex == "Male" & testdata$Race == "Asian",]
    }else if(input$group1 == 6){
      testdf1 = testdata[testdata$Sex == "Female" & testdata$Race == "Asian",]
    }else if(input$group1 == 7){
      testdf1 = testdata[testdata$Sex == "Male" & testdata$Race == "Native American",]
    }else if(input$group1 == 8){
      testdf1 = testdata[testdata$Sex == "Female" & testdata$Race == "Native American",]
    }else if(input$group1 == 9){
      testdf1 = testdata[testdata$Sex == "Male" & testdata$Race == "Multiple",]
    }else if(input$group1 == 10){
      testdf1 = testdata[testdata$Sex == "Female" & testdata$Race == "Multiple",]
    }
  })
  
  testdata2 <- reactive({
    if(input$group2 == 1){
      testdf2 = testdata[testdata$Sex == "Male" & testdata$Race == "White",]
    }else if(input$group2 == 2){
      testdf2 = testdata[testdata$Sex == "Female" & testdata$Race == "White",]
    }else if(input$group2 == 3){
      testdf2 = testdata[testdata$Sex == "Male" & testdata$Race == "Black",]
    }else if(input$group2 == 4){
      testdf2 = testdata[testdata$Sex == "Female" & testdata$Race == "Black",]
    }else if(input$group2 == 5){
      testdf2 = testdata[testdata$Sex == "Male" & testdata$Race == "Asian",]
    }else if(input$group2 == 6){
      testdf2 = testdata[testdata$Sex == "Female" & testdata$Race == "Asian",]
    }else if(input$group2 == 7){
      testdf2 = testdata[testdata$Sex == "Male" & testdata$Race == "Native American",]
    }else if(input$group2 == 8){
      testdf2 = testdata[testdata$Sex == "Female" & testdata$Race == "Native American",]
    }else if(input$group2 == 9){
      testdf2 = testdata[testdata$Sex == "Male" & testdata$Race == "Multiple",]
    }else if(input$group2 == 10){
      testdf2 = testdata[testdata$Sex == "Female" & testdata$Race == "Multiple",]
    }
  })
  
  observeEvent(input$test, {
  #ttest <- reactive({
    print("button pressed")
    t1 <- testData1()
    #t1 <- t1[complete.cases(t1),]

    t2 <- testdata2()
    #t2 <- t2[complete.cases(t2),]
    ttest <- t.test(t1$Score, t2$Score, var.equal = TRUE)
    
    mean_diff <- mean(t1[complete.cases(t1),]$Score) - mean(t2[complete.cases(t2),]$Score)
    
    conf_interval <- paste("[", round(ttest$conf.int[1], digits = 4), round(ttest$conf.int[2], digits = 4), "]")
    current_tukey <- tukey_values[tukey_values$Group1Sex == t1$Sex[1] & tukey_values$Group1Race == t1$Race[1] & tukey_values$Group2Sex == t2$Sex[1] & tukey_values$Group2Race == t2$Race[1],]
    print(current_tukey)
    tukey_padj <- current_tukey$padj
    tukey_conf_interval <- paste("[", round(current_tukey$lwr, digits = 4), round(current_tukey$upr, digits = 4), "]")
    
    ttest_df <- data.frame("Difference in Means" = round(mean_diff, digits = 10), "p-Value" = round(ttest$p.value, digits = 10), "t-Statistic" = round(ttest$statistic, digits = 4), "Confidence Interval" = conf_interval, "Tukey p-Value" = tukey_padj, "Tukey Confidence Interval" = tukey_conf_interval)
    output$ttestinfo <- renderDataTable(ttest_df, escape = FALSE, options = list(paging = FALSE, searching = FALSE))
    
    output$boxplot <- renderPlot({
      t1$Group <- paste(t1$Sex[1], " - ", t1$Race[1])
      t2$Group <- paste(t2$Sex[1], " - ", t2$Race[1])
      
      all <- rbind(t1, t2)
      
      boxplot(Score ~ Group, all, main = "Testing Assumptions: Check for Equal Variance", ylab = "Score", xlab = "Demographic Group")
      })
    })
  
  
  output$chart <- reactive({
    # Return the data and options
    list(
      data = googleDataTable(yearData()),#bubbledata),
      options = list(
        title = sprintf(
          "Severity of Emotional Health Problems by Race and Age", ""),#,
        #input$year),
        series = series
      )
    )
  })
  
})