write_file(File) :-
        write('Write your program: '),
        nl,
        tell(File),
        read(X),
        write(X),
        told.
    
browse(File) :- 
        seeing(Old),      /* save for later */ 
        see(File),        /* open this file */ 
        repeat, 
        read(Data),       /* read from File */ 
        process(Data),    
        seen,             /* close File */ 
        see(Old),         /*  previous read source */ 
        !.                /* stop now */ 
 
process(end-of-file) :- !. 
process(Data) :-  write(Data), nl, fail. 
