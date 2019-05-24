/*Student#		Section#	Name*/
/*500644178 	4			Eric Jaskierski*/
/*500681845 	4			Rudi Zhou*/
/*500748954 	4			Maxim Tolkatchev*/

setHieght(A,B,H) :- A > B, H is A.
setHieght(A,B,H) :- A < B, H is B.
setHieght(A,B,H) :- A = B, H is B.


checkIfLessThantTwoSubFunction(F,B,Result):- F = 0, B = 0, Result is 0.
checkIfLessThantTwoSubFunction(F,B,Result):- (F-B < 0), Result is (F-B)-(F-B)-(F-B).
checkIfLessThantTwoSubFunction(F,B,Result):- (F-B > 0), Result is (F-B).
checkIfLessThantTwoSubFunction(F,B,Result):- F=B, Result is 0.

checkIfLessThantTwo(A,B) :- checkIfLessThantTwoSubFunction(A,B,Result), Result =< 1.


avl(Tree) :-checkHeight(Tree,H).

checkHeight(void,0).
checkHeight(tree(Element,Left,Right),H) :- checkHeight(Left,H1), checkHeight(Right,H2),checkIfLessThantTwo(H1,H2),setHieght(H1,H2,J), H is (J + 1).

