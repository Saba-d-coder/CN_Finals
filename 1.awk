BEGIN{
    drop=0;
    sent=0;
    received=0;
}
{

    event=$1
    type=$5

    if(type == "cbr"){
        if(event == "+"){
            sent++
        }
        else if(event == "r"){
            received++;
        }
        else if(event == "d"){
            drop++;
        }
    }
}
END{
    printf("\nSent:%d\n",sent)
    printf("\nDroppedT:%d\n",drop)
    printf("\nRecevived:%d\n",received)
}