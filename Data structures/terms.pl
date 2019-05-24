/*Student#		Section#	Name*/
/*500644178 	4			Eric Jaskierski*/
/*500681845 	4			Rudi Zhou*/
/*500748954 	4			Maxim Tolkatchev*/

next(Head, nil).
next(Head,next(Head2,Tail)):-next(Head2,Tail).

appendT(nil,Term2,Term2).
appendT(next(Head,Tail),Term2,next(Head,Tail2)):-appendT(Tail,Term2,Tail2).

list2term([], nil).
list2term([Head | Tail], next(Head,Tail2)) :- atom(Head), list2term(Tail,Tail2).
list2term([Head| Tail], next(Term, Term2)):- list2term(Head, Term), list2term(Tail, Term2), appendT(Term, Term2, Tail2).

flat(nil,nil).
flat(next(Head,Tail),next(Head,Tail2)):-atom(Head),flat(Tail,Tail2).
flat(next(Head,Tail),Term):-flat(Head,Term2),flat(Tail,Term3),appendT(Term2,Term3,Term).
