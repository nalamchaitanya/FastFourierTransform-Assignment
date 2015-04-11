#include <stdio.h>
#include <stdlib.h>

double mod(double a);
int main(int argc , char* argv[])
{
	if(argc!=6)
	{
		printf("inputFile frequency samplingRate FFTSize outputFile\n");
		exit(1);
	}
	FILE *fp = fopen(argv[1],"r");
	FILE *fout = fopen(argv[5],"a");
	double fs = atof(argv[3]);
	double f = atof(argv[2]);
	int size = atoi(argv[4]);
	double count = 0;
	double temp,pretemp;
	pretemp = 1;
	while(fscanf(fp,"%lf",&temp)>0)
	{
		if(temp*pretemp<0||temp==0)
			count++;
		pretemp = temp;
	}
	fprintf(fout,"%lf %lf\n",fs,mod((count*fs/(2*size))-f));
	//printf("%lf\n",count*fs/4096 );
	fclose(fp);
	fclose(fout);
	return 0;
}

double mod(double a)
{
	if(a>0)
		return a;
	else return -a;
}