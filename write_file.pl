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
          !.          
          
processInput(In,Out):-
   read(Data),
   (Data == end_of_file -> Out = In;         
     processInput([Data|In],Out)).

transform([H|[]], [[H1|Equations]]) :-
    ( arg(1,H,H1),
      arg(2,H,T1),
      ((functor(T1,',',Arity),
      splitEquations(T1,Arity,Equations));Equations = [T1]));
    ( H1 = [H], Equations = [] ).   
    

transform([H|T], [[H1|Equations]|List]) :- 
    (( arg(1,H,H1),
      arg(2,H,T1),
      ((functor(T1,',',Arity),
      splitEquations(T1,Arity,Equations));Equations = [T1]));
    ( H1 = [H], Equations = [] )),
      transform(T,List).
    
splitEquations(_,0,[]).
splitEquations(Body,N,Equations) :-
    arg(N,Body,E), %Each equation is extracted to E
    N1 is N-1,
    splitEquations(Body,N1,Args),
    append(Args,[E],Equations).    
        
    
