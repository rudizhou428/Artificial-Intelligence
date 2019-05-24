/* CPS721: Assignment 5, BONUS, file bonus.pl */
	
/*Student#		Section#	Name*/
/*500644178 	4			Eric Jaskierski*/
/*500681845 	4			Rudi Zhou*/
        
/* This is necessary if rules with the same predicate in the head are not
 consecutive in your program. Read handout about Eclipse Prolog 6 for details. */
:- dynamic thinking/2.
:- dynamic waiting/2.
:- dynamic eating/2.
:- dynamic available/2.
:- dynamic has/3.

	/* Universal situations and fluents based planner  */

solve_problem(L,N)  :-  C0 is cputime,
                   max_length(L,N), 
                   reachable(S,L), goal_state(S),
                   Cf is cputime, D is Cf - C0, nl,
                   write('Elapsed time (sec): '), write(D), nl.

reachable(S,[]) :- initial_state(S).

/*reachable(S2, [M | History]) :- reachable(S1,History),
                        legal_move(S2,M,S1).

 Remove comments if you want to solve the bonus question
*/
reachable(S2, [M | History]) :- reachable(S1,History),
                        legal_move(S2,M,S1),
                        not useless(M,History).

legal_move([A | S], A, S) :- poss(A,S).

initial_state([]).

max_length([],N).
max_length([_|L],N1) :- N1 > 0, N is N1 - 1, max_length(L,N).


/*                 Precondition Axioms                    */

%% write your precondition rules here

poss(pickUp(P,F),S) :-  philosopher(P), fork(F), between(P,F,_), available(F,S).
poss(putDown(P,F),S):-  philosopher(P), fork(F), has(P,F,S).
poss(tryToEat(P),S) :-  philosopher(P), between(P,F1,_), between(_,F2,P), not(F1=F2), has(P,F1,S), has(P,F2,S).

	
/*                   Successor State Axioms                */	

%% write your successor state rules here

available(F,[putDown(_,F)|S]).
available(F,[A|S]):- not(A = pickUp(_,F)), available(F,S).

has(P,F,[pickUp(P,F)|S]).
has(P,F,[A|S]):-not(A=putDown(P,F)), has(P,F,S).

thinking(P,[putDown(P,_)|S]):-waiting(P,S).
thinking(P,[A|S]):-not(A=putDown(P,_)),thinking(P,S).

eating(P,[tryToEat(P)|S]).
eating(P,[A|S]):- eating(P,S).

waiting(P,S):-not thinking(P,S), not eating(P,S).
waiting(P,[pickUp(P,_)|S]):- thinking(P,S).
waiting(P,[putDown(P,_)|S]):-eating(P,S).
waiting(P,[A|S]):-not(A=tryToEat(P)),waiting(P,S).

happy(P,[putDown(P,_)|S]):-eating(P,S).
happy(P,[A|S]):-not(A=putDown(P,_)),happy(P,S). 
/*                  Initial and Goal States                    */

:- [ 'philosophersInit' ].

/* This is to compile the file philosophersInits.pl  before you run a query. 
   Do NOT insert this file here because your program will be tested 
   using different initial and goal states. Both this file and philosophersInit
   must be in the same folder on your computer.
*/

/*             Declarative Heuristics                    */

/* This part is not mandatory. It is only for students who would like
to try solving a bonus questions. Write your declarative heuristics here, 
but save the file as bonus.pl    
*/

member2(N,[N|L]).
member2(N,[M|L]):-member2(N,L).

useless(A,S):-member2(A,S).
useless(putDown(P,_),[pickUp(P,_)|S]).
useless(pickUp(P,_),[putDown(P,_)|S]).

/*
For our declaritive Heuristics, we only had 3 actions so there wasn't a lot of choices to cut down to search time of the application. One thing that was useless was the philosophers
picking up and putting down the same fork so we added two rules for that. This helped speed help the process so it seems to have worked
*/