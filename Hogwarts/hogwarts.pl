%Base de Conocimiento
casa(gryffindor).
casa(slytherin).
casa(ravenclaw).
casa(hufflepuff).

importante(gryffindor, coraje).
importante(slytherin, orgullo).
importante(slytherin, inteligencia).
importante(ravenclaw, inteligencia).
importante(ravenclaw, responsabilidad).
importante(hufflepuff, aimstad).

mago(Mago):-esDe(Mago, _).

sangre(harry, mestiza).
sangre(draco, pura).
sangre(hermione, impura).

caracter(harry, coraje).
caracter(harry, orgullo).
caracter(harry, inteligencia).
caracter(hermione, inteligencia).
caracter(hermione, orgullo).
caracter(hermione, responsabilidad).
caracter(draco, inteligencia).
caracter(draco, orgullo).

odia(harry, slytherin).
odia(draco, hufflepuff).


%1
permite(Casa, Mago):-
    mago(Mago),
    casa(Casa),
    Casa\=slytherin.
permite(slytherin, Mago):-sangre(Mago, pura).

%2
caracterApropiado(Mago, Casa):-
    mago(Mago),
    casa(Casa),
    forall(importante(Casa, Caracter), caracter(Mago, Caracter)).

%3
casaPosible(Mago, Casa):-
    permite(Casa, Mago),
    caracterApropiado(Mago, Casa),
    not(odia(Mago, Casa)).

%4
cadenaDeAmistades(Amistad):-
    forall(member(X, Amistad), caracter(X, aimstad)),
    cadenaCasa(Amistad).

cadenaCasa([]).
cadenaCasa([X,Y|Xs]):-
    casaPosible(X, Casa),
    casaPosible(Y, Casa),
    cadenaCasa([Y|Xs]).

%Segunda Parte

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

prohibido(bosque, -50).
prohibido(bibliotecaRestringida, -10).
prohibido(tercerPiso, -75).

accion(harry, noCama).
accion(hermione, tercerPiso).
accion(hermione, bibliotecaRestringida).
accion(harry, bosque).
accion(harry, tercerPiso).
accion(draco, mazmorras).
accion(ron, ajedrez).
accion(hermione, salvarAmigos).
accion(harry, voldemort).
accion(hermione, pregunta(encontrarBezoar, 20, snape)).
accion(hermione, pregunta(levantarPluma, 25, flickwick)).


consecuencia(ajedrez, 50).
consecuencia(salvarAmigos, 50).
consecuencia(voldemort, 60).
consecuencia(noCama, -50).
consecuencia(Lugar, Puntaje):-prohibido(Lugar, Puntaje).
consecuencia(pregunta(_, Dificultad, Profesor), Dificultad):-Profesor\=snape.
consecuencia(pregunta(_, Dificultad, snape), Puntaje):-Puntaje is Dificultad/2.

buenaAccion(Accion):-
    consecuencia(Accion, Puntaje),
    Puntaje>0.
%1
buenAlumno(Mago):-
    mago(Mago),
    accion(Mago, Accion),
    buenaAccion(Accion),
    forall(accion(Mago, Acciones), buenaAccion(Acciones)).

accionRecurrente(Accion):-
    accion(Mago1, Accion),
    accion(Mago2, Accion),
    Mago1\=Mago2.

%2
puntajeCasa(Casa, Puntaje):-
    casa(Casa),
    findall(Puntos, (esDe(Mago, Casa), accion(Mago, Accion), consecuencia(Accion, Puntos)), ListaPuntajes),
    sum_list(ListaPuntajes, Puntaje).

%3    
casaGanadora(Casa):-
    puntajeCasa(Casa, Puntaje),
    forall(puntajeCasa(_, OtroPuntaje), Puntaje>=OtroPuntaje).
