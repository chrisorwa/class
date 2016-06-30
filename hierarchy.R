#load required libraries
library(fpc)
library(stringdist)


#load data
df = read.csv('mandera_annotated.csv - mandera_annotated.csv.csv')[c(1:50),]
df_1 = as.data.frame(unique(df$text))
colnames(df_1) <- c('text')

#measure distance
m <- matrix(data = 0,nrow = nrow(df_1),ncol = nrow(df_1))

#populate matrix
for(i in 1:nrow(df_1))
{
  for(j in 1:nrow(df_1))
  {
    m[i,j] <- stringdist(df_1$text[i],df_1$text[j],method = 'lv')
  }
}

#convert matrix to data frame
mm <- as.data.frame(m)
rownames(mm) <- df_1$text

#term-document matrix
corpsu <- Corpus(VectorSource(df_1$text))
tdm <- TermDocumentMatrix(corpsu,control = list(removePunctuation =TRUE, stopwords = TRUE,weighting = weightTfIdf))
tdm_1 <- removeSparseTerms(tdm,0.95)
tdm_1 <- as.data.frame(as.matrix(tdm_1))
rownames(tdm_1) <- 

#distance matrix
dm = dist(m,method="euclidean")

#dbscan
d <- dbscan(data = mm,eps = 10,MinPts = 2,showplot = 1,method = 'dist')
df$cluster <- d$cluster

h <- hclust(d = dm)
plot(h)
