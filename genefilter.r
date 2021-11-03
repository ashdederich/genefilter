#!/usr/bin/env Rscript

args=commandArgs(trailingOnly=TRUE)

library(genbankr)
library(matrixStats)

genefilter<-function(genes=args[1],workdir=args[2],filename=args[3],count_matrix=args[4]){
    if(length(args)==0) {
        stop("Must supply three arguments: a List of Genes in vector format, the name of the output file, and a directory where the files are stored.", call.=FALSE)
    } else if(args[1]=='') {
        stop("You must provide at least one gene to search for.")
    } else if(args[2]=='') {
        args[2] = getwd()
    } else if(args[3]=='') {
        args[3]="genefilter_OUT.csv"
    }
    else if(args[4]=='') {
        args[4]=TRUE
    }
    #creating a vector of genes
    genelist=genes
    files=list.files(workdir)
    genomes<-lapply(files,parseGenBank)
    yn<-matrix(NA,nrow=length(genomes),ncol=length(genes))
    rownames(yn)=files
    colnames(yn)<-genes
    #making a count matrix to count number of genes that appear in each genome. If user says 'FALSE', then the count matrix will not be applied and the function will output the matrix of yes/no
    countmat<--matrix(NA,nrow=length(genomes),ncol=1)
    rownames(countmat)<-genomes
    colnames(countmat)<-"Count of Genes"
    for(i in 1:length(genomes)){
        temp<-list()
        for(j in 2:length(genomes[[i]]$FEATURES)){
            temp[[j]]<-genomes[[i]]$FEATURES[[j]]$gene
        }
        for(k in 1:length(args[1])){
            if(args[1][[k]] %in% temp){
                yn[i,k]<-"yes"
            }else{
                yn[i,k]<-"NO"
            }
        }
    }
    count<-rowCounts(yn,value="yes")
    countmat[,1]=count
    if(count_matrix==TRUE){
        write.csv(countmat,file=filename)
    }
    else if(count_matrix==FALSE){
        write.csv(yn,file=filename)
    }
}