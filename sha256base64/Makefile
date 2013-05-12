target = sha256base64

CFLAGS = -O3 -Wall -Wextra -pedantic
LDFLAGS = -lssl -lcrypto
all: $(target)
$(target): $(target).o
.PHONY : all
%.o: %.c
	$(CC) -c $< $(CPPFLAGS) $(CFLAGS) -o $@
%: %.o
	$(CC) $< $(LDFLAGS) $(LOADLIBES) -o $@
