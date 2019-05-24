/*Student#		Section#	Name*/
/*500644178 	4			Eric Jaskierski*/
/*500681845 	4			Rudi Zhou*/
/*500748954 	4			Maxim Tolkatchev*/

/*solve([S,A,Y,M,N,E,T,L]):-*/
/*	dig(S), dig(A), dig(Y), dig(M), dig(N), dig(E), dig(T), dig(Y),*/
	
/*	S>0, M>0, N>0, A>0,*/
/*	A1 is (Y*Y), A2 is (Y*A*10), A3 is (Y*S*100),*/
/*	B1 is (M*Y*10), B2 is (M*A*100), B3 is (M*S*1000),*/
/*	
/*	NAME is A1+A2+A3,*/
/*	E is NAME mod 10, */
/*	M is (NAME mod 100)//10, A is (NAME mod 1000)//100, N is (NAME mod 10000)//1000,*/
/*	AMNE is (B1+B2+B3),*/
/*	E is (AMNE mod 100)//10, */
/*	N is (AMNE mod 1000)//100, M is (AMNE mod 10000)//1000, A is (AMNE mod 100000)//10000,*/
	
/*	L is (M+E) mod 10, C1 is (M+E)//10,*/
/*	Y is (A+N+C1) mod 10, C2 is (A+N+C1)//10,*/
/*	T is (N+M+C2) mod 10, C3 is (N+M+C2)//10,*/
/*	S is (A+C3) mod 10,*/
	
/*	all_diff([S,A,Y,M,N,E,T,L]).*/

print_solution :-
	solve([S,A,Y,M,N,E,T,L]),
	write('       '),write(S),write(A),write(Y),nl,
	write('*       '),write(M),write(Y),nl,
	write('  ---------'),nl,
	write('      '),write(N),write(A),write(M),write(E),nl,
	write('+    '),write(A),write(M),write(N),write(E),write(' '),nl,
	write('  ---------'),nl,
	write('     '),write(S),write(T),write(Y),write(L),write(E),nl.
	
	
solve([S,A,Y,M,N,E,T,L]):-
	car(C1), dig(S), dig(A), A>0,
	S is A+C1,
	dig(N), N>0, dig(M), M > 0, car(C2),
	T is (N+M+C2) mod 10,
	car(C3),
	Y is (A+N+C3) mod 10, N is (((Y*Y)+(Y*A*10)+(Y*S*100))mod 10000)//1000,
	E is (M*Y) mod 10, E is (Y*Y) mod 10,
	L is (M+E) mod 10,
	
	all_diff([S,A,Y,M,N,E,T,L]).

	
car(0). car(1).
dig(0). dig(1). dig(2). dig(3). dig(4). dig(5). dig(6). dig(7). dig(8). dig(9).
	
all_diff([]).
all_diff([N|L]) :- not member2(N,L), all_diff(L).

member2(N,[N|L]).
member2(N,[M|L]) :- member(N,L).


