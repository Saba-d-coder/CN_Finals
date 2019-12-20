BEGIN{
    drop=0;
}
{
    event=$1
    if(event == "d"){
        drop++;
    }
}

END{
    printf("\n Total pckts dropped:%d\n",drop)
}