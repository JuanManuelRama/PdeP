maestro(fuego, zuko).
maestro(tierra, toph).
maestro(agua, katara).
maestro(fuego, aang).
maestro(tierra, aang).
maestro(agua, aang).
maestro(aire, Maestro):-movimiento(_, Maestro).
maestro(aire, Maestro):-tieneConexionEspiritual(Maestro).

movimiento(volar, zaheer).
movimiento(patineta, aang).
movimiento(torbellino, tenzin).

tieneConexionEspiritual(bumi).
tieneConexionEspiritual(kai).
tieneConexionEspiritual(marquitos).



tieneDobleMaestria(Maestro):-
    maestro(Elem1, Maestro),
    maestro(Elem2, Maestro),
    Elem1\==Elem2.

manejaNoAgua(Maestro):-
    maestro(_, Maestro),
    not(maestro(agua, Maestro)).

compatriotas(Persona1, Persona2):-
    maestro(Elem, Persona1),
    maestro(Elem, Persona2).