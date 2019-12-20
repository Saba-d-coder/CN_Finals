BEGIN{
    telS=0;
    tel=0;
    ftpS=0;
    ftp=0;
    totalTel=0;
    totalFtp=0
}
{
    event=$1
    type=$5
    size=$6
    from=$9
    to=$10

    if(type== "tcp" && event == "r" && from =="0.0" && to=="3.0"){
        tel++;
        telS=size;
    }

    if(type== "tcp" && event == "r" && from =="1.0" && to=="3.1"){
        ftp++;
        ftpS=size;
    }
}
END{
    totalFtp=ftp *ftpS *8 /24;
    totalTel=tel *telS *8 /24;
    printf("Throughput of telnet:%d\n",totalTel);
    printf("Throughput of ftp:%d\n",totalFtp);
}