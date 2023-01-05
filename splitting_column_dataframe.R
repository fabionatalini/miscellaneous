#Data manipulation in R: splitting columns in data frames.


#With this script you can split a column of a data frame to multiple colums.
#consider the following data frame
some.names<-data.frame(col1=c("a.10","b.11","c.12","d.13","e.14"),col2=c('john','mary','max','jack','jane'))

#we want to split the first column.
#Convert the first column to a character vector
some.names$col1<-as.character(some.names$col1)

#pass the first column to the function read.table using arguments text and sep
newcol<-read.table(text=some.names$col1, sep='.')
some.names<-cbind(some.names,newcol)

#now you may remove col1, reorder the colums and give them new names
some.names<-some.names[,c(3,4,2)]
colnames(some.names)<-c('newcol1','newcol2','newcol3')
print(some.names)