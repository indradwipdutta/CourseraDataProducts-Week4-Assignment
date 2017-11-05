#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)


shinyUI(fluidPage(
  
  
  # Application title
  titlePanel(h3("Predict weight of chicken",style="color:steelblue")),
  h4("Coursera Assignment Week4-Part1,Shiny Application  |  Author:Indradwip Dutta",style="color:steelblue"),
    # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(

       h4('Input Your Chicken Data',style="color:steelblue"),
       
       #selectInput("ChikType","Enter the type of Chick you have (1 ---48)",choices = c(1:48)),
       
       
       
       sliderInput("ChikType",h5("Enter the type of Chick you have (1 ---50)",style="color:steelblue"),1,50,value =10 ),
       
       
       #sliderInput("dietType","Enter the type of Diet You shall Feed",1,4,value =2 ),
       selectInput("dietType",h5("Enter the type of Diet You shall Feed",style="color:steelblue"),choices = c(1:4)),
       
       
       sliderInput("time",h5("Enter Predicted Chicken Weight after How many Weeks",style="color:steelblue"),1,20,value =12 ),
       
        
       
         h4("As per Model2(Random Forest) Your Chick's weight in grams will be",style="color:steelblue"),
         
         h4(span(textOutput("Mod1_Pred")),style="color:blue"),
      
        
          h4("As per Model2(Generalised Linear Model) Your Chick's weight in grams will be",style="color:steelblue"), 
          
          h4(span(textOutput("Mod2_Pred")),style="color:blue")
       
       
       #h5(span(checkboxInput("showModel1","Show/Hide Model1 prediction",value = TRUE)),style="color:steelblue"),
       
       #h5(span(checkboxInput("showModel2","Show/Hide Model2 prediction",value = TRUE)),style="color:steelblue")
       
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(

      tabsetPanel(type="tabs",

             ##steelblue 
             ##dodgerblue
             
             tabPanel("Predicting Chicken Weight",br(),plotOutput("GrowthCurve"),h6(dataTableOutput('QuestionChick'))),
             
             
                  tabPanel("Project Introduction",br(),
            h5("This project is based out of the Dataset, 'Chickweight',
              that comes with the R library 'Datasets' and is a default install with R.The dataset 
              describes the effect of weight on a chicken with four different types of diet.
              There are around 50 types of chicken in the Sample and they are randomly fed with the 
              different types of diets,for given number of weeks.",style="color:steelblue"),
                  
            h5("Here we,split this Dataset into 60% and 40 % for Training and Testing respectively and name these datsets as 
               'training60' and 'testing40'.The Box plots of these Datasets are drawn in the Tabs Data Partitioning.This shows the
               similarity in nature of the training and testing datasets,which is essential to fit a good model
               for the datasets.",style="color:steelblue"),
            
           h5("We do the fitting with two Machine learning Algorithms,
               Random Forest and GLM(Generalised Linear Model)",style="color:steelblue"),
          h5("Sample Data and the partitioning of the data has been shown in the respective above Tabs",style="color:steelblue") ,
          h5("The accuracy of prediction by the models has been shown with the box plots and also the line plots of actual data from sample dataset
             and the predicted data by each model.",style="color:steelblue"),
          h5("Model1,Random Forest and Model2 Generalised Linear Model,are used for prediction",style="color:steelblue"),
          h6("Note:All the Server.R and UI.R files for this website along with the documentation .Readme,and
             also Pitch presentation,.RPres files,are present at the github link below",style="color:red"), 
          
          h5(span(uiOutput("tab")),style="color:red"),
          h3("Prediction:",style="color:steelblue"),

          h5("Input-Type of chicken from Slider Input at the left",style="color:steelblue"),
          h5("Input-DietType of chicken from Text Box Input at the left",style="color:steelblue"),
          h5("Input-Number of weeks to feed the chicken from Text Slider Input at the left",style="color:steelblue"),
          h4("'Predicting Chicken Weight Tab above',shows the reactively predicted dynamic values of Chicken Growth after the specified
             number of weeks",style="color:steelblue"),
          h5("Red dot shows the Chicken growth predicted by Random Forest Model and Blue dot shows the growth 
             predicted by GLM",style="color:steelblue")
           
          
          
          ),            
                  
                      #tabPanel("Predicting Chicken Weight",br(),plotOutput("GrowthCurve"),h6(dataTableOutput('QuestionChick'))),
          
                  
                        tabPanel("Sample Data",br(),dataTableOutput('Datatable'),h5("ChickenWeight Dataset from R Dataset Package,where Weight of chicken(grams),Time is the number of weeks the Chicken is Fed,Chicken type is a special numeric 
                                                                                    identifier,1..50,and diet type is 1..4,both categorical variables.",style="color:steelblue")),
                        
                  
                        tabPanel("Sample Data Partitions",br(),plotOutput("ChickenSampleDataPlot"),h5("ChickenWeight Dataset has been split into 75% Dataset for 
                                                                                                      training the models",br(),"and 25% for testing the models",style="color:steelblue")),
                        
                  
                        tabPanel("Exploratory Data Analysis",br(),plotOutput("ChickenExplorePlot"),h5("The two exploratory graps are drawn to see the nature of the diet effect on chickens",style="color:steelblue")),
                  
          
                        
                        tabPanel("Model1_Accuracy_BoxPlot",br(),plotOutput("Mod1PredictionTruth1"),h5("The Boxplots of the Predicted weights and actual weights in dataset are shown for random forest model",style="color:steelblue")),
                 
                        
                        tabPanel("Model1_Accuracy_Graph",br(),plotOutput("Mod1Prediction2Truth2"),h5("The Line Plots of the actual weights  at every row of training40 dataset and the corresponding predicted weight are shown for random forest model",style="color:steelblue")),
                  
                  
                        tabPanel("Model2_Accuracy_BoxPlot",br(),plotOutput("Mod2PredictionTruth1"),h5("The Boxplots of the Predicted weights and actual weights in dataset are shown for General Linear model",style="color:steelblue")),
                  
                  
                        tabPanel("Model2_Accuracy_Graph",br(),plotOutput("Mod2PredictionTruth2"),h5("The Line Plots of the actual weights  at every row of training40 dataset and the corresponding predicted weight are shown for General Linear model",style="color:steelblue"))
          
                  
                   )
            )
      )
  )
  
)
