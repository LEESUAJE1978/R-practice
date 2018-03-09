#multiple regression
#stepwise method

car<-read.csv("autompg.csv")
head(car)
str(car)
attach(car)

#multiple regression :1st full model
r1<-lm(mpg~disp+hp+wt+accler, data = car)
summary(r1)
#mpg = 40.88 -0.011disp +0.0048hp- 0.0061wt +0.17accler
#R squre = 0.7006

#explanator data analysis
#pairwise plot
var1<-c("mpg","disp", "hp","wt","accler")
pairs(car[var1], main ="Autompg", cex=1, col=as.integer(car$cyl))


#배기량(disp)과 연비(mpg)의 관계? 배기량과 연비는 음의 상관관계를 가진 것으로 나타남
#마력(hp)와 연비(mpg)의 관계? 마력과 연비는 양의 상관 관계를 가진 것으로 나타남, 마력이 좋을 수록 연비가 좋다는 것에 대한 검증 필요
#차량무게(wt)와 연비(mpg)와의 관계? 차량 무게와 연비는 음의 상관관계를 가진 것으로 나타남

#ref. POSTECH MOOC R 고급과정 이혜선 교수

#변수 선택 방법
#1. 전진선택법(forward selection): 독립 변수 중에서 종속변수에 가장 큰 영향을 주는 변수 부터 모형에 포함
#2. 후진제거법(backward elimination): 독립 변수를 모두 포함한 모형에서 가장 영향이 적은(중요하지 않은) 변수부터 제거
#3. 단계별 방법(stepwise method): 전진선택법에 의해 변수 추가, 변수 추가시 기존 변수의 중요도가 정해진 유의수준에 포함되지 
#않으면 앞에서 들어간 변수도 다시 제거됨
#step(모형, direction ="both")
step(r1, direction = "forward")
step(r1, direction = "backward")
step(r1, direction ="both")
#다른 통계 프로그램에서는 R2가 가장 높은 조합의 변수 그룹을 선택, R에서는 가장 낮은 조합의 변수 그룹 선택

r2<-lm(mpg ~ disp+wt+accler, data=car)
summary(r2)
#mpg = 41.30 -0.011disp - 0.0062wt+0.17accler, R2(결정계수)= 0.7004
#residual diagnostic plot
layout(matrix(c(1,2,3,4),2,2)) #optional 4 graphs / page
plot(r2)

#다중 공선성(multicollinearity)
#독립변수들 사이에 상관관계가 있는 현상
#다중공선성이 존재하는 경우 회귀계수 해석 불가능

#check correlation between independent variables
var2<-c("disp", "hp", "wt", "accler")
cor(car[var2])

#get correlation for each pair
cor(disp, wt)
cor(disp, accler)
cor(wt, accler)

#분산팽창계수(VIF: Variance Inflation Factor)- 다중공선성의 척도
#VIF는 다중 공산성으로 인한 분산의 증가를 의미
#다중공선성이 의심되면 ridge regression 또는 주성분 회귀(principle components regression) 적용
install.packages("car")
library(car)
vif(lm(mpg~disp+hp+wt+accler, data = car))
#check point1: coefficients &R2
#check point2: multi-collinearity
#check point3: residual plot
#check point4: outlier or other suspicious trend