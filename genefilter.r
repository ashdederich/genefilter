#!/usr/bin/env Rscript

args=commandArgs(trailingOnly=TRUE)

library(genbankr)

genefilter<-function(args[1],args[2],args[3]){
    if (length(args)==0) {
        stop("Must supply three arguments: a List of Genes in vector format, the name of the output file, and a directory where the files are stored.", call.=FALSE)
    } else if (args[2]=='') {
        args[2] = "genefilter_OUT"
    }
    genelist=vector()
    genelist=append(genelist,args[1],1)
    files=list.files(args[3])
    genomes<-lapply(files,parseGenBank)
    yn<-matrix(NA,nrow=length(genomes),ncol=length(args[1]))
    rownames(yn)=files
    colnames(yn)<-args[1]
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
    write.csv(yn,file = args[2])
}