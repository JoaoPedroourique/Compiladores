calc: calc.y calc.l
	bison -d calc.y
	flex -o calc.lex.c calc.l
	gcc -Wall -o calc asd.c calc.lex.c calc.tab.c -lfl -lm 

asd: asd.h asd.c
	gcc -Wall -o asd asd.c asd_main.c

clean:
	rm -rf calc
