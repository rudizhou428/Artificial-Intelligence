/*500644178 Eric Jaskierski
500681845 Rudi Zhou
500748954 Maxim Tolkatchev
*/

/*hasBook(Bookstore, Author, Title, ListProce)
	the Bookstore sells a book with the Title written by the Author for the ListPrice
*/

hasBook(indigo, levesque, abcs, 4.99).
hasBook(indigo, levesque, thinking_as_computation, 9.99).
hasBook(indigo, levesque, artificial_intelligence_a_modern_approach, 1.99).
hasBook(indigo, rowling, harry_potter, 666).
hasBook(indigo, martin, a_dance_with_dragons, 4.99).
hasBook(amazon, levesque, abcs, 4.99).
hasBook(amazon, levesque, thinking_as_computation, 8.99).
hasBook(amazon, levesque, computational_intelligence, 44.99).
hasBook(amazon, levesque, artificial_intelligence_a_modern_approach, 14.99).
hasBook(amazon, rowling, harry_potter, 110).
hasBook(amazon, russell, fml, 101).
hasBook(blue, poole, poop, 30).
hasBook(blue, poole, asd, 234).
hasBook(blue, russell, zxc, 737).
hasBook(blue, russell, fml, 666).

/*lives(Person,City) – the Person lives in the City*/
lives(levesque, tokyo).
lives(rowling, london).
lives(kys, newYork).
lives(martin, paris).
lives(walker, istanbul).
lives(galera, tianjin).
lives(meng, lagos).
lives(kaisar, beijing).
lives(russell, venice).
lives(poole, toronto).

/*shipping(Bookstore,City,Cost) – the shipping cost from the Bookstore to the City is the Cost.*/
shipping(indigo, toronto, 7).
shipping(indigo, tokyo, 23).
shipping(indigo, shanghai, 32).
shipping(indigo, london, 17).
shipping(indigo, warsaw, 19).
shipping(amazon, toronto, 1).
shipping(amazon, tokyo, 42).
shipping(amazon, shanghai, 4).
shipping(amazon, london, 11).
shipping(amazon, warsaw, 21).

bookstore(indigo).
bookstore(amazon).
bookstore(blue).

author(levesque). author(rowling). author(martin). author(poole). author(russell).

title(abcs). title(thinking_as_computation). title(computational_intelligence). 
title(artificial_intelligence_a_modern_approach). title(harry_potter).
title(a_dance_with_dragons). title(asd). title(zxc). title(fml). title(poop).

listPrice(4.99). listPrice(9.99). listPrice(1.99). listPrice(6.66). listPrice(8.99). listPrice(44.99).
listPrice(14.99). listPrice(101). listPrice(234). listPrice(737). listPrice(666). listPrice(30).
listPrice(110).

person(levesque). person(rowling). person(kys). person(martin). person(walker). 
person(galera). person(meng). person(kaisar). person(russell). person(poole).

city(tokyo). city(london). city(newYork). city(paris). city(istanbul). city(tianjin).
city(lagos). city(beijing). city(venice). city(kyoto).
city(toronto). city(shanghai). city(warsaw).

cost(7). cost(23). cost(32). cost(17). cost(19).
cost(1). cost(42). cost(4). cost(11). cost(21).

article(a).
article(an).

common_noun(city,X):-city(X).
common_noun(person,X):-person(X).
common_noun(author,X):-person(X), author(X).
common_noun(bookstore,X):-bookstore(X).
common_noun(book,X):-title(X).
common_noun(title,X):-title(X).
common_noun(shipping,X):-cost(X).
common_noun(price,X):-listPrice(X).
common_noun(price,X):-cost(X).
common_noun(Title, Title) :- hasBook(Bookstore,Author,Title,Price).

preposition(from,X,Y):-lives(X,Y).
preposition(from,X,Y):-hasBook(Y,Author,X,Price).
preposition(from,X,Y):-shipping(Y,B,X).
preposition(of,X,Y):-hasBook(Bookstore,Author,Y,X).
preposition(of,X,Y):-hasBook(Bookstore,X,Y,Price).
preposition(of,X,Y):-hasBook(Bookstore,Author,Y,X).
preposition(at,X,Y):-hasBook(Y,Author,X,Price).
preposition(at,X,Y):-hasBook(Y,X,Title,Price).
preposition(with,X,Y):-shipping(X,City,Y).
preposition(with,X,Y):-hasBook(X,Author,Y,Cost).
preposition(with,X,Y):-hasBook(Bookstore,Author,X,Y).
preposition(to,X,Y):-shipping(X,City,Y).
preposition(to,X,Y):-shipping(Store,Y,X).
preposition(by,X,Y):-hasBook(Bookstore,Y,X,Cost).
preposition(for,X,Y):-hasBook(X,Author,Title,Y).

proper_noun(X):-bookstore(X).
proper_noun(X):-author(X).
proper_noun(X):-title(X).
proper_noun(X):-person(X).
proper_noun(X):-city(X).
proper_noun(X):-listPrice(X).
proper_noun(X):-cost(X).

adjective(cheap,X) :- hasBook(A,B,X,Y),listPrice(Y), Y =< 50.
adjective(expensive,X) :- hasBook(A,B,X,Y),listPrice(Y), Y >= 100.
adjective(expensive,Y) :- listPrice(Y), Y >= 100.
adjective(high,X) :- hasBook(X,B,C,Y),listPrice(Y), Y >= 100.
adjective(high,Y) :- listPrice(Y), Y >= 100.
adjective(high,X) :- shipping(Store,X,Y), cost(Y), Y > 6.
adjective(high,Y) :- cost(Y), Y > 6.
adjective(low,X) :- hasBook(X,B,C,Y),listPrice(Y), Y =< 50.
adjective(low,X) :- listPrice(X), X =< 50.
adjective(low,X) :- cost(X), X < 2.
adjective(moderate,X) :- cost(X), X >= 2, X =< 6.

who(Words,Ref) :- np(Words,Ref), person(Ref).
what(Words,Ref) :- np(Words,Ref), not person(Ref).
np([Name],Name) :- proper_noun(Name).
np([the|Rest],Who) :-
	np2(Rest,Who), not((np2(Rest,Who2), not Who = Who2)).
np([Art|Rest],Who) :-
	article(Art), not (Art = the), np2(Rest,Who).
np2([Name],Name) :- proper_noun(Name).
np2([Adj|Rest],Who) :-
	adjective(Adj,Who), np2(Rest,Who).
np2([Noun|Rest],Who) :-
	common_noun(Noun,Who), mods(Rest,Who).
mods([],_).
mods(Words,Who) :-
	append2(Start,End,Words),
	pp(Start,Who),
	mods(End,Who). 
pp([Prep|Rest],Who) :-
	preposition(Prep,Who,Who2), np(Rest,Who2).
append2([],X,X).
append2([H|T],X,[H|Y]) :- append2(T,X,Y).


