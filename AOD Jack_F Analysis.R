#by Jack Foster
# Load and Sort Data ------------------------------------------------------

setwd("\\\\forestry.gov.uk/dfsroot/srsfldredir/jack.forster/Documents/HomeDrive/009b16/Raw Data/Analysis Mar 2017")
AOD<-read.table(file="clipboard",sep="\t",header=TRUE)
str(AOD)
AOD[,c(44:48)]<-apply(AOD[, c(14,17,20,23,26)], 2, function(x) ifelse(x > 0, 1, x))
names(AOD)[44:48]<-c("Bg.Pos.Bin","Gq.Pos.Bin","Rv.Pos.Bin","Lqb.Pos.Bin","Eb.Pos.Bin")
AOD[,c(30:38)]<-lapply(AOD[,c(30:38)],factor)
str(AOD)
AOD.bark<-subset(AOD,Position.1=="bark")
str(AOD.bark)
write.csv(file="AOD bark.csv",AOD.bark)
AOD.bark.NonContam<-subset(AOD.bark,Contaminated.=="N")
str(AOD.bark.NonContam)
write.csv(file="AOD.bark.NonContam.csv",AOD.bark.NonContam)
AOD.bark.NonContam.Kochs<-subset(AOD.bark.NonContam,Kochs=="Y")
str(AOD.bark.NonContam.Kochs)
write.csv(file="AOD.bark.NonContam.Kochs.csv",AOD.bark.NonContam.Kochs)
AOD.bark.NonContam.Kochs.agrl<-subset(AOD.bark.NonContam.Kochs,Galleries=="Y"|Galleries=="Agrilus Absent")
str(AOD.bark.NonContam.Kochs.agrl)
write.csv(file="AOD.bark.NonContam.Kochs.agrl.csv",AOD.bark.NonContam.Kochs.agrl)
# Back isolation success ------------------------------------------------------

#proportion back-isolation success
#model1<-glm(Kochs01~Treatment.All,binomial,data=AOD.bark) 
#model1<-glmer(Kochs01~Treatment.All+(1|Year),binomial,data=AOD.bark,control=glmerControl(optimizer = "bobyqa")) 
#library(multcompView)
#library(lsmeans)
#lsm<-lsmeans(model1,"Treatment.All",type="response")
#lsm
library(lmerTest)
library(car)
library(multcompView)
library(lsmeans)
modelBg<-glmer(Bg.Pos.Bin~Treatment.Bg+(1|Year/Tree/Log),binomial,data=AOD.bark,control=glmerControl(optimizer = "bobyqa")) 
summary(modelBg)
Anova(modelBg)
lsm<-lsmeans(modelBg,pairwise~Treatment.Bg)
lsm$contrasts
cld(lsm,alpha=0.05,Letters=letters,type="response")

modelGq<-glmer(Gq.Pos.Bin~Treatment.Gq+(1|Year/Tree/Log),binomial,data=AOD.bark,control=glmerControl(optimizer = "bobyqa")) 
summary(modelGq)
Anova(modelGq)
lsm<-lsmeans(modelGq,pairwise~Treatment.Gq)
lsm$contrasts
cld(lsm,alpha=0.05,Letters=letters,type="response")

modelRv<-glmer(Rv.Pos.Bin~Treatment.R.var+Treatment.R.vic+(1|Year/Tree/Log),binomial,data=AOD.bark,control=glmerControl(optimizer = "bobyqa")) 
summary(modelRv)
Anova(modelRv)
lsm<-lsmeans(modelRv,pairwise~Treatment.R.var+Treatment.R.vic,at=list(Treatment.R.vic="0"))
lsm$contrasts
cld(lsm,alpha=0.05,Letters=letters,type="response")
lsm<-lsmeans(modelRv,pairwise~Treatment.R.var+Treatment.R.vic,at=list(Treatment.R.var="0"))
lsm$contrasts
cld(lsm,alpha=0.05,Letters=letters,type="response")

modelEb<-glmer(Eb.Pos.Bin~Treatment.Eb+(1|Tree/Log),binomial,data=AOD.bark,control=glmerControl(optimizer = "bobyqa")) 
summary(modelEb)
Anova(modelEb)
lsm<-lsmeans(modelEb,pairwise~Treatment.Eb)
lsm$contrasts
cld(lsm,alpha=0.05,Letters=letters,type="response")

modelLqb<-glmer(Lqb.Pos.Bin~Treatment.Lqb+(1|Year/Tree/Log),binomial,data=AOD.bark,control=glmerControl(optimizer = "bobyqa")) 
summary(modelLqb)
Anova(modelLqb)
lsm<-lsmeans(modelLqb,pairwise~Treatment.Lqb)
lsm$contrasts
cld(lsm,alpha=0.05,Letters=letters,type="response")
binom.test(0,79,conf.level=(1-0.05/2))

# Contamination ------------------------------------------------------

#proportion contaminated
#model1<-glm(Contaminated01~Treatment.All,binomial,data=AOD.bark) 
#model1<-glmer(Contaminated01~Treatment.All+(1|Year),binomial,data=AOD.bark,control=glmerControl(optimizer = "bobyqa")) 
#library(multcompView)
#library(lsmeans)
#lsm<-lsmeans(model1,"Treatment.All",type="response")
#cld(lsm,alpha=0.05,Letters=letters,type="response")

modelEggLar<-glmer(Contaminated01~Treatment.Egg+Treatment.Larvae+(1|Year/Tree/Log),binomial,data=AOD.bark,control=glmerControl(optimizer = "bobyqa")) 
summary(modelEggLar)
Anova(modelEggLar)
lsm<-lsmeans(modelEggLar,pairwise~Treatment.Egg+Treatment.Larvae,at=list(Treatment.Larvae="0"))
lsm$contrasts
cld(lsm,alpha=0.05,Letters=letters,type="response")
lsm<-lsmeans(modelEggLar,pairwise~Treatment.Egg+Treatment.Larvae,at=list(Treatment.Egg="0"))
lsm$contrasts
cld(lsm,alpha=0.05,Letters=letters,type="response")

AOD.bark.Bg<-subset(AOD.bark,Treatment.Bg=="0")
modelEggLar<-glmer(Bg.Pos.Bin~Treatment.Egg+Treatment.Larvae+(1|Year/Tree/Log),binomial,data=AOD.bark.Bg,control=glmerControl(optimizer = "bobyqa")) 
summary(modelEggLar)
Anova(modelEggLar)
lsm<-lsmeans(modelEggLar,pairwise~Treatment.Egg+Treatment.Larvae,at=list(Treatment.Larvae="0"))
lsm$contrasts
cld(lsm,alpha=0.05,Letters=letters,type="response")
lsm<-lsmeans(modelEggLar,pairwise~Treatment.Egg+Treatment.Larvae,at=list(Treatment.Egg="0"))
lsm$contrasts
cld(lsm,alpha=0.05,Letters=letters,type="response")



AOD.bark.Gq<-subset(AOD.bark,Treatment.Gq=="0")
modelEggLar<-glmer(Gq.Pos.Bin~Treatment.Egg+Treatment.Larvae+(1|Year/Tree/Log),binomial,data=AOD.bark.Gq,control=glmerControl(optimizer = "bobyqa")) 
summary(modelEggLar)
Anova(modelEggLar)
lsm<-lsmeans(modelEggLar,pairwise~Treatment.Egg+Treatment.Larvae,at=list(Treatment.Larvae="0"))
lsm$contrasts
cld(lsm,alpha=0.05,Letters=letters,type="response")
lsm<-lsmeans(modelEggLar,pairwise~Treatment.Egg+Treatment.Larvae,at=list(Treatment.Egg="0"))
lsm$contrasts
cld(lsm,alpha=0.05,Letters=letters,type="response")

#note change in error structure
AOD.bark.Rv<-subset(AOD.bark,(Treatment.R.var=="0"|Treatment.R.vic=="0"))
modelEggLar<-glmer(Rv.Pos.Bin~Treatment.Egg+(1|Year/Tree),binomial,data=AOD.bark.Rv,control=glmerControl(optimizer = "bobyqa")) 
summary(modelEggLar)
Anova(modelEggLar)
lsm<-lsmeans(modelEggLar,pairwise~Treatment.Egg)
lsm$contrasts
cld(lsm,alpha=0.05,Letters=letters,type="response")

#Eb and Lqb, insufficient data/responses all negative


# Analysis by refinement ------------------------------------------------------

#non contam + kochs + galleries
model1<-lmer((125/(Area..mm2.+125))~Treatment.All+(1|Year/Tree/Log),data=AOD.bark.NonContam.Kochs.agrl) #inverse transformation plus constant to normalise data
shapiro.test(residuals(model1))

layout(matrix(c(1,2,3,4),2,2)) 
hist(residuals(model1),col="green",main="Histogram of residuals",xlab="",ylab="Frequency")
qqnorm(residuals(model1))
abline(h=0,v=0,col="red")
plot(residuals(model1), main="Residual plot",ylab="Residuals")
abline(h=0,col="red")
library(faraway)
halfnorm(residuals(model1),main="Half-normal Q-Q plot")

summary(model1)
anova(model1)
library(multcompView)
library(lsmeans)
lsm<-lsmeans(model1,pairwise~Treatment.All,adjust="bonf")
contr.lsm <- contrast(lsm, "trt.vs.ctrl", ref = c(7))
contr.lsm
lsm$lsmeans


#non contam + kochs
model1<-lmer((125/(Area..mm2.+125))~Treatment.All+(1|Year/Tree/Log),data=AOD.bark.NonContam.Kochs) #inverse transformation plus constant to normalise data
shapiro.test(residuals(model1))

layout(matrix(c(1,2,3,4),2,2)) 
hist(residuals(model1),col="green",main="Histogram of residuals",xlab="",ylab="Frequency")
qqnorm(residuals(model1))
abline(h=0,v=0,col="red")
plot(residuals(model1), main="Residual plot",ylab="Residuals")
abline(h=0,col="red")
library(faraway)
halfnorm(residuals(model1),main="Half-normal Q-Q plot")

summary(model1)
library(multcompView)
library(lsmeans)
lsm<-lsmeans(model1,pairwise~Treatment.All,adjust="bonf")
contr.lsm <- contrast(lsm, "trt.vs.ctrl", ref = c(7))
contr.lsm
lsm$lsmeans


#non contam
model1<-lmer((135/(Area..mm2.+135))~Treatment.All+(1|Year/Tree/Log),data=AOD.bark.NonContam) #inverse transformation plus constant to normalise data
shapiro.test(residuals(model1))

layout(matrix(c(1,2,3,4),2,2)) 
hist(residuals(model1),col="green",main="Histogram of residuals",xlab="",ylab="Frequency")
qqnorm(residuals(model1))
abline(h=0,v=0,col="red")
plot(residuals(model1), main="Residual plot",ylab="Residuals")
abline(h=0,col="red")
library(faraway)
halfnorm(residuals(model1),main="Half-normal Q-Q plot")

summary(model1)
library(multcompView)
library(lsmeans)
lsm<-lsmeans(model1,pairwise~Treatment.All,adjust="bonf")
contr.lsm <- contrast(lsm, "trt.vs.ctrl", ref = c(15))
contr.lsm
lsm$lsmeans


#all
model1<-lmer((142/(Area..mm2.+142))~Treatment.All+(1|Year/Tree/Log),data=AOD.bark) #inverse transformation plus constant to normalise data
shapiro.test(residuals(model1))

layout(matrix(c(1,2,3,4),2,2)) 
hist(residuals(model1),col="green",main="Histogram of residuals",xlab="",ylab="Frequency")
qqnorm(residuals(model1))
abline(h=0,v=0,col="red")
plot(residuals(model1), main="Residual plot",ylab="Residuals")
abline(h=0,col="red")
library(faraway)
halfnorm(residuals(model1),main="Half-normal Q-Q plot")

summary(model1)
library(multcompView)
library(lsmeans)
lsm<-lsmeans(model1,pairwise~Treatment.All,adjust="bonf")
contr.lsm <- contrast(lsm, "trt.vs.ctrl", ref = c(15))
contr.lsm
lsm$lsmeans

# Re-isloation analysis ------------------------------------------------------

#all but based on re-isolations
model1<-lmer((138/(Area..mm2.+138))~BackIsoDefTrt+(1|Year/Tree/Log),data=AOD.bark) #inverse transformation plus constant to normalise data
shapiro.test(residuals(model1))

layout(matrix(c(1,2,3,4),2,2)) 
hist(residuals(model1),col="green",main="Histogram of residuals",xlab="",ylab="Frequency")
qqnorm(residuals(model1))
abline(h=0,v=0,col="red")
plot(residuals(model1), main="Residual plot",ylab="Residuals")
abline(h=0,col="red")
library(faraway)
halfnorm(residuals(model1),main="Half-normal Q-Q plot")

summary(model1)
library(multcompView)
library(lsmeans)
lsm<-lsmeans(model1,pairwise~BackIsoDefTrt,adjust="bonf")
contr.lsm <- contrast(lsm, "trt.vs.ctrl", ref = c(26))
contr.lsm
lsm$lsmeans