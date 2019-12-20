#include<stdio.h>
#include<stdlib.h>
#define MIN(x,y) (x>y) ? y:x

int main()
{
    int rate=2,drop=0,cap=5,x,count=0,inp[10]={0},ch,i=0;
    
    for(i=0;i<5;i++)
        inp[i]=rand()%10;
    
    printf("\nsize\tsent\tdropped\tremained \n");
    
    for(i=0;count || i<6;i++)
    {
        printf("%d\t ",inp[i]);
        printf("%d\t ",MIN((inp[i]+count),rate));
        
        if((x=inp[i]+count-rate)>0){
            if(x>cap){
                count=cap;
                drop=x-cap;
            }
            else{
                count=x;
                drop=0;
            }
        }
        else{
            drop=0;
            count=0;
        }
        printf("%d \t %d \n",drop,count);
    }   // end of for loop

    return 0;
}