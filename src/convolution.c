#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(int argc , char* argv[])
{
	if(argc!=6)
	{
		printf("Signal1 FFTSize1 Signal2 FFTSize2 Output\n");
		exit(1);
	}
	FILE *fp1 = fopen(argv[1],"r");
	FILE *fp2 = fopen(argv[3],"r");
	FILE *fout= fopen(argv[5],"w");
	int i;
	int sizeA = atoi(argv[2]);
	int sizeB = atoi(argv[4]);
	double* a = (double*)malloc(sizeof(double)*sizeA);
	double* b = (double*)malloc(sizeof(double)*sizeB);
	for(i=0;i<sizeA;i++)
	{
		fscanf(fp1,"%lf",a+i);
	}
	for(i=0;i<sizeB;i++)
	{
		fscanf(fp2,"%lf",b+i);
	}
	double temp;
	int j;
	for(i=0;i<sizeA+sizeB-1;i++)
	{
		temp = 0;
		for(j=0;j<sizeA;j++)
		{
			if((i-j<sizeB)&&(i-j>-1))
				temp+=a[j]*b[i-j];
		}
		fprintf(fout, "%lf\n",temp );
	}
	fprintf(fout, "0\n");
	return 0;
}