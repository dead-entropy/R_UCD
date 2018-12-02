#include <stdio.h>
#include <R.h>
#include <Rmath.h> 

void findsum(double *data, double *out, int *N)
{
  int i;

  for(i=0;i<*N;i++){
    *out = *out + data[i];
  }
  
}

