# CourseraDataProducts-Week4-Assignment



## Project Introduction

This project is based out of the Dataset, 'Chickweight',that comes with the R library 'Datasets' and is a default install with R.The dataset describes the effect of weight on a chicken with four different types of diet.

There are around 50 types of chicken in the Sample and they are randomly fed with the different types of diets,for given number of weeks.
                  
## Model Fitting
Here we,split this Dataset into 60% and 40 % for Training and Testing respectively and name these datsets as 'training60' and 'testing40'.The Box plots of these Datasets are drawn in the Tabs Data Partitioning.This shows the similarity in nature of the training and testing datasets,which is essential to fit a good model for the datasets.
            
We do the fitting with two Machine learning Algorithms,Random Forest and GLM(Generalised Linear Model).Sample Data and the partitioning of the data has been shown in the respective above Tabs.The accuracy of prediction by the models has been shown with the box plots and also the line plots of actual data from sample dataset and the predicted data by each model.

Model1,Random Forest and Model2 Generalised Linear Model,are used for prediction
### Inputs to the Model
        Input-Type of chicken from Slider Input 
        Input-DietType of chicken from Text Box Input 
        Input-Number of weeks to feed the chicken from Slider Input

### Predicted output
        Weight of the Chicken chosen with the specified dite

### Predicting Chicken Weight Tab 
shows the reactively predicted dynamic values of Chicken Growth after the specified number of weeks.Red dot shows the Chicken growth predicted by Random Forest Model and Blue dot shows the growth predicted by GLM".
