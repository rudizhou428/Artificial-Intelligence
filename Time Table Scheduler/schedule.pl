/*Student#              Section#        Name*/
/*500644178     4                       Eric Jaskierski*/
/*500681845     4                       Rudi Zhou*/
/*500748954     4                       Maxim Tolkatchev*/




class_time(Day) :-
        memberIn(Day,[11,12,13,14]).


memberIn(X, [X|Tail]).
memberIn(X, [Head|Tail]):- memberIn(X,Tail).


print_solution :-
	solve([Csc199,Mat101,Mat120,Mat140,Csc108,Csc148,Phl250]),
	write('The date for the CSC199 exam is December, '), write(Csc199),nl,
	write('The date for the MAT101 exam is December, '),write(Mat101),nl,
	write('The date for the MAT120 exam is December, '),write(Mat120),nl,
	write('The date for the MAT140 exam is December, '),write(Mat140),nl,
	write('The date for the CSC108 exam is December, '),write(Csc108),nl,
	write('The date for the CSC148 exam is December, '),write(Csc148),nl,
	write('The date for the PHL250 exam is December, '),write(Phl250),nl.
	


solve([Csc199,Mat101,Mat120,Mat140,Csc108,Csc148,Phl250]) :-

		class_time(Phl250), not (Phl250 = 12), not (Phl250 = 13), not (Phl250 = 14),
		class_time(Mat101),not(Mat101 = Phl250),class_time(Mat120),
	    ((Mat101-1) < Mat120),
		class_time(Mat140),  not(Mat140 = 14), 
		(Mat120 < Mat140),
		class_time(Csc108),not(Csc108 = Mat140), class_time(Csc148),not(Csc148 = Mat140),
		(Csc108 < Csc148),
		class_time(Csc199), not(Csc199 = Mat140),  not(Csc199 = Csc108), not(Csc199 = Csc148) ,not(Csc199 = Mat101),not(Csc199 = Mat120),not(Csc199 = Phl250), 
		(Csc148 < Csc199).
		
		
		
		
		
        
	
        
