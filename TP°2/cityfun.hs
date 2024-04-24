type Atraccion = String;
type ValorCiudad = Int
type Nombre = String
type Anio = Int
type CantLetras = Int
type CostoVida = Int
type Incremento = Int

data Ciudad = UnaCiudad {
    nombre :: Nombre,
    anioDeFundacion :: Anio,
    atracciones :: [Atraccion],
    costoDeVida :: CostoVida
}deriving Show

----- Punto Uno ---------

valorDeUnaCiudad :: Ciudad -> ValorCiudad
valorDeUnaCiudad ciudad
    | anioDeFundacion ciudad < 1800 = 5 * (1800 - anioDeFundacion ciudad)
    | null (atracciones ciudad) = 2 * costoDeVida ciudad
    | otherwise = 3 * costoDeVida ciudad

------- Punto dos ------

-- FUNCION TIENE ATRACCION COPADA

tieneAtraccionCopada :: Ciudad -> Bool
tieneAtraccionCopada ciudad = any esCopada (atracciones ciudad)

esCopada :: Atraccion -> Bool
esCopada atraccion = esVocal (head atraccion)

esVocal :: Char -> Bool
esVocal 'A' = True
esVocal 'E' = True
esVocal 'I' = True
esVocal 'O' = True
esVocal 'U' = True
esVocal  x  = False

-- FUNCION ES SOBRIA

esSobria :: Ciudad -> CantLetras -> Bool
esSobria ciudad cantLetras  = all (sobria cantLetras) (atracciones ciudad)

sobria :: CantLetras -> Atraccion -> Bool
sobria cantLetras atraccion = length atraccion > cantLetras

-- FUNCION NOMBRE RARO
nombreRaro :: Ciudad -> Bool
nombreRaro ciudad = length (nombre ciudad) < 5

---------- Punto tres ----------

calcularPorcentaje :: CostoVida -> Int -> Int
calcularPorcentaje costoVida porcentajePorCien = costoVida + div (costoVida  * porcentajePorCien) 100

-- FUNCION NUEVA ATRACCION

nuevaAtraccion :: Ciudad -> Atraccion -> Ciudad
nuevaAtraccion ciudad atraccion = ciudad { atracciones = atracciones ciudad ++ [atraccion], costoDeVida = calcularPorcentaje(costoDeVida ciudad) 20}

-- FUNCION CRISIS

crisis :: Ciudad -> Ciudad
crisis ciudad = ciudad {atracciones = sublistaSinElUltimoElemento (atracciones ciudad), costoDeVida = calcularPorcentaje (costoDeVida ciudad) (-10) }

sublistaSinElUltimoElemento :: [Atraccion] -> [Atraccion]
sublistaSinElUltimoElemento atracciones = take (length atracciones - 1) atracciones

-- FUNCION REMODELACION

remodelacion :: Ciudad -> Incremento -> Ciudad
remodelacion ciudad incremento = ciudad{nombre = "New " ++ nombre ciudad, costoDeVida= calcularPorcentaje (costoDeVida ciudad) incremento}

-- FUNCION REEVALUCION

reevaluacion :: Ciudad -> CantLetras -> Ciudad
reevaluacion ciudad cantLetras
    | esSobria ciudad cantLetras = ciudad { costoDeVida = calcularPorcentaje (costoDeVida ciudad) 10 }
    | otherwise = ciudad {costoDeVida = calcularPorcentaje (costoDeVida ciudad) (-3)}

---------- Punto cuatro ----------

transformacionCiudad :: Ciudad -> CantLetras -> Incremento -> Ciudad
transformacionCiudad ciudad cantLetras incremento = reevaluacion(crisis(remodelacion ciudad incremento)) cantLetras