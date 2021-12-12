
library(dplyr)
library(magrittr)
library(purrr)
library(readr)
library(tidyr)
library(ggplot2)
library(broom)
library(tibble)


#Loading training data
train<-read_csv("https://raw.githubusercontent.com/RWorkshop/workshopdatasets/master/loanprediction/LoanPrediction.csv")


glimpse(train)

table(train$Loan_Status)

barplot(table(train$Loan_Status))

class(train$Gender)

barplot(table(train$Gender),main="train set")


table(train$Gender)

summary(train$Gender)

barplot(table(train$Married),main="train set")

levels(train$Dependents)
## [1] "0"  "1"  "2"  "3+"
barplot(table(train$Dependents),main="train set")

mean(complete.cases(train))

sum(complete.cases(train))

train %>% map(complete.cases)%>% map(sum)

train %>% map(complete.cases)%>% 
  map(sum) %>% 
  map(tidy) %>% 
  map_dbl("x") %>% 
  as.tibble() %>% 
  rownames_to_column("Variable")

table(train$Education)



barplot(table(train$Education),main="train set")

print(ggplot(train, aes(x=Loan_Status))+geom_bar()+facet_grid(.~Gender)+ggtitle("Loan Status by Gender of Applicant"))


print(ggplot(train, aes(x=Loan_Status))+geom_bar()+facet_grid(.~Married)+ggtitle("Loan Status by Marital Status of Applicant"))


#a larger proportion of not married applicants are refused than mmaried ones
print(ggplot(train, aes(x=Loan_Status))+geom_bar()+facet_grid(.~Dependents)
      +ggtitle("Loan Status by number of Dependents of Applicant"))




#a smaller proportion of applicants with 2 dependents is refused than other numbers
print(ggplot(train, aes(x=Loan_Status))+geom_bar()+facet_grid(.~Education)
      +ggtitle("Loan Status by Education of Applicant"))




#a larger proportion on non graduates are refused than graduates
print(ggplot(train, aes(x=Loan_Status))+geom_bar()+facet_grid(.~Self_Employed)+ggtitle("Loan Status by Employment status of Applicant"))


#difficult to see any patterns, most of the loans are for 360 months
print(ggplot(train, aes(x=Loan_Status))+geom_bar()+facet_grid(.~Credit_History)
      +ggtitle("Loan Status by credit history of Applicant"))


#this looks very important! Almost all applicants with history=0 are refused
print(ggplot(train, aes(x=Loan_Status))+geom_bar()+facet_grid(.~Property_Area)
      +ggtitle("Loan Status by property area"))



#it's easiest to get a loan if the property is semi urban and hardest if it is rural
print(ggplot(train, aes(x=Loan_Status,y=ApplicantIncome))+geom_boxplot()
      +ggtitle("Loan Status by Applicant income"))




#doesn't look like there's much difference
print(ggplot(train, aes(x=Loan_Status,y=CoapplicantIncome))+geom_boxplot()
      +ggtitle("Loan Status by coapplicant income"))




#this seems to make a difference
print(ggplot(train, aes(x=Loan_Status,y=LoanAmount))
      +geom_boxplot()+ggtitle("Loan Status by Loan Amount"))


#Applicants with higher than 20000 income have been truncated from the plot 
print(ggplot(data=train[train$ApplicantIncome<20000,],aes(ApplicantIncome,fill=Married))+geom_bar(position="dodge")+facet_grid(Gender~.))




print(ggplot(data=alldata[alldata$ApplicantIncome<20000,],aes(CoapplicantIncome,fill=Married))+geom_bar(position="dodge")+facet_grid(Gender~.))

