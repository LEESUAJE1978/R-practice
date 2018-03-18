#library 설치
library(pastecs)
library(dplyr)
library(data.table)
library(doBy)
#파일 불러오기
salary<-data.frame(read.csv("Salaries.csv"))

options(digits = 1, scipen = 10) #표시되는 데이터이 소수점 설정

#1.데이터 탐색
str(salary)
summary(salary)
stat.desc(salary)
View(salary)
dim(salary)

#2.직업 종류는 몇 가지인지 고유한 수준에서  확인
length(unique(salary$JobTitle)) #2159

#3.직원명과 년도 변수를 통해 데이터 구조 확인 후 가장 흔한 직업 5개가 무엇인지 파악
head(arrange(summaryBy(Id~JobTitle, data=salary, FUN=sum), desc(Id.sum)),5)

#4. Kenneth Mackey와 Mark W Mcclure 직원 정보
salary[salary$EmployeeName =="Kenneth Mackey" | salary$EmployeeName == "Mark W Mcclure",]
subset(salary, salary$EmployeeName =="Kenneth Mackey" | salary$EmployeeName == "Mark W Mcclure")
subset(salary, EmployeeName %in% c("Kenneth Mackey", "Mark W Mcclure"))

#5.직업명(jobtile)에 "Chief"가 포함되어 있는 직원수는 총 몇명인지 확인해 본다.  
salary$JobTitle %like% "Chief"
length(salary[salary$JobTitle %like% "Chief",]$JobTitle)
dim(salary[salary$JobTitle %like% "Chief",])
length(subset(salary, JobTitle %like% 'Chief')$JobTitle)

#6. salary 데이터를 TotalPay, Benefits, OtherPay로만 제한한 후 세 금액의 평균을 변수로 생성
names(salary)
salary_sub<-select(salary, c("Id","TotalPay","Benefits","OtherPay"))
salary_sub<-salary[,c("Id","TotalPay","Benefits","OtherPay")]
head(salary_sub)
salary_sub$mean<-(salary_sub$TotalPay+salary_sub$Benefits+salary_sub$OtherPay)/3
salary_sub$mean1<-rowMeans(salary_sub[,2:4])
salary_sub$mean2<-apply(salary_sub[,2:4],1, mean, na.rm =T)#N/A 값은 0으로 간주하고 평균 구함
salary_sub$mean3<-apply(salary_sub[,2:4],1, mean)# 기본은 N/A 값 적용
head(salary_sub)

#7. 6에서 계산한 금액이 년도별로 어떤 변화를 보이는지 확인
salary_sub_final<- merge(salary_sub, salary[,c("Id","Year")], all.x = T, by="Id")
str(salary_sub_final)#Year 데이터형식이 int 여서 chr로 변환
salary_sub_final$Year<-as.character(salary_sub_final$Year)
summaryBy(mean2~Year, data = salary_sub_final, FUN = c(mean, length))

#8. 6 의 결과를 시각화 해 본다
boxplot(mean2~Year, data =salary_sub_final)
