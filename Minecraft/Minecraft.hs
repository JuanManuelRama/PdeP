type Cambio = Personaje->Personaje
type Material = String
type Herramienta = [Material]->Material

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
data Bioma = UnBioma{
    loot :: [Material],
    requisito :: Material
}

rFogata :: Receta
rFogata = UnaReceta "Fogata" 10 ["Madera", "Fosforo"]
rPolloAsado :: Receta
rPolloAsado = UnaReceta "Pollo Asado"  300 ["Fogata", "Pollo"]

hacha :: Herramienta
hacha = last
espada :: Herramienta
espada = head
pico ::Int->Herramienta
pico n = (!! n)
artico :: Bioma
artico = UnBioma ["Hielo", "Iglu", "Lobo"] "Sueter"



granCambio :: Personaje->[Cambio]->Personaje
granCambio = foldr ($)

craftear :: Receta->Cambio
craftear receta personaje
    |puedeCraftear personaje receta  = granCambio personaje [(aniadirObjeto.nombreO) receta, crafteroExito receta, quitarMateriales receta]
    |otherwise = cambiarPuntos (-100) personaje




aniadirObjeto:: Material->Cambio
aniadirObjeto objeto personaje = personaje{inventario = objeto : inventario personaje}

quitarMateriales::Receta->Cambio
quitarMateriales receta personaje = personaje{inventario = foldl quitarMaterial (inventario personaje) (requisitos receta)}



quitarMaterial :: [Material]->Material->[Material]
quitarMaterial (primero:resto) requisito
    |primero==requisito = resto
    |otherwise = quitarMaterial (resto++[primero]) requisito

cambiarPuntos :: Int->Cambio
cambiarPuntos aumento personaje = personaje{puntaje = puntaje personaje + aumento}

crafteroExito :: Receta->Cambio
crafteroExito receta = cambiarPuntos (10*tiempo receta)


puedeCraftear::Personaje->Receta->Bool
puedeCraftear personaje receta = all (tieneMaterial (inventario personaje)) (requisitos receta)

tieneMaterial :: [Material]->Material->Bool
tieneMaterial materiales material = material `elem` materiales


quePuedeCraftear :: Personaje->[Receta]->[Receta]
quePuedeCraftear personaje = filter  (puedeYDuplica personaje)

puedeYDuplica :: Personaje -> Receta -> Bool
puedeYDuplica personaje receta = puedeCraftear personaje receta && duplicaPuntaje personaje receta

duplicaPuntaje :: Personaje->Receta->Bool
duplicaPuntaje personaje receta = (puntaje.crafteroExito receta) personaje > 2* puntaje personaje

multiCrafteo :: [Receta]->Cambio
multiCrafteo recetas personaje = foldr craftear personaje recetas

mejorOInverso :: Personaje->[Receta]->Bool
mejorOInverso personaje recetas = (puntaje.multiCrafteo recetas) personaje > (puntaje.multiCrafteo (reverse recetas)) personaje

minar:: Herramienta->Bioma->Cambio
minar herramienta bioma personaje
     |puedeMinar personaje bioma = granCambio personaje [cambiarPuntos 50, (aniadirObjeto.herramienta.loot) bioma]
     |otherwise = personaje

puedeMinar :: Personaje -> Bioma -> Bool
puedeMinar personaje = (tieneMaterial.inventario) personaje.requisito