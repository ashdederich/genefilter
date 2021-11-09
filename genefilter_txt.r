files=list.files()
genomes_list=lapply(files,read.delim)
genomes=lapply(genomes,unlist)

gfilter.txt<-function(pathway,genomes,name,files){
    yn<-matrix(NA,nrow=length(genomes),ncol=length(pathway))
    rownames(yn)=files
    colnames(yn)<-pathway
    temp=list()
    for(genevec in 1:length(genomes)){
        temp=genomes[[genevec]]
        for(item in 1:length(pathway)){
            if(pathway[[item]]%in%temp){
                yn[genevec,item]="yes"
            }else{
                yn[genevec,item]="NO"
            }
        }
    }
    write.csv(yn,file = name)
}