#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(gridExtra)
library(caret)
library(randomForest)
set.seed(500)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  
  output$Datatable <- renderDataTable(ChickWeight,options = list(pageLength = 5) )
  
  ####Calculate Training and Test Dataset
  SampleData<-ChickWeight
  SampleData<-SampleData[!(SampleData$Time==0),]
  singleRowRec<-SampleData[SampleData$Chick==18,]
  singleRowRec<-data.frame(weight=35,Time=2,Chick=18,Diet=1:4)
  SampleData<-rbind(SampleData,singleRowRec)
  SampleData$Chick<-as.factor(SampleData$Chick)
  SampleData$Diet<-as.factor(SampleData$Diet)
  #inTrain <- createDataPartition(y=paste(SampleData$Chick,SampleData$Diet), p=0.6, list=FALSE)
  inTrain <- createDataPartition(y=SampleData$weight, p=0.6, list=FALSE)
  
  training60 <- SampleData[inTrain, ]
  testing40 <- SampleData[-inTrain, ]
  Mod1<-randomForest(weight~.,data=training60)
  pred1 <- predict(Mod1, testing40, type = "class")
  
  Mod2<-glm(weight~.,data=training60)
  pred2 <- predict(Mod2, testing40)
  
  ###Input Chick parameters
  ChickParam<-reactive({
    
    data.frame(Time=input$time,Chick=input$ChikType,Diet=input$dietType) 
   
  })
  
  output$QuestionChick<-renderDataTable(ChickParam())
  
  
  QuestDataMod1<-reactive({

   QDataset<-data.frame(Time=input$time,Chick=input$ChikType,Diet=input$dietType)
   QDatasetPred<-rbind(testing40[,-1],QDataset)
   QDatasetPred<-QDatasetPred[length(QDatasetPred$Time),]
   
   predict(Mod1,QDatasetPred)

   })
  
  QuestDataMod2<-reactive({
    
    QDataset<-data.frame(Time=input$time,Chick=input$ChikType,Diet=input$dietType)
    QDatasetPred<-rbind(testing40[,-1],QDataset)
    QDatasetPred<-QDatasetPred[length(QDatasetPred$Time),]
    
    predict(Mod2,QDatasetPred)
    
  })
  
  
   output$Mod1_Pred<-renderText(QuestDataMod1())
  
   output$Mod2_Pred<-renderText(QuestDataMod2())
   
  ###Plot the training and Test Dataset
  
  output$GrowthCurve<-renderPlot({ 
    
      plotDataMod1<-data.frame(weight=QuestDataMod1(),ChickParam())
      plotDataMod2<-data.frame(weight=QuestDataMod2(),ChickParam())
      
      p1<-ggplot(ChickWeight, aes(x=Time, y=weight, colour=Diet, group=Chick))+geom_line()
      p2<-p1+geom_point(data=ChickWeight,aes(x=Time, y=weight, colour=Diet, group=Chick),size=2)
      p3<-p2+geom_point(data=plotDataMod1,aes(x=Time, y=weight),color="Red",size=6)+geom_text(aes(x=plotDataMod1$Time,y=plotDataMod1$weight),label="model-1",color="black")
      p4<-p3+geom_point(data=plotDataMod2,aes(x=Time, y=weight),colour="blue",size=6)+geom_text(aes(x=plotDataMod2$Time,y=plotDataMod2$weight),label="model-2",color="black")
      p5<-p4+ggtitle("Growth curve for individual chicks")
    
      p5
    })
  
  
  output$ChickenSampleDataPlot<-renderPlot({
   
        p1<-ggplot(training60,aes(x=Chick,y=weight,color=training60$Diet))+geom_boxplot()
        p2<-ggplot(testing40,aes(x=Chick,y=weight,color=testing40$Diet))+geom_boxplot()
    
        grid.arrange(p1,p2,nrow=2)
        
        
        })
  
  output$ChickenExplorePlot<-renderPlot({
    

    # First plot
        p1 <- ggplot(ChickWeight, aes(x=Time, y=weight, colour=Diet)) +
        geom_point(alpha=.3) +geom_smooth(alpha=.2, size=1) +ggtitle("Fitted growth curve per diet")
    

    # Second plot
        p2 <- ggplot(subset(ChickWeight, Time==21), aes(x=weight, fill=Diet)) +
        geom_histogram(colour="black", binwidth=50) +facet_grid(Diet ~ .) +
        ggtitle("Final weights Histogram --counts of Chicken who achieved this, by diet after 21 Weeks") +
        theme(legend.position="none") 
    
      grid.arrange(p1,p2,nrow=1,ncol=2)
  }) 
  
  
 
  
  
  output$Mod1PredictionTruth1<-renderPlot({
    
    cm1<-data.frame(predicted=pred1,testing40)
    
    ggplot(cm1, aes(Chick)) +geom_boxplot(aes(y = weight, colour = "weight"))+geom_boxplot(aes(y = predicted, colour = "predicted"))
    
    
    
  }) 
  
  
  
  output$Mod1Prediction2Truth2<-renderPlot({
    
    plot(testing40$weight,col="green",lwd=5,type="l")
    lines(pred1,col="red")
    
    
  }) 
  
  
  output$Mod2PredictionTruth1<-renderPlot({
    
    cm2<-data.frame(predicted=pred2,testing40)
    
    ggplot(cm2, aes(Chick)) +geom_boxplot(aes(y = weight, colour = "weight"))+geom_boxplot(aes(y = predicted, colour = "predicted"))
    
    
    
  }) 
  
  
  
  output$Mod2PredictionTruth2<-renderPlot({
    
    plot(testing40$weight,col="green",lwd=5,type="l")
    lines(pred2,col="blue")
    
    
  }) 
  
  url <- a("GitHub Documentation Page for this Assignment", href="https://github.com/indradwipdutta/CourseraDataProducts-Week4-Assignment")
  output$tab <- renderUI({
    tagList("URL link:", url)
  })
})
