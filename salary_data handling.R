#library 설치
library(pastecs)
library(dplyr)
library(data.table)

#파일 불러오기
salary<-data.frame(read.csv("Salaries.csv"))

options(digits = 1, scipen = 10)

#데이터 탐색
str(salary)
summary(salary)
stat.desc(salary)
View(salary)
dim(salary)

#2.직업 종류 확인
length(unique(salary$JobTitle)) #2159

#3.직원명과 년도 변수를 통해 가장 흔한 직업
summaryBy(JobTitle~Id, data=salary, FUN=sum)
salary<-data.frame(table(salary$JobTitle))
arrange(a, desc(Freq))
salary_ordered<-salary[order(salary$EmployeeName),]
View(salary_ordered)

#4. Kenneth Mackey와 Mark W Mcclure 직원 정보
salary[salary$EmployeeName =="Kenneth Mackey" | salary$EmployeeName == "Mark W Mcclure",]
subset(salary, salary$EmployeeName =="Kenneth Mackey" | salary$EmployeeName == "Mark W Mcclure")
subset(salary, EmployeeName %in% c("Kenneth Mackey", "Mark W Mcclure"))

#5. 
class(salary)
salary$JobTitle %like% "Chief"
salary[salary$JobTitle %like% "Chief",]
dim(salary[salary$JobTitle %like% "Chief",])
subset(salary, JobTitle %lke% "chief")

names(salary)

names(salary$JobTitle)

sel
dim(salary)

#TotalPay, Benefits, OtherPay
library(doBy)
str(salary)
mean(salary$TotalPay,salary$Benefits, na.rm = TRUE)/2
a<-salary[,c(6:8)]
b<-(a$OtherPay+a$TotalPay+a$Benefits)/3
colMeans(a,na.rm = T)
rowMeans(a,na.rm = T)
apply(a, 1, mean, na.rm=T)
apply(a, 1, mean, na.rm=T)
apply(a, 2, mean, na.rm=T)
(salary$OtherPay+salary$Benefits+salary$TotalPay)/3
rowSums(salary[,c(6:8)], na.rm = T)
rowMeans(salary[,c(6:8)], na.rm=T)

#7
summaryBy(TotalPay+OtherPay~Year+JobTitle, data = salary, FUN=c(mean, length))

str(salary)
