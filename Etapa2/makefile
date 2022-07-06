all: run_etapa1
 
run_etapa1: main.o
	bison -d parser.y
	flex scanner.l
	gcc -c lex.yy.c parser.tab.c
	gcc -o parser lex.yy.o parser.tab.o -lfl
	
 
clean:
	rm -rf *.o *~ etapa2
