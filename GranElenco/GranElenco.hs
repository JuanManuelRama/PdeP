import Distribution.Simple.Setup (trueArg)
type Pelicula=String

data Actuacion = UnaActuacion{
    pelicula :: Pelicula,
    valoracion :: Int
}deriving Show

data Persona = UnaPersona{
    nombre :: String,
    recibioOscar :: Bool,
    actuaciones :: [Actuacion]
}deriving Show

data Elenco = UnElenco{
    heroes :: Bool,
    villanos :: Bool,
    experiencias :: Bool
}deriving Show


joker :: Actuacion
joker = UnaActuacion "Joker" 4

joaquin :: Persona
joaquin = UnaPersona "Joaquin Phoenix" True [joker]

peliculasPremiadas :: Pelicula->Bool
peliculasPremiadas "LOTR"  = True
peliculasPremiadas "Joker" = True
peliculasPremiadas "EEAAO" = True
peliculasPremiadas x = False


primeraFila :: Persona->Bool
primeraFila (UnaPersona _ oscar actuaciones) = ultPeliBuena actuaciones || oscar || experiencia actuaciones 1

ultPeliBuena :: [Actuacion]->Bool
ultPeliBuena actuacion
    |valorPeli (last actuacion)>=3 = True
    |otherwise = False

valorPeli :: Actuacion->Int
valorPeli (UnaActuacion _ valoracion) = valoracion


experiencia :: [Actuacion]->Int->Bool
experiencia filmografia cantPel
    |length filmografia >cantPel = True
    |otherwise = False

cancelado :: Persona->String->Persona
cancelado alguien "racismo" = alguien{recibioOscar=False}
cancelado alguien "xenofobia" = alguien{recibioOscar=False}
cancelado alguien "homofobia" = alguien{recibioOscar=False}
cancelado alguien x = alguien


esVillano :: Persona->Bool
esVillano (UnaPersona _ _ actuaciones)
    |length actuaciones>1 = villano actuaciones
    |otherwise = False

villano :: [Actuacion]->Bool
villano actuaciones
    |length actuaciones>1 && ultPeliBuena actuaciones = villano (drop 1 actuaciones)
    |not (ultPeliBuena actuaciones) = False
    |ultPeliBuena actuaciones = True

esHeroe :: Persona->Bool
esHeroe (UnaPersona _ oscar filmografia) = oscar && not (oscarFilmografia filmografia)    

oscarFilmografia :: [Actuacion]->Bool
oscarFilmografia filmografia
    |null filmografia= False
    |oscarPeli (head filmografia) = True
    |not (oscarPeli (head filmografia) ) = oscarFilmografia (drop 1 filmografia)


oscarPeli :: Actuacion->Bool    
oscarPeli (UnaActuacion peli _) = peliculasPremiadas peli




elenco :: [Persona]->Elenco
elenco personas  = UnElenco (cond1 personas)  (cond2 personas) (cond3 personas) 

cond1 :: [Persona]->Bool
cond1 personas = cantHeroes personas >3

cantHeroes :: [Persona]->Int
cantHeroes personas = length (filter esHeroe personas)

cond2 :: [Persona]->Bool
cond2 personas = length personas - cantVillanos personas >5


cantVillanos :: [Persona]->Int
cantVillanos personas = length (filter esVillano personas)


cond3 :: [Persona]->Bool
cond3 personas = cantExperiencia personas >2

cantExperiencia :: [Persona]->Int
cantExperiencia personas = length (filter tieneExperiencia personas)

tieneExperiencia :: Persona->Bool
tieneExperiencia (UnaPersona _ _ actuaciones) = experiencia actuaciones 4

cond4 :: [Persona]->Bool
cond4 personas = (cantHeroes personas + cantVillanos personas) >=5