#
# Student makefile for Cache Lab
# Note: requires a 64-bit x86-64 system 
#
CC = gcc
CFLAGS = -g -Wall -Werror -m64
TARBALL = ${USER}-cachelab.tar

all: csim test-aoat tracegenaoat $(TARBALL)

$(TARBALL): csim.c aoat.c
	tar -cvf $(TARBALL) $^

csim: csim.c cachelab.c cachelab.h
	$(CC) $(CFLAGS) -o csim csim.c cachelab.c -lm 

test-aoat: test-aoat.c aoat.o cachelab.c cachelab.h
	$(CC) $(CFLAGS) -o test-aoat test-aoat.c cachelab.c aoat.o 

tracegenaoat: tracegenaoat.c aoat.o cachelab.c
	$(CC) $(CFLAGS) -O0 -o tracegenaoat tracegenaoat.c aoat.o cachelab.c

aoat.o: aoat.c
	$(CC) $(CFLAGS) -O0 -c aoat.c

clean:
	rm -rf *.o
	rm -f $(TARBALL)
	rm -f csim
	rm -f test-aoat tracegenaoat
	rm -f trace.all trace.f*
	rm -f .csim_results .marker

submit:  clean all $(TARBALL)
	mkdir -p ~/submissions
	cp $(TARBALL) ~/submissions/
