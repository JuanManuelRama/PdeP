import Data.List (intersect)
import Control.Monad(replicateM)
type Transformacion = Animal->Animal
type Criterio = Animal->Bool
type Experimento = [Transformacion]
data Animal = UnAnimal{
    iq :: Int,
    especie :: String,
    capacidades :: [String]
}deriving Show

dante :: Animal
dante = UnAnimal 100 "elefante" ["vuela"]

perez :: Animal
perez = UnAnimal 101 "raton" ["Intolerante a la lactosa"]

pinky :: Animal
pinky = UnAnimal 61 "pinky" ["hacer na", "hacer dfa", "vuela"]

labRat = UnAnimal 17 "raton" ["destruenglonir el mundo", "hacer planes desalmados"]

inteligenciaSuperior :: Int->Transformacion
inteligenciaSuperior exponente animal = animal{iq = ((^exponente).iq) animal}

pinkificar :: Transformacion
pinkificar animal = animal{capacidades = []}

superpoderes :: Transformacion
superpoderes (UnAnimal iq "Elefante" capacidades) = UnAnimal iq "Elefante" ("no tenerle miedo a los ratones":capacidades)
superpoderes (UnAnimal iq "Raton" capacidades)
    |iq>100 = UnAnimal iq "Raton" ("hablar":capacidades)
    |otherwise = UnAnimal iq "Raton" capacidades
superpoderes animal = animal

antropomorfico :: Criterio
antropomorfico animal = habla animal && inteligente animal

habla :: Criterio
habla (UnAnimal _ _ capacidades) = "habla" `elem` capacidades


inteligente :: Criterio
inteligente (UnAnimal iq _ _) = iq>60

noTanCuerdo :: Criterio
noTanCuerdo (UnAnimal _ _ capacidades) = (length.filter pinkiesco) capacidades > 4

pinkiesco :: String->Bool
pinkiesco capacidad = (esHacer.take 5) capacidad && (esPinkiesco.drop 6) capacidad

esHacer :: String -> Bool
esHacer "hacer" = True
esHacer _ = False

esPinkiesco :: Foldable t => t Char -> Bool
esPinkiesco sonido = length sonido <= 4 && any esVocal sonido

esVocal :: Char -> Bool
esVocal letra = letra `elem` "AEIOUaeiouáéíóúÁÉÍÓÚ"


experimentoExitoso ::  Experimento -> Animal -> Criterio -> Bool
experimentoExitoso experimento animal criterio = (criterio.aplicarExperimento experimento) animal

aplicarExperimento :: Experimento->Transformacion
aplicarExperimento transformaciones animal = foldr ($) animal transformaciones

ejemplo :: Bool
ejemplo = experimentoExitoso [pinkificar, inteligenciaSuperior 10, superpoderes] labRat antropomorfico

reporte :: (Animal->a)->[Animal]->[String]->Experimento->[a]
reporte campo animales capacidades experimento = map campo ((tienenCapacidades capacidades.todosExperimentan animales) experimento)

tienenCapacidades ::  [String] -> [Animal] -> [Animal]
tienenCapacidades requisitos = filter (tieneCapacidades requisitos)

tieneCapacidades :: [String]->Animal->Bool
tieneCapacidades requisitos (UnAnimal _ _ capacidades)  = length (capacidades `intersect` requisitos) >= length requisitos


todosExperimentan :: [Animal]->Experimento->[Animal]
todosExperimentan animales experimento = map (aplicarExperimento experimento) animales
reporteIq :: [Animal] -> [String] -> Experimento -> [Int]
reporteIq = reporte iq

reporteEspecie :: [Animal] -> [String] -> Experimento -> [String]
reporteEspecie = reporte especie

reporteCantCapacidades :: [Animal] -> [String] -> Experimento -> [Int]
reporteCantCapacidades = reporte (length.capacidades)

{-
Una animal con capacidades infinitas podrá recibir transformaciones que no las afctern como inteligenciaSuperior,
Plankificar remplaza la lista sin revisarla por lo que no genera ningún problemma, y superpoderés a veces podrá
ya que añade adelante de todo,  dependerá de como esté armada la lista infinita, si tiene primer elemnto será posible
El criterio de antropomorfó podrá ser aplicado siempre y tenga la habilidad "hablar", ya que de no serlo lo buscará
hasta el infinito. noTanCuerdo no puede ser aplicado, ya que analiza toda la lista, por lo que se colgará

-}

listaPinkiesca :: [String]
listaPinkiesca = (generarPinkificaciones.wordsUpto ) 4 ++ (generarPinkificaciones.generateWords) 4
generarPinkificaciones :: [String] -> [String]
generarPinkificaciones funcion = map ("hacer " ++) (filter esPinkiesco funcion)

wordsUpto :: Int -> [String]
wordsUpto num = ["a", "aa", "aaa"]
                                        ---Funciones representativas, no encontré las del enunciado
generateWords :: Int -> [String]
generateWords num = ["aaa", "aaaa"]
