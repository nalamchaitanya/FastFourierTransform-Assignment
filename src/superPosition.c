#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(int argc , char* argv[])
{
	if(argc!=4)
	{
		printf("Signal1 Signal2 Output\n");
		exit(1);
	}
	FILE *fp1 = fopen(argv[1],"r");
	FILE *fp2 = fopen(argv[2],"r");
	FILE *fout= fopen(argv[3],"w");
	double a,b;
	int i;
	while(fscanf(fp1,"%lf",&a)>0&&fscanf(fp2,"%lf",&b)>0)
	{
		fprintf(fout,"%lf\n",a+b);
	}
	if(fscanf(fp1,"%lf",&a)<0)
		while(fscanf(fp2,"%lf",&b)>0)
			fprintf(fout,"%lf\n",b);
	if(fscanf(fp2,"%lf",&b)<0)
		while(fscanf(fp1,"%lf",&a)>0)
			fprintf(fout,"%lf\n",a);
	fclose(fp1);
	fclose(fp2);
	fclose(fout);
	return 0;
}