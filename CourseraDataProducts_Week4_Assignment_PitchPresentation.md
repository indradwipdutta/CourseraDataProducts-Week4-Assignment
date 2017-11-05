Coursera DataProducts Week4 Assignment Pitch Presentation
========================================================
author: Indradwip Dutta
date: 05/11/2017
autosize: true
Project Introduction
========================================================
This project is based on the Dataset, 'Chickweight',of R library 'Datasets' 
It describes the effect on growth weight of chickens based on
- Type of chicken ,there are 50 different types of Chicken
- DietType of chicken ,there are 4 different types of diets that can be applied
- Number of weeks to feed the chicken is considered to check the final chicken weight

Split Datasets, 60% Training('training60') and 40% Testing('testing40') used to build two models,Mod1 with RF and Mod2 with GLM.Dynamic Model predictions on Chicken Weight in the  website link below.
https://iduttacoursera2017.shinyapps.io/CourseraDataProducts_Week4_Assignment/


Main Code for Model build 
========================================================

```r
library(caret)
library(randomForest)
set.seed(500)
SampleData<-ChickWeight
SampleData$Chick<-as.factor(SampleData$Chick)
SampleData$Diet<-as.factor(SampleData$Diet)
inTrain <- createDataPartition(y=SampleData$weight, p=0.6, list=FALSE)
training60 <- SampleData[inTrain, ]
testing40 <- SampleData[-inTrain, ]
Mod1<-randomForest(weight~.,data=training60)
pred1 <- predict(Mod1, testing40, type = "class")
Mod2<-glm(weight~.,data=training60)
pred2 <- predict(Mod2, testing40)
```

    Main Code for Prediction Plots
========================================================

```r
library(caret)
library(randomForest)
plot(testing40$weight,col="green",lwd=5,type="l",
     main = "Real vs Predicted for RF Model")
    lines(pred1,col="red")
    
  plot(testing40$weight,col="green",lwd=5,type="l",
       main = "Real vs Predicted for GLM Model")
    lines(pred2,col="blue")
```

    Prediction Plots for RF and GLM
========================================================

![plot of chunk unnamed-chunk-3](CourseraDataProducts_Week4_Assignment_PitchPresentation-figure/unnamed-chunk-3-1.png)
This shows that both the models have similar prediction patterns and are quite close to the truth
