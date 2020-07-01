#### ANOVA example

# Dr. Heike Zimmermann

dat<-read.table("yields.txt",header=T)
str(dat)
dat
summary(dat)
attach(dat)
boxplot(yield ~ soil,ylab="yield [mg]")
####plots to explain SSY (total sum of squares) AND SSE (error sum of squares), when SSE is zero
#SSA (treatment sum of squares OR explained variation) SSA=SSY-SSE
plot(yield)

par(mfrow=c(1,1))
plot(yield,pch="")
points(yield[soil=="sand"],pch=15)
points(11:20,yield[soil=="clay"],pch=3)
points(21:30,yield[soil=="loam"],pch=24)
abline(h=mean(yield),col="red")
for(i in 1:nrow(dat))lines(c(i,i),c(yield[i],mean(yield)))
text(7,18,"Total Variation (SSY)")


plot(yield,pch="")
points(yield[soil=="sand"],pch=15)
points(11:20,yield[soil=="clay"],pch=3)
points(21:30,yield[soil=="loam"],pch=24)
SANDmean<-mean(yield[soil=="sand"])
lines(c(0,10),c(SANDmean,SANDmean))
CLAYmean<-mean(yield[soil=="clay"])
lines(c(11,20),c(CLAYmean,CLAYmean))
LOAMmean<-mean(yield[soil=="loam"])
lines(c(21,30),c(LOAMmean,LOAMmean))
for(i in 1:10)lines(c(i,i),c(yield[i],mean(yield[soil=="sand"])))
for(i in 11:20)lines(c(i,i),c(yield[i],mean(yield[soil=="clay"])))
for(i in 21:30)lines(c(i,i),c(yield[i],mean(yield[soil=="loam"])))
text(8,18,"(Within Group Variation) SSE")

####plots to explain SSY (total sum of squares) AND SSE (error sum of squares), when SSE is zero
#SSA (treatment sum of squares OR explained variation) SSA=SSY-SSE
xvc<-1:15
yvs<-rep(c(10,12,14),each=5)
par(mfrow=c(1,2))
plot(xvc,yvs,ylim=c(5,16),pch=(15+(xvc>5)+(xvc>10)))
for(i in 1:15)lines(c(i,i),c(yvs[i],mean(yvs)))
abline(h=mean(yvs),col="red")
text(3,15,"SSY")
plot(xvc,yvs,ylim=c(5,16),pch=(15+(xvc>5)+(xvc>10)))
lines(c(1,5),c(10,10),col="red")
lines(c(6,10),c(12,12),col="red")
lines(c(11,15),c(14,14),col="red")
text(3,15,"SSE")
