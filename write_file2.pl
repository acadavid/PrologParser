write_file(File) :-
        write('Write your program: '),
        nl,
        tell(File),
        read(X),
        write(X),
        told.

parse(File,List) :-
          seeing(Old),
          see(File),  
          processInput([],Datalist),          
          seen,       
          see(Old),
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
    (( arg(1,H,H1),                             % Is a rule
       arg(2,H,T1),
       ((functor(T1,',',Arity),       
         splitEquations(T1,Equations));     % extrect the equations to a list "Equations"  
         Equations = [T1]) );                     % may be there is only one equation
     ( H1 = H, Equations = [] )),               % Is a fact
    transform(T,List).
    
splitEquations(Body,Equations) :-
    (functor(Body,',',Arity),	
    arg(1,Body,E),
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
    
