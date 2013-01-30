
/* Copyright 2007 Hal Canary, http://halcanary.org/
Dedicated to the Public Domain. */
#include <stdio.h>
#include <sys/time.h>
int main(void) {
        struct timeval x;
        struct timezone t;
        gettimeofday(&x, &t);
        printf("%u.%06u\n",x.tv_sec,x.tv_usec);
        return(0);
}
