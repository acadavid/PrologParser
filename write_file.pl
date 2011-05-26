write_file(File) :-
        write('Write your program: '),
        nl,
        tell(File),
        read(X),
        write(X),
        told.

/*** Entrega 2 ***/        

%Reads a file and returs it into Datalist variable
readfile(File,Datalist) :- 
    seeing(Old),
    see(File),  
    processInput([],Datalist),          
    seen,       
    see(Old).
    
parse(File,List) :-
    readfile(File,Datalist),          
    transform(Datalist,List),
    tell('out.pl'),
    out(List),
    told,
    !.          
          
processInput(In,Out):-
   read(Data),
   (Data == end_of_file -> Out = In;         
     processInput([Data|In],Out)).

transform([],[]).
transform([H|T], [[H1|[Equations]]|List]) :- 
    (( arg(1,H,H1),                         % Is a rule
       arg(2,H,T1),
       ((functor(T1,',',_),       
         splitEquations(T1,Equations));     % extrect the equations to a list "Equations"  
         Equations = [T1]) );               % may be there is only one equation
     ( H1 = H, Equations = [] )),           % Is a fact
    transform(T,List).
    
splitEquations(Body,Equations) :-
    (functor(Body,',',_),	    %if this fail, then is the last element in the tuple
    arg(1,Body,E),              % E gets a sinle equation, the first in the tuple
    arg(2,Body,Args),
    splitEquations(Args,Args2),
    append(Args2,[E],Equations));
    Equations = [Body].    

out([]).
out([H|T]):-
    append([regla],H,R),
    X =.. R,
    write(X),
    write('.'),
    nl,
    out(T).

/*** Entrega 3 ***/

nooverlap(File) :-
    readfile(File,Datalist),
    getlhss(Datalist,Lhss, Equations),
    verifyoverlap(Lhss,Equations).

verifyoverlap(_,[]).   
verifyoverlap(Lhss,[H|T]):-
    match(H,Lhss),
    verifyoverlap(Lhss,T).
    
match(_,[]).
match(X,[H|T]) :- match(X,T), ((X = H, write(X), write(' overlaps'),nl);true). 

getlhss([],_,_).
getlhss([H|T],Lhss,Equations):-    
    arg(1,H,Lhs),
    arg(2,H,E),
    getlhss(T,Lhss2,E2),
    append([Lhs],Lhss2,Lhss),
    append(E,E2,Equations).
    
    
    
