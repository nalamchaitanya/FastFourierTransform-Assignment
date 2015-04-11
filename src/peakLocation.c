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
	int i =0;
	double max =0;
	double t;
	int k;
	while(fscanf(fp,"%lf",&t)>0)
	{
		i++;
		if(i<512)
		{
			continue;
		}
		if(max<t)
		{
			k=i;
			max =t;
		}
	}
	fprintf(fout,"%lf %lf\n",fs,mod((fs/2-(k-size/2)*fs/size)-f));
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