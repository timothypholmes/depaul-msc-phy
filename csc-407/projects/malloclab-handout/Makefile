include Makefile.inc
LIBS = $(shell grep 'USE_PAPI.*1' config.h > /dev/null && echo '-lpapi -lpfm')
CC = gcc

OBJS = mdriver.o mm.o memlib.o fsecs.o fcyc.o clock.o ftimer.o

all:
	@[[ $(VERSION) = "normal" ]] || { cat Makefile-normal.inc > Makefile.inc; make clean; }
	@make mdriver

debug:
	@[[ $(VERSION) = "debug" ]] || { cat Makefile-debug.inc > Makefile.inc; make clean; }
	@make mdriver


mdriver: $(OBJS)
	$(CC) $(local_CFLAGS) -o mdriver $(OBJS) $(LIBS)

%.o: %.c
	$(CC) $(local_CFLAGS) -c $< -o $@

mdriver.o: mdriver.c fsecs.h fcyc.h clock.h memlib.h config.h mm.h
memlib.o: memlib.c memlib.h config.h
fsecs.o: fsecs.c fsecs.h config.h config.h
fcyc.o: fcyc.c fcyc.h config.h
ftimer.o: ftimer.c ftimer.h config.h 
clock.o: clock.c clock.h config.h
mm.o: mm.c mm.h memlib.h config.h

clean:
	rm -f *~ *.o mdriver

submit: clean all
	mkdir -p ~/submissions
	cp mm.c ~/submissions/${USER}-mm.c
