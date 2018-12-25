#include<stdio.h>
#include<stdlib.h>
#include<math.h>
extern void mytest();
extern void example1();
int main() {
    printf("hello,world\n");
    mytest();
    example1();
    int * p = malloc(sizeof(int));
    printf("*p value is %d\n",*p);
    return 0;
}
