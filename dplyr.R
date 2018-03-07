library(nycflights13)
library(tidyverse)

str(flights)
#int stands for integers.
#dbl stands for doubles, or real numbers.
#chr stands for character vectors, or strings.
#dttm stands for date-times(a date + a time)
#lgl stands for logical, vectors, that contain only TRUE or FALSE.
#fctr stands for factors, which R uses t represent categorical variables with fixed possible values. 
#date stands for dates(

#dplyr basic
#filter pick observation by their values(filter())
#reorder the rows(arrange))
#pick variables by their names(n)
#create new variables with functions of existing variables(mutate)
#collapse many values down to a single summay(summarize()).

#1.filter rows with filter() 1월 1일 비행 스케줄 정리
filter(flights, month ==1, day ==1)

#Tip.데이터 출력과 변수 지정을 동시에 하고 싶으면 괄호를 묶어 준다.
(dec25<- filter(flights, month== 12, day == 25))

#2. 데이터 비교하기 
#r에서는 ==를 사용하여 양변이 같다는 것을 표현한다. 만약 '='를 사용하면 오류가 발생한다. 
filter(flights, month =1)

#무한 소수점이 필요한 계산의 경우 "=="를 사용하면 'false'값을 반환한다. 이 때는 near를 사용한다
sqrt(2)^2 == 2
1/49*49 == 1
near(sqrt(2)^2,2)
near(1/49*49,1)

#logical operators - Boolean operation & is "and", | is "or", ! is"not"
#syntax를 'month == 11|12'로 하면 1월 달의 값이 출력된다. 
filter(flights,month == 11 | month ==12)
(nov_dec<-filter(flights, month %in% c(11,12)))
filter(flights, month == 11 | 12)

#De Morgan's law: !(x & y) == !x | !y, !(x | y) == !x | !y
#출발과 도착 지연이 두시간 이내인 비행기 선택하는 방법
filter(flights, !(arr_delay >120) | dep_delay>120)
filter(flights, arr_delay <= 120, dep_delay<=120)

#데이터에 'NA'값이 존재할 때 filter 함수는 기본적으로 'NA'값을 출력하지 않는다. 'NA'값을 출력하고 싶으면 is.na(x)를 적용한다
df<-tibble(x = c(1, NA, 3))
filter(df, x>1)
filter(df, is.na(x) | x>1)

#두시간 이상 도착 지연된 비행기 
filter(flights, arr_delay >= 2)

#휴스톤행 비행기 
unique(flights$dest)
filter(flights, dest == "HOU" )

#United American, Delta 비행기 추출
unique(flights$carrier)
filter(flights, carrier =="UA" | carrier =="DL")
filter(flights, carrier %in% c("UA", "DL"))

# 7,8,9월 출발 비행기 추출
filter(flights, month %in% c("7","8","9"))
filter(flights, month == "7" | month =="8" | month =="9")

#두시간 이상 지연 도착 한 비행기 중 정시 출발 한 비행기
filter(flights, arr_delay >= 2 & dep_delay == 0)

#밤 12시에서 아침 6시 사이 출발한 비행기
filter(flights, dep_time<= 600)
filter(flights,between(dep_time, 0, 600))

nrow(flights)
filter(flights, dep_delay == 0)
filter(flights, dep_delay >0)
nrow(flights)
filter(flights, is.na(dep_time))
