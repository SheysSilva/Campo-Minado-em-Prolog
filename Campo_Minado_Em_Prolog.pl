/*:-[textos].*/

use_module(library(random)).

/*Retorna uma matriz de elementos (X, Y, Z), X eh a coordenada do eixo X, Y eh a coordenada do eixo Y e Z e o valor na posicao XY.*/
criaMatriz(X, Matriz):- Matriz = 
[(1, 1, X), (1, 2, X), (1, 3, X), (1, 4, X), (1, 5, X), (1, 6, X), (1, 7, X), (1, 8, X), (1, 9, X), 
(2, 1, X), (2, 2, X), (2, 3, X), (2, 4, X), (2, 5, X), (2, 6, X), (2, 7, X), (2, 8, X), (2, 9, X), 
(3, 1, X), (3, 2, X), (3, 3, X), (3, 4, X), (3, 5, X), (3, 6, X), (3, 7, X), (3, 8, X), (3, 9, X), 
(4, 1, X), (4, 2, X), (4, 3, X), (4, 4, X), (4, 5, X), (4, 6, X), (4, 7, X), (4, 8, X), (4, 9, X), 
(5, 1, X), (5, 2, X), (5, 3, X), (5, 4, X), (5, 5, X), (5, 6, X), (5, 7, X), (5, 8, X), (5, 9, X), 
(6, 1, X), (6, 2, X), (6, 3, X), (6, 4, X), (6, 5, X), (6, 6, X), (6, 7, X), (6, 8, X), (6, 9, X), 
(7, 1, X), (7, 2, X), (7, 3, X), (7, 4, X), (7, 5, X), (7, 6, X), (7, 7, X), (7, 8, X), (7, 9, X), 
(8, 1, X), (8, 2, X), (8, 3, X), (8, 4, X), (8, 5, X), (8, 6, X), (8, 7, X), (8, 8, X), (8, 9, X), 
(9, 1, X), (9, 2, X), (9, 3, X), (9, 4, X), (9, 5, X), (9, 6, X), (9, 7, X), (9, 8, X), (9, 9, X)]. 

/*Funcao para numeros aleatorios entre 1 e 10.*/
numeroAleatorio(X):- random(1, 10, X).	

/*Funcoes que geram as bombas*/
/*Funcao que chama o insereBombaNaMatriz 8 vezes e no final chama o somaAdjacentes.*/
gerando8Bombas(Matriz, Matriz, 9).
gerando8Bombas(Matriz, Matriz_mod, Contador):- 
	numeroAleatorio(X), numeroAleatorio(Y), 
	insereBombaNaMatriz(X, Y, Matriz, Matriz_modificada),
	C is (Contador+1), 
	gerando8Bombas(Matriz_modificada, Matriz_mod, C).

/*Funcao que insere as bombas na matriz.*/
insereBombaNaMatriz(_, _, [], []).
insereBombaNaMatriz(X, Y, [(X, Y, _)|Corpo], [(X, Y, -1)|Corpo]).
insereBombaNaMatriz(X, Y, [(Z, W, K)|Corpo], [(Z, W, K)|Res]):- 
	insereBombaNaMatriz(X, Y, Corpo, Res).
 
/*Final das funcoes que geram a bomba na matriz.*/

/*Função que soma os adjacentes das posições que possuem bomba.*/
soma(Matriz, Matriz_somada):- 
	buscaPosicaoDaBomba(Matriz, L), 
	percorrePosicoes(Matriz, L, Matriz_somada).

/*Funcao que retorna uma lista com todas as posicoes de bombas da matriz.*/
percorrePosicoes(Matriz,[], Matriz).
percorrePosicoes(Matriz, [(X, Y)|Corpo], Matriz_Retorno):-
	somaAdjacentes(X, Y, Matriz, Matriz_mod),	
	percorrePosicoes(Matriz_mod, Corpo, Matriz_Retorno).

/*Funcao que chama verificaPosESoma para cada posicao adjacente a coordenada da bomba passada no parametro.*/
somaAdjacentes(1, 1, Matriz, Matriz_somada):- 
	verificaPosESoma(1, 2, Matriz, Matriz_Soma1), 
	verificaPosESoma(2, 1, Matriz_Soma1, Matriz_Soma2), 
	verificaPosESoma(2, 2, Matriz_Soma2, Matriz_somada). 
somaAdjacentes(1, Y, Matriz, Matriz_somada):- 
	Y1 is (Y+1), 
	Y2 is (Y-1),
	verificaPosESoma(1, Y1, Matriz, Matriz_Soma1), 
	verificaPosESoma(1, Y2, Matriz_Soma1, Matriz_Soma2), 
	verificaPosESoma(2, Y, Matriz_Soma2, Matriz_Soma3), 
	verificaPosESoma(2, Y1, Matriz_Soma3, Matriz_Soma4), 
	verificaPosESoma(2, Y2, Matriz_Soma4, Matriz_somada). 
somaAdjacentes(1, 9, Matriz, Matriz_somada):- 
	verificaPosESoma(1, 8, Matriz, Matriz_Soma1), 
	verificaPosESoma(2, 9, Matriz_Soma1, Matriz_Soma2), 
	verificaPosESoma(2, 8, Matriz_Soma2, Matriz_somada). 
somaAdjacentes(9, 1, Matriz, Matriz_somada):- 
	verificaPosESoma(9, 2, Matriz, Matriz_Soma1), 
	verificaPosESoma(8, 1, Matriz_Soma1, Matriz_Soma2), 
	verificaPosESoma(8, 2, Matriz_Soma2, Matriz_somada). 
somaAdjacentes(9, 9, Matriz, Matriz_somada):- 
	verificaPosESoma(9, 8, Matriz, Matriz_Soma1), 
	verificaPosESoma(8, 9, Matriz_Soma1, Matriz_Soma2), 
	verificaPosESoma(8, 8, Matriz_Soma2, Matriz_somada). 
somaAdjacentes(9, Y, Matriz, Matriz_somada):- 
	Y1 is (Y+1), 
	Y2 is (Y-1),
	verificaPosESoma(9, Y1, Matriz, Matriz_Soma1), 
	verificaPosESoma(9, Y2, Matriz_Soma1, Matriz_Soma2), 
	verificaPosESoma(8, Y, Matriz_Soma2, Matriz_Soma3), 
	verificaPosESoma(8, Y1, Matriz_Soma3, Matriz_Soma4), 
	verificaPosESoma(8, Y2, Matriz_Soma4, Matriz_somada). 
somaAdjacentes(X, 9, Matriz, Matriz_somada):- 
	X1 is (X+1),
	X2 is (X-1),
	verificaPosESoma(X, 8, Matriz, Matriz_Soma1), 
	verificaPosESoma(X2, 9, Matriz_Soma1, Matriz_Soma2), 
	verificaPosESoma(X2, 8, Matriz_Soma2, Matriz_Soma3), 
	verificaPosESoma(X1, 9, Matriz_Soma3, Matriz_Soma4), 
	verificaPosESoma(X1, 8, Matriz_Soma4, Matriz_somada).
somaAdjacentes(X, Y, Matriz, Matriz_somada):-
	X1 is (X+1),
	X2 is (X-1), 
	Y1 is (Y+1), 
	Y2 is (Y-1),
	verificaPosESoma(X, Y2, Matriz, Matriz_Soma1),  
	verificaPosESoma(X, Y1, Matriz_Soma1, Matriz_Soma2),  
	verificaPosESoma(X2, Y, Matriz_Soma2, Matriz_Soma3),  
	verificaPosESoma(X2, Y1, Matriz_Soma3, Matriz_Soma4),  
	verificaPosESoma(X2, Y2, Matriz_Soma4, Matriz_Soma5), 
	verificaPosESoma(X1, Y, Matriz_Soma5, Matriz_Soma6), 
	verificaPosESoma(X1, Y1, Matriz_Soma6, Matriz_Soma7),
	verificaPosESoma(X1, Y2, Matriz_Soma7, Matriz_somada). 

/*Funcao que verifique se a posicao possui uma bomba, caso nao possua, soma uma unidade do seu valor anterior.*/verificaPosESoma(_, _, [], []).
verificaPosESoma(X, Y, [(X, Y, -1)| Corpo], [(X, Y, -1)|Corpo]).
verificaPosESoma(X, Y, [(X, Y, Z)| Corpo], [(X, Y, Z1)|Corpo]):- Z1 is (Z+1).
verificaPosESoma(X, Y, [(X1, Y1, Z)| Corpo], [(X1, Y1, Z)|Res]):- verificaPosESoma(X, Y, Corpo, Res).

 
/*Função que busca as posições das bombas e armazena em uma lista de tuplas.*/
buscaPosicaoDaBomba([], []).
buscaPosicaoDaBomba([(X, Y, -1)|Corpo], [(X, Y)|Res]):- 
	buscaPosicaoDaBomba(Corpo, Res).
buscaPosicaoDaBomba([(_, _, _)|Corpo], L):- 
	buscaPosicaoDaBomba(Corpo, L).

/*Final das funções de soma dos adjacentes.*/

/*Funcoes de impressao de Matriz para o usuario.*/
imprime([]):-
	write("    -------------------------------------"),nl. 
imprime([(_,_,X1),(_,_,X2), (_,_,X3), (_,_,X4), (_,_,X5), (_,_,X6), (_,_,X7), (_,_,X8), (_,_,X9)|Corpo]):- 
	write("    -------------------------------------"),nl, 
	write("    | "), write(X1), 
	write(" | "), write(X2), 
	write(" | "), write(X3), 
	write(" | "), write(X4), 
	write(" | "), write(X5), 
	write(" | "), write(X6), 
	write(" | "), write(X7), 
	write(" | "), write(X8), 
	write(" | "), write(X9),
	write(" |"), nl,imprime(Corpo).

modificaMatriz([],[]).
modificaMatriz([(_, _, Z)|Corpo], [(_, _, Z2)|Corpo2]):- 
	Z =:= (-2), Z2 = " ", 
	modificaMatriz(Corpo,Corpo2).
modificaMatriz([(_, _, Z)|Corpo], [(_, _, Z2)|Corpo2]):- 
	Z =:= (-1), Z2 = "*", 
	modificaMatriz(Corpo,Corpo2).
modificaMatriz([(_, _, Z)|Corpo], [(_, _, Z2)|Corpo2]):- 
	Z2 = Z, 
	modificaMatriz(Corpo, Corpo2).
/*Final das funcoes de impressao.*/

/*Menu do jogo*/
menu(Matriz_Final, Matriz):- 
	read_X(CoordX), 
	read_Y(CoordY), 
	mostraMatrizModificada(Matriz_Final, CoordX, CoordY, Matriz).
/*Modifica a matriz apresentada ao usuario, imprime ela e caso tenha ganhado ou perdido, imprime uma mensagem final.*/
mostraMatrizModificada(Matriz_Final, CoordX, CoordY, Matriz):- 
	atualizaMatriz(CoordX, CoordY, Matriz_Final, Matriz, Matriz_mod), 
	(not(possuiBomba(CoordX, CoordY, Matriz_Final))),
	naoGanhouJogo(Matriz_mod),
	modificaMatriz(Matriz_mod, Mtz_Impressa),
	imprime(Mtz_Impressa), 
	menu(Matriz_Final, Matriz_mod).
mostraMatrizModificada(Matriz_Final, CoordX, CoordY, _):- 
	possuiBomba(CoordX, CoordY, Matriz_Final),
	modificaMatriz(Matriz_Final, Mtz_Impressa),
	imprime(Mtz_Impressa), write("PERDEU OTARIO!").
mostraMatrizModificada(Matriz_Final, _, _, Matriz):-
	not(naoGanhouJogo(Matriz)),
	modificaMatriz(Matriz_Final, Mtz_Impressa),
	imprime(Mtz_Impressa), write("GANHOU OTARIO!").

/*Funcao que verifica se nao ganhou o jogo.*/
naoGanhouJogo([]):-false.
naoGanhouJogo([(_, _, -2)|_]).
naoGanhouJogo([(_, _, _)|Corpo]):-naoGanhouJogo(Corpo).

/*Funcao que atualiza a matriz mostrada para o usuario, de acordo com as coordenadas informadas pelo usuario.*/
atualizaMatriz(_, _, [], [], []).
atualizaMatriz(X, Y, [(X, Y, Z)|_], [(X, Y, _)|Corpo1], [(X, Y, Z)|Corpo1]).
atualizaMatriz(X, Y, [(_, _, _)|Corpo], [(A, B, C)|Corpo1], [(A, B, C)|Res]):- atualizaMatriz(X, Y, Corpo, Corpo1, Res).

/*Funcao que verifica se a posicao fornecida pelo usuario possui bomba.*/
/*Verifica essa função*/
possuiBomba(_, _, []):- false.
possuiBomba(X, Y, [(X, Y, -1)|_]).
possuiBomba(X, Y, [(_, _, _)|Corpo]):- possuiBomba(X, Y, Corpo).
 
read_X(CoordX) :-
	writeln("Digite uma coordenada x entre 1 e 9: "),
	read_line_to_codes(user_input, X2),
	(string_to_atom(X2,X1),
	atom_number(X1,X), X =< 9, X >= 1) -> (CoordX is X); (write("Número invalido"),nl, read_X(CoordX)).

read_Y(CoordY) :-
	writeln("Digite uma coordenada y entre 1 e 9: "),
	read_line_to_codes(user_input, Y2),
	(string_to_atom(Y2,Y1),
	atom_number(Y1,Y), Y =< 9, Y >= 1) -> ( CoordY is Y); (write("Número invalido"),nl, read_Y(CoordY)).
/*Final das funcoes de Menu.*/

main:- 
	/*textos.*/
	criaMatriz(0, Matriz), 
	gerando8Bombas(Matriz, Matriz_Mod, 1),
	soma(Matriz_Mod, Matriz_Final),
	criaMatriz(-2, Matriz_OUTRA),
	menu(Matriz_Final, Matriz_OUTRA).

/*Falta subistituir AS MSG DE GANHOU E PERDEU.*/




