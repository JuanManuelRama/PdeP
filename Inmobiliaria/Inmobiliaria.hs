type Barrio = String
type Mail = String
type Requisito = Depto -> Bool
type Busqueda = [Requisito]
type Criterio = Depto->Depto->Bool
data Depto = Depto {
 ambientes :: Int,
 superficie :: Int,
 precio :: Int,
 barrio :: Barrio
} deriving (Show, Eq)

data Persona = Persona {
   mail :: Mail,
   busquedas :: [Busqueda]
}

ordenarSegun _ [] = []
ordenarSegun criterio (x:xs) =
 (ordenarSegun criterio . filter (not . criterio x)) xs ++
 [x] ++
 (ordenarSegun criterio . filter (criterio x)) xs

between cotaInferior cotaSuperior valor =
 valor <= cotaSuperior && valor >= cotaInferior

deptosDeEjemplo = [
 Depto 3 80 7500 "Palermo",
 Depto 1 45 3500 "Villa Urquiza",
 Depto 2 50 5000 "Palermo",
 Depto 1 45 5500 "Recoleta"]


mayor :: Ord a => (t -> a) -> t -> t -> Bool
mayor funcion val1 val2 = funcion val1 > funcion val2
menor :: Ord a => (t -> a) -> t -> t -> Bool
menor funcion val1 val2 = funcion val1 < funcion val2
--ordenarSegun (mayor (+2)) [12, 1, 4]

ubicadoEn :: [Barrio]->Requisito
ubicadoEn barrios depto =  barrio depto `elem` barrios

cumpleRango :: (Depto->Int)->Int->Int->Requisito
cumpleRango funcion cota1 cota2 depto = entre cota1 cota2 (funcion depto)

entre :: Int->Int->Int->Bool
entre cota1 cota2 valor
    |cota1 > cota2 = valor<=cota1 && valor>=cota2
    |cota2 > cota1 = valor<=cota2 && valor>=cota1

cumpleBusqueda :: Busqueda->Depto->Bool
cumpleBusqueda requisitos depto = all ($ depto) requisitos


filtrarDeptos :: Busqueda->[Depto]->[Depto]
filtrarDeptos requisitos = filter (cumpleBusqueda requisitos)


buscar :: Busqueda->Criterio->[Depto]->[Depto]
buscar requisitos criterio = ordenarSegun criterio.filtrarDeptos requisitos

criterioSuperficie :: Criterio
criterioSuperficie = mayor superficie

mailsDePersonasInteresadas :: Depto->[Persona]->[Mail]
mailsDePersonasInteresadas depto persona = map mail (filter (estaInteresada depto) persona)

estaInteresada :: Depto->Persona->Bool
estaInteresada depto persona = any (`cumpleBusqueda` depto) (busquedas persona)

