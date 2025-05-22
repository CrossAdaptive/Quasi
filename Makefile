arch    := $(shell uname)
cpu     := $(shell uname -m)
target  := _bin/$(arch)-$(cpu)
base    := $(shell pwd)

version=3.1

all: legacy provisional final #website

legacy: $(target)/quasi_legacy

$(target)/quasi_legacy:
	mkdir -p $(target)
	gcc -o $(target)/quasi_legacy source/archive/2.0.0/quasi.c

provisional: legacy $(target)/quasi_provisional

$(target)/quasi_provisional:
	mkdir -p _gen/src/provisional
	$(target)/quasi_legacy -f _gen/src/provisional source/mt/*.txt
	gcc -o $(target)/quasi_provisional _gen/src/provisional/c/main.c

final: provisional $(target)/quasi

$(target)/quasi:
	mkdir -p _gen/src/final
	$(target)/quasi_provisional -f _gen/src/final source/mt/*.txt
	gcc -o $(target)/quasi _gen/src/final/c/main.c

clean:
	rm -rf _bin _gen _test
