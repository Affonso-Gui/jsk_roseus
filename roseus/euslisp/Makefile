all: roseus

EUSCOMP = euscomp
ROSFLAGS = -P ros

roseus: roseus.l
	$(EUSCOMP) $(ROSFLAGS) $?

clean:
	-$(RM) roseus.c roseus.h roseus.o roseus.so
