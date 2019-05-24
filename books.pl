/*500644178 Eric Jaskierski
500681845 Rudi Zhou
 500748954 Maxim Tolkatchev
*/


/*hasBook(Bookstore, Author, Title, ListProce) the Bookstore sells a book with 
the Title written by the Author for the ListPrice 
*/

hasBook(indigo, levesque, abcs, 4.99).
hasBook(indigo, levesque, 'Thinking as Computation', 9.99).
hasBook(indigo, levesque, 'Artificial Intelligence: A Modern Approach', 1.99).
hasBook(indigo, rowling, 'harry potter', 6.66).
hasBook(indigo, martin, 'a dance with dragons', 4.99).
hasBook(amazon, levesque, abcs, 4.99).
hasBook(amazon, levesque, 'Thinking as Computation', 8.99).
hasBook(amazon, levesque, 'Computational Intelligence', 44.99).
hasBook(amazon, levesque, 'Artificial Intelligence: A Modern Approach', 14.99).
hasBook(amazon, rowling, 'harry potter', 7.77).
hasBook(blue, kys, 'asd', 234).
hasBook(blue, kys, 'zxc', 737).
hasBook(blue, kys, 'fml', 666).

/*lives(Person,City) – the Person lives in the City*/
lives(levesque, tokyo).
lives(rowling, london).
lives(kys, newyork).

/*shipping(Bookstore,City,Cost) – the shipping cost from the Bookstore to the City is the Cost.*/
shipping(indigo, toronto, 2).
shipping(indigo, tokyo, 23).
shipping(indigo, shanghai, 32).
shipping(indigo, london, 17).
shipping(indigo, warsaw, 19).
shipping(amazon, toronto, 1).
shipping(amazon, tokyo, 42).
shipping(amazon, shanghai, 4).
shipping(amazon, london, 11).
shipping(amazon, warsaw, 21).