type Atraccion = String
type ValorCiudad = Int
type Nombre = String
type Anio = Int
type CantLetras = Int
type CostoVida = Int
type Incremento = Int
type Evento = Ciudad->Ciudad
type Criterio = Ciudad->Evento->Bool

data Ciudad = UnaCiudad {
    nombre :: Nombre,
    anioDeFundacion :: Anio,
    atracciones :: [Atraccion],
    costoDeVida :: CostoVida
}deriving Show

data Year = UnAnio{
    numero :: Anio,
    eventos :: [Evento]
}

anio2023 = UnAnio 2023 [crisis, nuevaAtraccion "Parque", remodelacion 10, remodelacion 20]
anio2021 = UnAnio 2021 [crisis, nuevaAtraccion "Playa"]
anio2022 = UnAnio 2022 [crisis, remodelacion 5, reevaluacion 7]

----- Punto Uno ---------

valorDeUnaCiudad :: Ciudad -> ValorCiudad
valorDeUnaCiudad ciudad
    | anioDeFundacion ciudad < 1800 = 5 * (1800 - anioDeFundacion ciudad)
    | null (atracciones ciudad) = 2 * costoDeVida ciudad
    | otherwise = 3 * costoDeVida ciudad

------- Punto dos ------

-- FUNCION TIENE ATRACCION COPADA

tieneAtraccionCopada :: Ciudad -> Bool
tieneAtraccionCopada = any esCopada.atracciones

esCopada :: Atraccion -> Bool
esCopada = esVocal.head

esVocal :: Char -> Bool
esVocal letra = letra `elem` "AEIOUÁÉÍÓÚ"

-- FUNCION ES SOBRIA

esSobria :: Ciudad -> CantLetras -> Bool
esSobria ciudad cantLetras  = (all (sobria cantLetras).atracciones) ciudad

sobria :: CantLetras -> Atraccion -> Bool
sobria cantLetras atraccion = length atraccion > cantLetras

-- FUNCION NOMBRE RARO

nombreRaro :: Ciudad -> Bool
nombreRaro = (<5).length.nombre

---------- Punto tres ----------

calcularCostoVida :: Incremento -> Evento
calcularCostoVida incremento ciudad = ciudad {costoDeVida = (calcularPorcentaje.costoDeVida) ciudad incremento}

calcularPorcentaje :: CostoVida -> Int -> CostoVida
calcularPorcentaje costoVida porcentajePorCien = costoVida + div (costoVida  * porcentajePorCien) 100

-- FUNCION NUEVA ATRACCION

nuevaAtraccion :: Atraccion -> Evento
nuevaAtraccion atraccion  = calcularCostoVida 20 . agregarAtraccion atraccion

agregarAtraccion :: Atraccion -> Evento
agregarAtraccion atraccion ciudad = ciudad {atracciones = atraccion : atracciones ciudad}

-- FUNCION CRISIS

crisis :: Evento
crisis = calcularCostoVida (-10).sacarUltimaAtraccion

sacarUltimaAtraccion :: Evento
sacarUltimaAtraccion ciudad = ciudad {atracciones = (init.atracciones) ciudad}

-- FUNCION REMODELACION

agregarNewAlNombre:: Evento
agregarNewAlNombre ciudad = ciudad {nombre = "New " ++ nombre ciudad}

remodelacion :: Incremento -> Evento
remodelacion incremento = calcularCostoVida incremento.agregarNewAlNombre

-- FUNCION REEVALUACION

reevaluacion :: CantLetras -> Evento
reevaluacion cantLetras ciudad
    | esSobria ciudad cantLetras = calcularCostoVida 10 ciudad
    | otherwise = calcularCostoVida (-3) ciudad

---------- Punto cuatro ----------

transformacionCiudad :: Incremento -> CantLetras -> Evento
transformacionCiudad incremento cantLetras  = reevaluacion cantLetras.crisis.remodelacion incremento

--SEGUNDA ENTREGA >>

---------- Punto cuatro ----------

-- FUNCION PASO TIEMPO

pasoTiempo :: Ciudad -> Year -> Ciudad
pasoTiempo ciudad = aplicarListaEventos ciudad.eventos
aplicarListaEventos :: Ciudad->[Evento]->Ciudad
aplicarListaEventos = foldr ($)


-- FUNCION ALGO MEJOR
algoMejor :: Ord a => Ciudad -> (Ciudad -> a) -> Evento -> Bool
algoMejor ciudad criterio evento = (criterio.evento) ciudad > criterio ciudad




-- FUNCION AUMENTA COSTO 

filtrarYAplicarAnio :: Ord a =>(Ciudad -> a) -> Ciudad -> Year -> Ciudad
filtrarYAplicarAnio criterio ciudad = aplicarListaEventos ciudad . (filter (algoMejor ciudad criterio).eventos)

aumentarCosto :: Ciudad -> Year -> Ciudad
aumentarCosto = filtrarYAplicarAnio costoDeVida


--FUNCION DISMINUIR COSTO

disminuirCosto :: Ciudad -> Year -> Ciudad
disminuirCosto = filtrarYAplicarAnio (negate.costoDeVida)


-- FUNCION AUMENTAR VALOR

aumentarValor :: Ciudad -> Year-> Ciudad
aumentarValor = filtrarYAplicarAnio valorDeUnaCiudad

------ Punto 5 ------
listaOrdenada :: [Ciudad]->Bool
listaOrdenada [ciudad] = True
listaOrdenada (ciudad:ciudades) = costoDeVida ciudad > (costoDeVida.head) ciudades

--5.1

eventosOrdenados :: Ciudad->Year->Bool
eventosOrdenados ciudad = listaOrdenada.map ($ ciudad).eventos


--5.2

ciudadOrdenada :: Evento -> [Ciudad] -> Bool
ciudadOrdenada evento = listaOrdenada.map evento


--5.3

aniosOrdenados :: Ciudad->[Year]->Bool
aniosOrdenados ciudad = listaOrdenada.map (pasoTiempo ciudad)


------------------------ Punto 6 ----------------------

anio2024 :: Year
anio2024 = UnAnio 2024 (cycle [remodelacion 10, crisis, nuevaAtraccion "Bicicenda"])

{-6.1
Si puede haber, dará falso si los eventos no están ordenados, pero si lo están seguirá hasta el infinito. Esto es posible
ya que Haskell implementa una Lazy Evaluation, osea que solo evalúa lo estrictamente necesario. En el caso de este punto
 solo sabe que necesita separar el primer elemento de la misma (x) y el resto (xs). Luego opera con (x), un elemento
y (head xs), un elemento de posición finita, para finalmente utilizar ese mismo resto, tambiém de tamaño infinito, para 
la la invocación recursiva. Este proceso lo repetirá  hasta encontrar un falso, o el infinito si nunca lo encuentra
-}{-6.2
Si queremos ver si una ciudad está ordenada con el evento n de la lista, se podrá ver ya que cuando a Haskell le pedimos
el n-ésimo elemento de una lista, solo generará este, sin importarle los que estén antes o después
-}
{-6.3
Podría dar falso si los años anteriores a 2024 no están ordenados (suponinendo que estos no son infinitos), o si es 
el único elemento de la lista, pero si llegase a tener que aplicar pasoTiempo con 2024 se cuelga ya que, si la 
lista de eventos a aplicar es infinita, nuncá terminará de aplicarlos
-}
