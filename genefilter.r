#!/usr/bin/env Rscript

args=commandArgs(trailingOnly=TRUE)

library(genbankr)

genefilter<-function(genes=args[1],workdir=args[2],name=args[3]){
    if (length(args)==0) {
        stop("Must supply three arguments: a List of Genes in vector format, the name of the output file, and a directory where the files are stored.", call.=FALSE)
    } else if args[1]=='') {
        stop("You must provide at least one gene to search for.")
    } else if (args[2]=='') {
        args[2] = getwd()
    } else if (args[3]=='') {
        args[3]="genefilter_OUT.csv"
    }
    #creating a vector of genes
    genelist=genes
    files=list.files(workdir)
    genomes<-lapply(files,parseGenBank)
    yn<-matrix(NA,nrow=length(genomes),ncol=length(genes))
    rownames(yn)=files
    colnames(yn)<-genes
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

gfilter.gbk(genes=vit,name="vit.csv",files=files)
