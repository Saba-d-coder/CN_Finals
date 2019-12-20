BEGIN{
    tcpS=0;
    tcpR=0;
    cbrS=0;
    cbrR=0;
}
{
    event=$1;
    type=$5;

    if(type == "tcp"){
        if(event =="+"){
            tcpS++
        }
        else if(event == "r"){
            tcpR++
        }
    }
    else if(type == "cbr"){
        if(event =="+"){
            cbrS++
        }
        else if(event == "r"){
            cbrR++
        }
    }
}
END{
    printf("tcp Sent:%d\n",tcpS)
    printf("tcp Received:%d\n",tcpR)
    printf("Cbr Sent:%d\n",cbrS)
    printf("Cbr Receievd:%d\n",cbrR)

}