type Cambio = Personaje->Personaje
type Material = String

data Personaje = UnPersonaje {
   nombre :: String,
    puntaje:: Int,
    inventario:: [Material]
} deriving (Show)

data Receta = UnaReceta{
    nombreO :: Material,
    tiempo :: Int,
    requisitos :: [Material]
}

rFogata :: Receta
rFogata = UnaReceta "Fogata" 10 ["Madera", "Fosforo"]
rPolloAsado :: Receta
rPolloAsado = UnaReceta "Pollo Asado"  300 ["Fogata", "Pollo"]


craftear :: Receta->Cambio
craftear receta personaje
    |puedeCrafter personaje receta  = (quitarMateriales receta.crafteroExito receta.aniadirObjeto receta) personaje
    |otherwise = crafteoFracaso personaje




aniadirObjeto:: Receta->Cambio
aniadirObjeto receta personaje = personaje{inventario = nombreO receta : inventario personaje}

quitarMateriales::Receta->Cambio
quitarMateriales receta personaje = personaje{inventario = craftear1 (inventario personaje) (requisitos receta)}


craftear1 :: Ord a => [a] -> [a] -> [a]
craftear1 [] _ = []
craftear1 lista [] = lista
craftear1 x  (y:ys)
    |x==y = craftear1 xs ys
    |otherwise = craftear1 (xs++[x]) [y]++ys




{-quitarMateriales::[Materiales]->[Materiales]->[Materiales]
quitarMateriales [] [_] = []
quitarMateriales x [] = x
quitarMateriales (x:xs) (y:ys)
    |x==y = quitarMateriales xs ys
    |otherwise quitarMateriales-}

cambiarPuntos :: Int->Cambio
cambiarPuntos aumento personaje = personaje{puntaje = puntaje personaje + aumento}

crafteroExito :: Receta->Cambio
crafteroExito receta = cambiarPuntos (10*tiempo receta)

crafteoFracaso :: Cambio
crafteoFracaso = cambiarPuntos (-100)



puedeCrafter::Personaje->Receta->Bool
puedeCrafter personaje receta = all (tieneMaterial (inventario personaje)) (requisitos receta)

tieneMaterial :: [Material]->Material->Bool
tieneMaterial materiales material = material `elem` materiales


