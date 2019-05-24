  /* Iterative deepening situations and fluents based planner from CPS721 */
  
/*Student#		Section#	Name*/
/*500644178 	4			Eric Jaskierski*/
/*500681845 	4			Rudi Zhou*/
/*500748954 	4			Maxim Tolkatchev*/
		
:- dynamic clean/2.
:- dynamic wet/2.
:- dynamic folded/2.
:- dynamic holding/2.
:- dynamic hasSoap/2.
:- dynamic hasSoftener/2.
:- dynamic hasLint/2.
:- dynamic in/3.

/* These rules say that the rules with a predicate can be not consecutive in 
   your program. The number "2" (or "3") is the arity of your fluent.
*/

% We are looking for a list of actions represented by a variable Plan
% such that executing actions in Plan leads from the initial state
% to a reachable state where a goal condition is true.

solve_problem(Bound,Plan)  :-  C0 is cputime,     % C0 is time when program starts %
          max_length(Plan,Bound),          % Bound is the maximal length of Plan   %
          reachable(S,Plan),
          goal_state(S),           % A situation S must be a solution of the problem %
          Cf is cputime, Diff is Cf - C0, nl,     % Cf is time when program finishes  %
          write('Elapsed time (sec): '), write(Diff), nl.

max_length([],N) :- N >= 0.
max_length([First | L],N1) :- N1 > 0, N is N1 - 1, max_length(L,N).

reachable(S,[]) :- initial_state(S).

/* The following rule is for the simplest instances of your planning domain.
   Use it when you debug your precondition and other rules and
   when you test whether your program can solve easy planning problems. 
   Comment it out, when solving planning problems with heuristics. Instead, 
   use the other rule provided below.
*/
%reachable(S2, [M | List]) :- reachable(S1,List), legal_move(S2,M,S1).

/* Recall that situation argument S is the list of previously executed actions.
   In the list [Move | S], Move represents the most recent action.      */

/*The following rule uses declarative heuristics to cut search: remove comments
   and write your rules to implement the predicate useless(M,List) (see below).
   You can use this when solving more complex instances in the planning domain.
   Note that the predicate "useless(M,S)" is the only innovation with respect 
   to clauses in the Problem Solving section, page 11.

reachable(S2, [M | ListOfPastActions]) :- reachable(S1,ListOfPastActions),
                    legal_move(S2,M,S1),
                    not useless(M,ListOfPastActions).
*/

reachable(S2, [M | ListOfPastActions]) :- reachable(S1,ListOfPastActions),
                    legal_move(S2,M,S1),
                    not useless(M,ListOfPastActions).
/* The following 2 clauses are from the Problem Solving section, page 31. */

legal_move([A|S], A, S) :- poss(A,S).
initial_state([]).

        	/* Precondition axioms */
/* 
Write precondition axioms for all actions in your domain. Recall that to avoid
potential problems with negation in Prolog, you should not start bodies of your
rules with negated predicates. Make sure that all variables in a predicate 
are instantiated by constants before you apply negation to the predicate that 
mentions these variables. 
*/
% write your precondition rules here: you have to provide brief comments %

container(dresser).
container(X) :- washer(X).
container(X) :- dryer(X).
container(X) :- cupboard(X).
container(X) :- hamper(X).

poss(fetch(O,C),S) :- cupboard(C), in(O,C,S), not(holding(_,S)).
poss(putAway(O,C),S) :- cupboard(C), not in(O,C,S), holding(_,S).
poss(addSoap(X,Y),S) :- soap(X), washer(Y), holding(X,S), not hasSoap(Y,S).
poss(addSoftener(X,Y),S) :- softener(X), washer(Y), holding(X,S), not hasSoftener(Y,S).
poss(removeLint(X),S) :- dryer(X), hasLint(X,S).
poss(washClothes(C,W),S) :- clothes(C), washer(W), in(C,W,S), not clean(C,S), hasSoap(W,S), hasSoftener(W,S).
poss(dryClothes(C,D),S) :- clothes(C), dryer(D), in(C,D,S), wet(C,S), not hasLint(D,S).
poss(fold(X),S) :- clothes(X), not folded(X,S), clean(X,S), not wet(X,S), not holding(_,S).
poss(wear(X),S) :- clothes(X), folded(X,S).
poss(move(C,F,T),S) :- clothes(C), container(F), in(C,F,S), container(T), not(F=T), not holding(X,S).

/* For the precondition rules we first added the container to get the values needed from laundryInit for things such as the dresser,washer,dryer, etc.
Next we added the precondition rules. Fetch needs to have the object in cupboard and not holding any thing after action is completed.
putAway was basically the same as fetch except you swapped the object being in the cupboard and you are holding something after action is completed.
addSoap and add Softener were also similar and it required either soap or softener, a washer, holding onto an object, and no longer holding the soap or softener after action was completed.
For the removeLint action it required just a dryer and a link so only 2 predicates were needed. washClothes and dryClothes were created in a similar manner except washClothes required a washer
while dryClothes required a dryer also washClothes required that clothes were not clean and soap + softener and dryClothes needed wet clothing + removing any lint.
For the action fold, it required clothes that were not already folded, were cleaned, and not wet which was fairly simple to create. The action wear was even more simple to create as it only needed
clothes that were folded. The final action move required clothes that were in a container and then were moved to a different container and the two containers could obviously not be the same.
*/

	

        	/* Successor state axioms */
/* 
Write successor-state axioms that characterize how the truth value of all 
fluents change from the current situation S to the next situation [A | S]. 
You will need two types of rules for each fluent: 
	(a) rules that characterize when a fluent becomes true in the next situation 
	as a result of the last action, and
	(b) rules that characterize when a fluent remains true in the next situation,
	unless the most recent action changes it to false.
When you write successor state axioms, you can sometimes start bodies of rules 
with negation of a predicate, e.g., with negation of equality. This can help 
to make them a bit more efficient.
*/
% write your successor state rules here: you have to write brief comments %

in(O,C,[putAway(O,C)|S]).
in(O,C,[move(O,_,C)|S]).
in(O,C,[A|S]) :- not (A = fetch(O,C)), not (A=move(O,C,_)), in(O,C,S).

holding(O,[fetch(O,_)|S]).
holding(O,[A|S]) :- not(A=putAway(O,_)), not (A=addSoap(O,_)), not(A=addSoftener(O,_)), holding(O,S).

hasSoap(W,[addSoap(_,W)|S]).
hasSoap(W,[A|S]) :- not (A=washClothes(_,W)), hasSoap(X,S).

hasSoftener(W,[addSoftener(_,W)|S]).
hasSoftener(W,[A|S]) :- not (A=washClothes(_,W)), hasSoftener(W,S).

hasLint(X,[dryClothes(_,X)|S]).
hasLint(X,[A|S]) :- not(A=removeLint(X)), hasLint(X,S).

clean(X,[washClothes(X,_)|S]).
clean(X,[A|S]) :- not(A=wear(X)), clean(X,S).

wet(C,[washClothes(C,_)|S]).
wet(C, [A|S]) :- not (A=dryClothes(C,_)), wet(X,S).

folded(X,[fold(X)|S]).
folded(X,[A|S]) :- not(A=wear(X)), folded(X,S).

/* For the SSA's the fluent in is successful when the previous action is putting away clothes or moving it, it was not sucessfull when fetching moving or aalready being inside the same container.
fluent holding is successful when last action is fetching the clothes, it is not successful when action is putting away clothing, that already has either soap or softener.
fluent hasSoap is successful when last action is adding soap, it is not successful when action is trying to wash clothes that already have soap added.
fluent hasSoftener is successful when last action is adding softener to washer, it is not successful when action is trying to wash clothes that already have softener added.
fluent hasLint is successful when last action is drying clothes and is not successful when action is removing lint from dryer that already has lint added.
fluent clean is successful when last action is washing clothes and is not successful when action is wearing already clean clothes.
fluent folded is successful when last action is folding the clothes and is not successful when action is wearing already folded clothing.
*/

	/* ---------- Heuristics To Cut Search ------------- */
/* The predicate useless(A,ListOfPastActions) is true if an action A is useless
given the list of previously performed actions. The predicate useless(A,ListOfPastActions)
helps to solve the planning problem by providing declarative heuristics to 
the planner. If this predicate is correctly defined using a few rules, then it 
helps to speed-up the search that your program is doing to find a list of actions
that solves a planning problem. Write as many rules that define this predicate
as you can: think about useless repetitions you would like to avoid, and about 
order of execution (i.e., use common sense properties of the application domain). 
Your rules have to be general enough to be applicable to any problem in your domain,
in other words, they have to help in solving a planning problem for any instance
(i.e., any initial and goal states).
*/	
% write your rules implementing the predicate  useless(Action,History) here. %

member2(N,[N|L]).
member2(N,[M|L]):-member2(N,L).

useless(fetch(X,_),[putAway(X,_)|S]).
useless(A,[putAway(X,_)|S]):- A=fetch(X,_), useless(A,S).
useless(putAway(X,_),[fetch(X,_)|S]).
useless(A,[fetch(X,_)|S]):- A=putAway(X,_), useless(A,S).
useless(move(_,_,_),[move(_,_,_)|S]).
useless(A,[move(X,T,F)|S]):- A=move(X,F,T), useless(A,S).
useless(A,S):-member2(A,S).

/* for our Heuristics, we figured there were some useless actions that shouldn't be done depending on previous actions. Those were fetching clothing and last action was puting the same clothing beforehand, 
the opposite of putting away and fetching. The other useless action was moving clothing multiple times, it's pretty useless or stupid to move the clothings to various different containers, you only
really need to do it once and then that accomplishes what you need the laundry robot to do
*/

:- [laundryInit].
/* This last line compiles also the file laundryInit.pl  that should be in same
   directory as this file. Do NOT insert this file here because it will be easier
   for you to test different initial and goal states if they are defined
   in a different file. Recall that the initial state is defined by a set of
   atomic statements about the values of the fluents wrt [] that represents 
   the initial situation in PROLOG. Recall also that the goal state is defined
   by rules with the predicate  goal_state(S)  in the head, and the body of 
   the rules should say what should be true or false in the goal state S.  
*/