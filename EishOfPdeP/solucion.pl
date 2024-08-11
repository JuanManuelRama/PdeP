%1
jugador(Jugador):-juegaCon(Jugador,_).

civilizacion(Civilizacion):-juegaCon(_, Civilizacion).

tecnologia(Tecnologia):-dependencia(Tecnologia,_).
tecnologia(Tecnologia):-independiente(Tecnologia).

juegaCon(ana,romana).
juegaCon(beto,inca).
juegaCon(carola,romana).
juegaCon(dimitri,romana).

desarrollo(ana,herreria).
desarrollo(ana,forja).
desarrollo(ana,emplumado).
desarrollo(ana,laminas).
desarrollo(beto,herreria).
desarrollo(beto,forja).
desarrollo(beto,fundicion).
desarrollo(carola,herreria).
desarrollo(dimitri,herreria).
desarrollo(dimitri,fundicion).


%2.
expertoEnMetales(Jugador):-
    desarrollo(Jugador,herreria),
    desarrollo(Jugador,forja),
    romanaOFundicion(Jugador).

romanaOFundicion(Jugador):-
    juegaCon(Jugador,romana).
romanaOFundicion(Jugador):-
    desarrollo(Jugador,fundicion).


%3
popular(Civilizacion):-
    juegaCon(Jugador1,Civilizacion),
    juegaCon(Jugador2,Civilizacion),
    Jugador1\=Jugador2.


%4.
alcanceGlobal(Tecnologia):-
    tecnologia(Tecnologia),
    forall(jugador(Jugador),desarrollo(Jugador,Tecnologia)).

%5.
esLider(Civilizacion):-
    civilizacion(Civilizacion),
    forall(desarrollo(_, Tecnologia),seUsaEn(Tecnologia,Civilizacion)).

seUsaEn(Tecnologia,Civilizacion):-
    juegaCon(Jugador,Civilizacion),
    desarrollo(Jugador,Tecnologia).

%6
tropa(Tropa):-vida(Tropa, _).

ejercito(ana, [jinete(caballo), piquero(con, 1), piquero(sin, 2)]).
ejercito(beto, [campeon(100), campeon(80), piquero(con, 1), jinete(camello)]).
ejercito(carola, [piquero(sin, 3), piquero(con, 2)]).


%7
vida(jinete(caballo), 90).
vida(jinete(camello), 80).

vida(piquero(sin, 1), 50).
vida(piquero(sin, 2), 65).
vida(piquero(sin, 3), 70).

vida(piquero(con, Nivel), Vida):-
    vida(piquero(sin, Nivel), VidaBase),
    Vida is VidaBase * 1.1.

vida(campeon(Nivel), Nivel):-between(0, 100, Nivel).

tropaMasViva(Jugador, Tropa):-
    ejercito(Jugador,ListaUnidades),
    member(Tropa, ListaUnidades),
    forall(member(X, ListaUnidades), mayorOSiMismo(Tropa, X)).

mayorOSiMismo(X, X).
mayorOSiMismo(Tropa1, Tropa2):-tieneMasVida(Tropa1, Tropa2).

tieneMasVida(Tropa1, Tropa2):-    
    vida(Tropa1, Vida1),
    vida(Tropa2, Vida2),
    Vida1 > Vida2.


%8
tieneAfinidad(jinete(_), campeon(_)).
tieneAfinidad(campeon(_), piquero(_, _)).
tieneAfinidad(piquero(_, _), jinete(_)).
tieneAfinidad(jinete(camello), jinete(caballo)).

gana(Tropa1,Tropa2):-
    tropa(Tropa1),
    tropa(Tropa2),
    tieneAfinidad(Tropa1,Tropa2).
gana(Tropa1, Tropa2):-
    tropa(Tropa1),
    tropa(Tropa2),
    not(tieneAfinidad(Tropa2,Tropa1)),
    tieneMasVida(Tropa1,Tropa2).


%9
sobreviveAsedio(Jugador):-
    ejercito(Jugador,ListaUnidades),
    cantidadDeUnidad(ListaUnidades, piquero(sin, _), CantSinEscudo),
    cantidadDeUnidad(ListaUnidades, piquero(con, _), CantConEscudo),
    CantConEscudo > CantSinEscudo.

cantidadDeUnidad(ListaUnidades, Tipo, Cantidad):-
    findall(_, member(Tipo, ListaUnidades), Lista),
    length(Lista, Cantidad).


%10
independiente(herreria).
independiente(molino). 

dependencia(emplumado, herreria).
dependencia(laminas, herreria).
dependencia(forja, herreria).
dependencia(fundicion, forja).
dependencia(punzon, emplumado).
dependencia(malla, laminas).
dependencia(horno, fundicion).
dependencia(placas, malla).
dependencia(collera, molino).
dependencia(arado, collera).

dependenciaTransitiva(A,B):-dependencia(A,B).
dependenciaTransitiva(A,B):-
    dependencia(A,C),
    dependenciaTransitiva(C,B).

puedeDesarrollar(Jugador, Tecnologia):-
    jugador(Jugador),
    tecnologia(Tecnologia),
    not(desarrollo(Jugador, Tecnologia)),
    forall(dependenciaTransitiva(Tecnologia, Dependencia), desarrollo(Jugador, Dependencia)).


%11
ordenValido(Jugador, ListaOrdenada):-
    jugador(Jugador),
    findall(Tecnologia, desarrollo(Jugador, Tecnologia), ListaDeTecnologias),
    ordenar(ListaDeTecnologias, ListaOrdenada).

ordenar(Lista, ListaOrdenada):-
    permutation(Lista, ListaOrdenada),
    estaOrdenada(ListaOrdenada).

estaOrdenada([]).
estaOrdenada([X|Xs]):-
    respetaLaDependencia(X, Xs),
    estaOrdenada(Xs).
    
respetaLaDependencia(_, []).
respetaLaDependencia(X, [Y|Ys]):-
    not(dependenciaTransitiva(X, Y)),
    respetaLaDependencia(X, Ys).


%12
ejercitoParaGanar(EjercitoAtacante, JugadorDefensor):-
    ejercito(JugadorDefensor, EjercitoDefensor),
    ataqueExitoso(EjercitoAtacante, EjercitoDefensor).

ataqueExitoso([],[]).
ataqueExitoso([Atacante|Atacantes],[Defensor|Defensores]):-
    gana(Atacante,Defensor),
    ataqueExitoso(Atacantes,Defensores).
