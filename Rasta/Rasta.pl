enAula(rasta).
enAula(polito).
enAula(santi).

ayuda(rasta, Persona):-
    enAula(Persona),
    quiere(rasta, Persona),
    not(compararSuerte(rasta, Persona)).

quiere(santi, Persona):- not(quiere(rasta, Persona)).

quiere(rasta, Persona):-
    enAula(Persona),
    Persona\==santi.

quiere(polito, Persona) :-quiere(rasta, Persona).

compararSuerte(rasta, Persona):-quiere(polito, Persona).


