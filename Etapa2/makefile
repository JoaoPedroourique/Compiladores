all: run_etapa2
 
run_etapa2: main.o
	bison -d parser.y
	flex scanner.l
	gcc -c lex.yy.c parser.tab.c
	gcc -c main.c
	gcc -o etapa2 lex.yy.o parser.tab.o main.o -lfl
 
clean:
	rm -rf *.o *~ etapa2
