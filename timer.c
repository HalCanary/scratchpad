/* Copyright 2009 Hal Canary, http://halcanary.org/
   Dedicated to the Public Domain.

   cc -o timer timer.c
*/
#include <stdio.h>
#include <sys/time.h>
int main(int argc, char *argv[]) {
  int totalminutes, totalseconds; /* args */
  int minute, second; /* counter */
  if (argc <= 1) {
    fprintf(stderr, "Usage: timer MINUTES [SECONDS]\n\n");
    return(1);
  }
  totalminutes = atoi(argv[1]); /* FIRST ARGUMENT */
  if (argc >= 3) {
    totalseconds = atoi(argv[2]); /* FIRST ARGUMENT */
  } else {
    totalseconds = 0;
  }
  printf("%02i:%02i ",totalminutes,totalseconds);
  for(minute=totalminutes; minute >= 0; minute--) {
    for(second=totalseconds-1; second >= 0; second--) {
      printf("\b\b\b\b\b\b\b%02i:%02i ",minute,second);
      fflush(stdout);
      sleep(1);
    }
    totalseconds=60;
  }
  printf("\n");
  return(0);
}
