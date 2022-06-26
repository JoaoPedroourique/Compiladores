all: run_etapa1
 
run_etapa1: main.o
	flex scanner.l
	gcc main.c ext_functions.c lex.yy.c -o etapa1
 
clean:
	rm -rf *.o *~ etapa1