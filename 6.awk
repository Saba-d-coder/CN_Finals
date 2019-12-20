BEGIN{
    cbrS=0;
    cbr=0;
    ftpS=0;
    ftp=0;
    totalcbr=0;
    totalFtp=0
}
{
    event=$1
    type=$5
    size=$6
    

    if(type== "cbr" && event == "r"){
        cbr++;
        cbrS=size;
    }

    if(type== "tcp" && event == "r"){
        ftp++;
        ftpS=size;
    }
}
END{
    totalFtp=ftp *ftpS /124;
    totalcbr=cbr *cbrS /124;
    printf("Throughput of cbr:%d\n",totalcbr);
    printf("Throughput of ftp:%d\n",totalFtp);
}