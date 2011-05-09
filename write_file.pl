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
          process([],List),
          seen,       
          see(Old),   
          !.          
          
process(In,Out):-
   read(Data),
   (Data == end_of_file -> Out = In;
    process([Data|In],Out)).
