#include <stdio.h>
typedef char lit[256];

void main (void) {
/*----Temporary variables----*/
int T1;
int T2;
int T3;
int T4;
int T5;
/*-----------------------------*/
lit A;
int B;
int D;
double C;
int E;



printf("Digite B: ");
scanf("%d", &B);
printf("Digite A: ");
scanf("%s", A);
T1 = B > 2;
if (T1) {
T2 = B <= 4;
if (T2) {
printf("B esta entre 2 e 4");
}
}
T3 = B + 1;
B = T3;
T4 = B + 2;
B = T4;
T5 = B + 3;
B = T5;
D = B;
C = 5.0;
E = B;
printf("\nB = ");
printf("%d", D);
printf("\n");
printf("%.1f", C);
printf("\n");
printf("%s", A);
printf("\n");
}
