#include<stdio.h>
#include<string.h>
#include<stdlib.h>

#define N strlen(divisor)  
char data[30],checksum[30],bin[250],r[7]; 

char divisor[] = "10001000000100001"; 
int a,e,c;

void rev(){
    int n=strlen(r)-1;
    int s=strlen(bin);
    int i;
    for(i=n;i>=0;i--){
        bin[s++]=r[i];
    }
}

void strtobin(){
    int n = strlen(data); 
    int i;
  
    for (i = 0; i < n; i++) { 
        // convert each char to ASCII value 
        strcpy(r,"");
        int val = (int)(data[i]); 
        char ch='1',ch1='0';
        // Convert ASCII value to binary 
        while (val > 0){ 
            (val % 2)? strncat(r,&ch,1) : strncat(r,&ch1,1); 
            val /= 2; 
        } 
        rev();
    } 
    printf("Entered data in binary: %s",bin);
}

void xor(){
    for(int i=1;i<N;i++)
        checksum[i] = ((checksum[i] == divisor[i]) ? '0' : '1');
}


void crc(){
    for(e=0;e<N;e++)
        checksum[e] = bin[e];

    do{
        if(checksum[0] == '1'){
            xor(); 
        }
        
        for(c=0;c<N-1;c++)
            checksum[c] = checksum[c+1];

        checksum[c] = bin[e++];
    }while(e <= a+N-1); 

}

int main(){
    int ch;
    printf("\nEnter:\n0. to enter binary input\n1. to enter string input:");
    scanf("%d",&ch);
    if(ch==1){
        printf("\nEnter a string data: ");
        scanf("%s",data); 
        strtobin();
    }
    else{
        printf("\nEnter a binary data: ");
        scanf("%s",data);
        strcpy(bin,data);
    }

    printf("\nGenerating Polynomial:\t %s",divisor); 
    
    a = strlen(bin); 

    for(e=a;e<a+N-1;e++){
        bin[e] = '0';
    }

    printf("\nPadded data is: %s",bin);

    crc(); 

    printf("\nSyndrome or remainder is %s",checksum);

    for(e=a;e<a+N-1;e++){
        bin[e] = checksum[e-a]; 
    }

    printf("\nFinal codeword is %s",bin);

    printf("\nWant to test error detection. Press 0 for yes and 1 for no:\t");
    scanf("%d",&e);

    if(e == 0){
        int pos=rand()%a;
        bin[pos]=(bin[pos]=='0')?'1':'0';
        printf("\nErroneous data: %s",bin); 
    }

    crc(); 
           
    for(e=0;(e<N-1) && (checksum[e] != '1');e++){
        printf("\n Checking... "); 
    }

    if(e<N-1){
        printf("\nError detected\n\n");
    }
    else{
        printf("\nNo error detected.");
    }
    return 0;
}