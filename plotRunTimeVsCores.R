require(tidyverse)

pipeCmd='egrep "Run time :|Elapsed time|load" stats/test* | fgrep "Run t" | tr "[ _]" "," | perl -pe "s/,,*/,/g"'

metric=c("stats/test0"="CPU.Py.1","stats/test0b"="CPU.Py.5",
        "stats/test1"="PIC0.ValSam",
        "stats/test2"="PIC1.Down.33",
        "stats/test3"="PIC2.Sort",
        "stats/test4"="PIC3.MD")

xx=read_csv(pipe(pipeCmd),col_names=F) %>%
    mutate(Cores=as.numeric(X2),Time=as.numeric(X7)) %>%
    mutate(Metric=factor(metric[X1])) %>%
    group_by(Metric) %>%
    mutate(Norm.Time=Time/min(Time)) %>%
    ungroup

if(!interactive()) pdf(file="timePerNumCoresUsedV3.pdf",width=8.5,height=11)
par(mfrow=c(2,1))
xz=xx %>% filter(grepl("CPU",Metric)) %>% mutate(Metric=factor(Metric))
bb=boxplot(Time ~ Metric+Cores,dat=xz,las=2,cex.axis=.7,ylab="Run Time")
abline(v=max(grep(".20",bb$names))+.5,col=8,lty=2)

bb=boxplot(Norm.Time ~ Metric+Cores,dat=xz,las=2,cex.axis=.7,ylab="Normalized Time")
abline(v=max(grep(".20",bb$names))+.5,col=8,lty=2)
if(!interactive()) dev.off()

xy = xx %>% filter(Cores<=20)

if(!interactive()) pdf(file="timePerNumCoresUsedV3b.pdf",width=11,height=8.5)

nMetrics=xy %>% distinct(Metric) %>% pull %>% nlevels(.)
nCoreLevels=xy %>% distinct(Cores) %>% pull %>% len(.)
bb=boxplot(Norm.Time ~ Metric+Cores,dat=xy,las=2,cex.axis=.7,ylab="Normalized Time",
    col=RColorBrewer::brewer.pal(nMetrics,"Set1"))
abline(v=6*seq(nCoreLevels)+.5,col=8,lty=2,lwd=2)

if(!interactive()) dev.off()

