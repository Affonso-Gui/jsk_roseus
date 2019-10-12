all: roseus

EUSCOMP = euscomp
ROSFLAGS = -P ros

roseus: roseus.l eustf.l
	$(EUSCOMP) $(ROSFLAGS) $?

clean:
	-$(RM) roseus.c roseus.h roseus.o roseus.so
	-$(RM) eustf.c eustf.h eustf.o eustf.so
