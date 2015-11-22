library(tm)
library(wordcloud)

t <- Corpus(VectorSource(RMods))
t <- tm_map(t,removeNumbers)
mystops <- c(stopwords('english'),"and")
t <- tm_map(t,removeWords,mystops,mc.cores=1)
t <- tm_map(t,removeWords,c("And","but"),lazy=T)
t <- tm_map(t,removePunctuation)
tD <- t
tR <- t
writeCorpus(t,filenames = "RepubMods.txt")

##Create a cluster diagram 
Rtdm <- TermDocumentMatrix(tR,control=list(wordLengths=c(1,Inf)))
dimnames(Rtdm)$Terms
Rtdm2 <- removeSparseTerms(Rtdm,sparse=0.95)
Rtdm.matrix <- as.matrix(Rtdm2)
RdistMat <- dist(scale(Rtdm2))
Rtdmfit <- hclust(RdistMat,method="ward.D")
plot(Rtdmfit,cex=0.9,hang=0,main="Republican Debate Word Cluster")
#This is really crowded, so I want to cut it at h=25, then plot those seperately. 
#This should give me four groups
Rcut <- cut(as.dendrogram(Rtdmfit),h=25)
plot(Rcut$lower[[1]])
plot(Rcut$lower[[2]])
plot(Rcut$lower[[3]])
plot(Rcut$lower[[4]])
plot(Rcut$lower[[5]])
plot(Rcut$lower[[6]])
plot(Rcut$lower[[7]])
plot(Rcut$lower[[8]])
plot(Rcut$lower[[9]])
dev.off()

Dtdm <- TermDocumentMatrix(tD,control=list(wordLengths=c(1,Inf)))
dimnames(Dtdm)$Terms
Dtdm2 <- removeSparseTerms(Dtdm,sparse=0.55)
Dtdm.matrix <- as.matrix(Dtdm2)
DdistMat <- dist(scale(Dtdm2))
Dtdmfit <- hclust(DdistMat,method="ward.D")
plot(Dtdmfit,cex=0.9,hang=0,main="Democratic Debate Word Cluster")
Dcut <- cut(as.dendrogram(Dtdmfit),h=50)
plot(Dcut$lower[[1]])
plot(Dcut$lower[[2]])
plot(Dcut$lower[[3]])
plot(Dcut$lower[[4]])

library(wordcloud)
