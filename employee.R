library(readxl)
library(doBy)
#tip
# 구문 실행: CLT+ENTER
# 콘솔 정리: CLT+L
# 개별 객체 삭제: rm(dept)
# 전체 객체 삭제: rm(list=ls())

#1.데이터 불러오기: 엑셀 시트별로 불러오기
emp<-read_excel("employee.xlsx", sheet = "emp")
dept<-read_excel("employee.xlsx", sheet = "dept")
salgrade<-read_excel("employee.xlsx", sheet ="salgrade")


#2.emp에서사원번호가 7521인 사원과 직업이 같고 사원번호가 7934인 사원의 급여보다 많은 사원의 사원번호, 이름, 직업, 급여를 확인
subset(emp, JOB==subset(emp, EMPNO==7521)$JOB & SAL > subset(emp, EMPNO==7934)$SAL)
subset(emp, JOB==subset(emp, EMPNO==7521))

#3. 전체 직원 중 입사일(HIREDATE)가 겹치는 직원들이 있는지 정렬을 사용해 확인해 본다
subset(emp,duplicated(emp$HIREDATE))

#4사장보다 먼저 입사한 직원들의 근무지역은 어디인지 확인해 본다.
#4.1
emp_early<-subset(emp, HIREDATE< subset(emp, JOB=='PRESIDENT')$HIREDATE)
merge(emp_early,dept, all.x = T, by="DEPTNO")

#4.2
merge(subset(emp,HIREDATE<subset(emp,JOB=='PRESIDENT')$HIREDATE),dept,all.x=T,by="DEPTNO")

#5.직종이 "CLERK"인 직원들의 평균연봉보다 높은 직원들의 부서 이름(DNAME)은 무엇인지 확인해 본다
#5.1
cleak_sal<-subset(emp, SAL>mean(subset(emp, JOB == 'CLERK')$SAL))
table(merge(subset(emp, SAL>mean(subset(emp, JOB == 'CLERK')$SAL)), dept, all.x = T, by="DEPTNO")$LOC)
#5.2
clerk_sal1<-mean(subset(emp,JOB=='CLERK')$SAL)
emp_loc<-merge(emp,dept,all.x=T,by="DEPTNO")
subset(emp_loc,SAL>clerk_sal1)


#6. 각부서별 평균 급여가 2000이상이면 "ABOVE" 그렇기 않으면 "BELOW"값을 가지는 SAL_MEASURE 변수를 추가해 본다
aggregate(SAL ~ DEPTNO, Employee, mean)
DEPT_sal<-aggregate(SAL ~ DEPTNO, Employee, mean)
names(DEPT_sal)[2]<-"SAL_AVG"
DEPT_sal
emp_sal<-merge(emp, DEPT_sal, all.x = T, by="DEPTNO")
emp_sal$MEASURE<-ifelse(emp_sal$SAL_AVG>2000, 'ABOVE', 'BELOW')
emp_sal


#7. 직종별(JOB) 인원수, 평균 급여액, 최고 급여액, 및 합계를 모두 확인해 본다
require(doBy)
summaryBy(SAL~JOB, emp, FUN = c(min,max, length, mean))
aggregate(SAL ~ JOB, emp, mean) 

#8. 가장 많은 사원이 속해 있는 부서 번호와 사원수 확인
table(emp$DEPTNO)

#9. 직종별 인원, 부서별 인원을 계산해 기존 EMP 테이블에 병합
#9.1
JOB_CNT<-summaryBy(SAL~JOB, emp, FUN = length)
DEPT_CNT<-summaryBy(SAL~DEPTNO, emp, FUN =length)
merge(merge(emp,JOB_CNT,all.x=T,by="JOB"),DEPT_CNT,all.x=T,by="DEPTNO")
merge(merge(emp, subset(summaryBy(SAL~JOB, emp, FUN = length)), all.x = T, by="JOB"),
      summaryBy(SAL~DEPTNO, emp, FUN =length), all.x = T, by="DEPTNO")

#9.2
a<-as.data.frame(table(emp$JOB))
colnames(a)<-c("JOB","Freq")
merge(merge(emp,a, all.x=T, by="JOB"),b, all.x = T, by="DEPTNO")

b<-as.data.frame(table(emp$DEPTNO))
colnames(b)<-c("DEPTNO","Freq")
merge(emp,b, all.x=T, by="DEPTNO")

#10.emp 에 salgrade를 병합해 모든 직원에게 연봉에 따른 grade 정보 부여
str(emp)
str(salgrade)
emp_sal<-merge(emp, salgrade, all = T)
a<-subset(emp_sal, SAL >LOSAL)
b<-subset(a,SAL<HISAL)
b

