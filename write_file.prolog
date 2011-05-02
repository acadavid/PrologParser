write_file(FILE) :-
        write('Write your program: '),
        nl,
        tell(FILE),
        read(X),
        write(X),
        told.
