import Data.List
data Material = UnMaterial{
    mat :: String,
    cantidad :: Int,
    demora :: Int,
    requisitos :: [Material]
} deriving (Show, Eq)
data Personaje = UnPersonaje {
   nombre :: String,
    puntaje:: Int,
    inventario:: [Material]
} deriving (Show)

craftear :: Personaje->Material->Personaje
craftear personaje objeto
    |tieneMateriales personaje objeto = cambiarPuntos.sumarMaterial.quitarMaterial


tieneMateriales :: Personaje->Material->Bool
tieneMateriales personaje material = not (null (inventario personaje `intersect` requisitos material))

sumarMaterial :: Personaje->Material->Personaje
sumarMaterial personaje material = personaje {inventario = material:inventario personaje}

cambiarPuntos :: Personaje->Int->Personaje
cambiarPuntos personaje incremento = personaje {puntaje = puntaje personaje + incremento}


quitarMaterial :: Personaje->[Material]->Personaje
quitarMaterial personaje [] = personaje
quitarMaterial personaje (x:xs) = quitarMaterial