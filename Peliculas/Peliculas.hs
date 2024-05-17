import Data.List (intersect)
type Minutos = Int
type Premio = Pelicula->Bool
type Actor = String
data Genero = UnGenero{
    genero :: String,
    participantes :: [Actor]
}

data Pelicula = UnaPelicula{
    titulo :: String,
    elenco :: [Actor],
    duracion :: Minutos,
    anio :: Int
}deriving Show

todosLosActores = [UnGenero "comedia" ["Carrey", "Grint", "Stiller"], UnGenero "accion" ["Stallone", "Willis","Schwarzenegger"], UnGenero "drama" ["De Niro", "Foster"]]

--1

actuoEn :: String->Pelicula->Bool
actuoEn actor pelicula = actor `elem` elenco pelicula

--2

generoPeli :: Pelicula->[Genero]->String
generoPeli _ [x] = genero x
generoPeli pelicula (x:xs)
    |compGenero pelicula x (head xs) = generoPeli pelicula (x:tail xs)
    |otherwise = generoPeli pelicula xs

compGenero :: Pelicula->Genero->Genero->Bool
compGenero peli gen1 gen2 = actGenero peli gen1 > actGenero peli gen2

actGenero :: Pelicula->Genero->Int
actGenero peli genero = length (participantes genero `intersect` elenco peli)

--3

clasicoSetentisa :: Premio
clasicoSetentisa pelicula = ((>=1970).anio) pelicula && ((<=1979).anio) pelicula

plomo :: Premio
plomo = (>180).duracion

tresSonMultitud :: Premio
tresSonMultitud = (==3).length.elenco

nSonMultitud :: Int->Premio
nSonMultitud n = (==n).length.elenco

tituloRaro :: Premio
tituloRaro pelicula =  (head.titulo) pelicula `elem` "¡¿"

--4

festival :: [Premio]->Pelicula->Int
festival premios = length.premiosGanados premios

premiosGanados :: [Premio]->Pelicula->[Premio]
premiosGanados premios pelicula = filter ($ pelicula) premios

--5
--Si una Película tiene infinitos actores, podría recibir premios como títuloRaro, plomo, o clasicoSesentisa, pero no otros como nSonMultitud
--Se podría verificar si un actor actúo en ella, pero si no lo hizo daría error
--No se podria ver su género



