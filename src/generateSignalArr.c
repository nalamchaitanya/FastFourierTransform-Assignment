#include "stdio.h"
#include "stdlib.h"
#include "math.h"

#define pi M_PI
int main(int argc, char* argv[])
{
	if(argc!=6)
	{
		printf("frequency samplingRate amplitude FFTSize outputFile\n");
		exit(1);
	}
	FILE *fp = fopen(argv[5],"w");
	double a = atof(argv[3]);
	double f = atof(argv[1]);
	double fs = atof(argv[2]);
	int size = atoi(argv[4]);
	double i;
	double j;
	for(i=0;i<size;i++)
	{
		j = a*sin(i*f*2*pi/fs);
		fprintf(fp,"%lf\n",j);
	}
	fclose(fp);
	return 0;
}