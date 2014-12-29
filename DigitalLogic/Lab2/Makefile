COMPILE=iverilog
V=TestBench.v
FILE=$(patsubst %.v,%,$V)

.PHONY: all clean run

all: $V
	$(COMPILE) -o $(FILE) $V

clean:
	@rm -f $(FILE) *.vcd

run: all
	@vvp $(FILE)
	@gtkwave *.vcd
