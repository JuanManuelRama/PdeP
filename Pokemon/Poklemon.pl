%Juan Manuel Rama
%1
pokemon(Pokemon):-tipo(Pokemon, _).
esTipo(Tipo):-tipo(_, Tipo).

tipo(pikachu, electrico).
tipo(squirtle, agua).
tipo(charizard, fuego).
tipo(blastoise, agua).
tipo(venasaur, planta).

tiene(ash, pikachu).
tiene(ash, charizard).
tiene(brock, squirtle).

tipoComun(Tipo):-
    tipo(Pokemon, Tipo),
    tipo(OtroPokemon, Tipo),
    Pokemon\=OtroPokemon.

pokemonLibre(Pokemon):-
    pokemon(Pokemon),
    not(tiene(_, Pokemon)).

tieneTodosLosTipos(Entrenador):-
    tiene(Entrenador, _),
    forall(esTipo(Tipo), tieneEseTipo(Entrenador, Tipo)).

tieneEseTipo(Entrenador, Tipo):-
    tiene(Entrenador, Pokemon),
    tipo(Pokemon, Tipo).


%2
conoce(pikachu, trueno).
conoce(pikachu, ataqueRapido).
conoce(charizard, lanzallamas).
conoce(charizard, cuchillada).
conoce(blastoise, ataqueRapido).
conoce(blastoise, carambano).
conoce(venasaur, rayoSolar).
conoce(venasaur, cuchillada).


movimiento(trueno, especial(primera, 75)).
movimiento(ataqueRapido, encadenado([1, 29, 39, 12 ,23])).
movimiento(lanzallamas, especial(tercera, 120)).
movimiento(cuchillada, fisico(25)).
movimiento(carambano, encadenado([80, 10, 1])).
movimiento(rayoSolar, especial(segunda, 120)).

incrementoGeneracional(primera, 10).
incrementoGeneracional(segunda, -20).
incrementoGeneracional(tercera, 50).
incrementoGeneracional(Generacion, 0):-
    Generacion\=primera,
    Generacion\=segunda,
    Generacion\=tercera.

potenciaCaracteristica(fisico(Potencia), Potencia).
potenciaCaracteristica(encadenado(ListaPotencias), Potencia):-
    sumlist(ListaPotencias, Sumatoria),
    length(ListaPotencias, Longitud),
    Potencia is Sumatoria/Longitud.
potenciaCaracteristica(especial(Generacion, PotenciaInicial), Potencia):-
    incrementoGeneracional(Generacion, Incremento),
    Potencia is PotenciaInicial + (PotenciaInicial*Incremento)/100.

potencia(Movimiento, Potencia):-
    movimiento(Movimiento, Caracteristicas),
    potenciaCaracteristica(Caracteristicas, Potencia).

peligroso(Movimiento):-
    potencia(Movimiento, Potencia),
    Potencia>100.

peligrosidad(Pokemon, Peligrosidad):-
    pokemon(Pokemon),
    findall(_,(conoce(Pokemon, Movimiento), peligroso(Movimiento)), MovimientosPeligrosos),
    length(MovimientosPeligrosos, Peligrosidad).


%3
fuerte(planta, agua).
fuerte(fuego, planta).
fuerte(agua, fuego).
fuerte(fuego, electrico).

fortaleza(Pokemon, OtroPokemon, Fortaleza):-
    tipo(Pokemon, Tipo),
    tipo(OtroPokemon, OtroTipo),
    fortalezaTipo(Tipo, OtroTipo, Fortaleza).

fortalezaTipo(Tipo, OtroTipo, fuerte):-fuerte(Tipo, OtroTipo).
fortalezaTipo(Tipo, OtroTipo, debil):-fuerte(OtroTipo, Tipo).
fortalezaTipo(Tipo, OtroTipo, neutro):-
    not(fuerte(Tipo, OtroTipo)),
    not(fuerte(OtroTipo, Tipo)).

prepararMovimiento(Pokemon, Potencia):-
    conoce(Pokemon, Movimiento),
    potencia(Movimiento, Potencia).

tieneMasPotencia(Potencia, OtraPotencia, fuerte):-Potencia*2>OtraPotencia.
tieneMasPotencia(Potencia, OtraPotencia, debil):-Potencia>2*OtraPotencia.
tieneMasPotencia(Potencia, OtraPotencia, neutro):-Potencia>OtraPotencia.

tieneChancesDeGanar(Pokemon, OtroPokemon):-
    tiene(_, Pokemon),
    tiene(_, OtroPokemon),
    fortaleza(Pokemon, OtroPokemon, Fortaleza),
    prepararMovimiento(Pokemon, Potencia),
    prepararMovimiento(OtroPokemon, OtraPotencia),
    tieneMasPotencia(Potencia, OtraPotencia, Fortaleza).
