CC=arm-linux-gnueabihf-gcc
CFLAGS=-Wall -std=gnu11 -g -static
LDFLAGS=-static

sourcedir   = src
testdir     = tests
builddir    = build
includedir  = include

SRC=$(wildcard $(sourcedir)/*.c)
OBJ=$(patsubst $(sourcedir)/%.c, $(builddir)/%.o, $(SRC))

type: $(OBJ)
	$(CC) $(LDFLAGS) -o $(builddir)/type $^

$(builddir)/%.o: $(sourcedir)/%.c
	$(CC) $(CFLAGS) -I $(includedir) -c $< -o $@

test: $(testdir)/* $(sourcedir)/*
	@$(CC) $(CFLAGS) -I $(includedir) -c $(testdir)/*.c -o $(builddir)/test.o
	@$(CC) $(CFLAGS) -I $(includedir) -DTESTING -c $(sourcedir)/*.c
	@$(CC) $(CFLAGS) -o $(builddir)/test $(builddir)/*.o
	@rm -rf $(builddir)/*.o
	@cp $(testdir)/test.layout $(builddir)/
	@cd $(builddir); ./test

clean:
	rm -f $(builddir)/*.o $(builddir)/type $(builddir)/test
