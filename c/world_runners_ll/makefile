CC=gcc
CFLAGS=-Wall
TARGET=runners
SRCS=$(TARGET).c fileops.c
DEPS = runners.h

runnersmake:
	$(CC) $(CFLAGS) $(SRCS) -o $(TARGET).exe

clean:
	@echo "Cleaning up...""
	powershell "Remove-Item -ErrorAction Ignore $(TARGET).exe; $$null"
	powershell "Remove-Item -ErrorAction Ignore records.dat; $$null"
