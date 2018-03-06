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

