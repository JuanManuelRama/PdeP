type Actor = String
type Minutos = Int
type Premio = Pelicula->Bool
data Pelicula = UnaPelicula{
    titulo :: String,
    elenco :: [Actor],
    duracion :: Minutos,
    anio :: Int
}deriving Show

todosLosActores = [("comedia", ["Carrey", "Grint", "Stiller"]),("accion", ["Stallone", "Willis","Schwarzenegger"]), ("drama", ["De Niro", "Foster"])]

--1

actuoEn :: String->Pelicula->Bool
actuoEn actor pelicula = actor `elem` elenco pelicula

--2



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



