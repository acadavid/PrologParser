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

transform([H|[]], [[H1|[T1]]]) :-
    /*functor(H, Functor, Arity),*/
    arg(1,H,H1),
    arg(2,H,T1).

transform([H|T], [[H1|[T1]]|List]) :-
    /*functor(H, Functor, Arity),*/    
    arg(1,H,H1),
    arg(2,H,T1),
    transform(T,List).

