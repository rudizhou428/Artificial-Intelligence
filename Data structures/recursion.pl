/*Student#		Section#	Name*/
/*500644178 	4			Eric Jaskierski*/
/*500681845 	4			Rudi Zhou*/
/*500748954 	4			Maxim Tolkatchev*/

everyOther([],[]).
everyOther([X],[X]).
everyOther([X|[Y|Z]], [X|B]) :- everyOther(Z,B).

mem(X,[X|Y]).
mem(X,[Y|Z]) :- mem(X,Z).
removeDups([],[]).
removeDups([X|Y],[X|Z]) :- removeDups(Y,Z), not(mem(X,Y)).
removeDups([X|Y],Z) :- mem(X,Y), removeDups(Y,Z).

sameFirstLast([X,X]).
sameFirstLast([X,Y|Z]) :- sameFirstLast([X|Z]).
