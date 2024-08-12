%Base de Conocimiento
costo(sarmiento, 100).
costo(esquel, 150).
costo(pehuenia, 180).
costo(sanMartin, 150).
costo(camarones, 135).
costo(playasDoradas, 170).
costo(bariloche, 140).
costo(calafate, 240).
costo(bolson, 145).
costo(marDelPlata, 140).

atraccion(esquiel, parque(alceres)).
atraccion(esquiel, excurcion(trochita)).
atraccion(esquiel, excurcion(trevelin)).
atraccion(pehuenia, cerro(bateaMahuida, 2000)).
atraccion(pehuenia, cuerpoAgua(si, 14)).
atraccion(pehuenia, cuerpoAgua(si, 19)).

%1
persona(Persona):-destino(Persona, _).
destino(dodian, pehuenia).
destino(dodian, sanMartin).
destino(dodian, esquel).
destino(dodian, sarmiento).
destino(dodian, camarones).
destino(dodian, playasDoradas).
destino(alf, bariloche).
destino(alf, sanMartin).
destino(alf, bolson).
destino(nico, marDelPlata).
destino(vale, calafate).
destino(vale, bolson).
destino(martu, Destino):-destino(nico, Destino).
destino(martu, Destino):-destino(alf, Destino).



copado(cerro(_, Altura)):-Altura>2000.
copado(cuerpoAgua(si, Temperatura)):-Temperatura>20.
copado(playa(Dif)):-Dif>5.
copado(excurcion(Nombre)):-
    name(Nombre, Longitud),
    Longitud>7.
copado(parque(_)).

%2
vacacionCopada(Persona):-
    persona(Persona),
    forall(destino(Persona, Destino), tieneAtraccionCopada(Destino)).

tieneAtraccionCopada(Destino):-
    atraccion(Destino, Atraccion),
    copado(Atraccion).

%3
noSeCruzaron(Persona1, Persona2):-
    persona(Persona1),
    persona(Persona2),
    forall(destino(Persona1, Destino), not(destino(Persona2, Destino))).

%4
vacacionesGasoleras(Persona):-
    persona(Persona),
    forall(destino(Persona, Destino), destinoGasolero(Destino)).

destinoGasolero(Destino):-
    costo(Destino, Costo),
    Costo<160.

%5
itinerariosPosibles(Persona, Itinerario):-
    persona(Persona),
    findall(Destino, destino(Persona, Destino), Destinos),
    permutation(Destinos, Itinerario).
