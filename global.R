#bubbledata <- read.csv("bubbledata-v3.csv")
bubbledata <- read.csv("master_bubble.csv")
bubbledata <- bubbledata[bubbledata$Bubble != 0,]
#bubbledata <- bubbledata[bubbledata$Race == "Black",]
bubbledata$Score <- as.numeric(bubbledata$Score)
bubbledata$Age <- as.numeric(bubbledata$Age)
bubbledata$LogBubble <- as.numeric(bubbledata$LogBubble)
bubbledata$Bubble <- as.character(bubbledata$Bubble)

tukey_values <- read.csv("tukey.csv", stringsAsFactors = FALSE)


#whitemen <- read.csv("whitemen.csv")
testdata <- read.csv("newGraphicsData.csv")#"testdata.csv")
#whitewomen <- read.csv("whitewomen.csv")

print("loading data")