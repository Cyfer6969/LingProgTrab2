
CC = g++
LD = g++

CFLAGS = -Wall $(shell perl -MExtUtils::Embed -e ccopts)
LFLAGS = -Wall -L/./libperl.so $(shell perl -MExtUtils::Embed -e ldopts)

LINGPROGOBJS = main.o filedir.o files.o  PerlInterpreter.o

EXECS = trab2


.c.o:
	$(CC) $(CFLAGS) -c $<

all: $(EXECS)


trab2: $(LINGPROGOBJS)
	$(LD) -o $@ $(LINGPROGOBJS) $(LFLAGS)

clean:
	rm -f *.o $(LINGPROGOBJS)

