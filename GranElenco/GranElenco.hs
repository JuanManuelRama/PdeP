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


elenco :: [Persona]->Elenco
elenco personas  = UnElenco  (cond2 personas) (cond3 personas) 

cond2 :: [Persona]->Bool
cond2 personas = length personas - cantVillanos personas 0 >5


cantVillanos :: [Persona]->Int->Int
cantVillanos personas cantVil
    |null personas = cantVil
    |esVillano (head personas) = cantVillanos (drop 1 personas) (cantVil+1)
    |not (esVillano (head personas)) = cantVillanos (drop 1 personas) cantVil


cond3 :: [Persona]->Bool
cond3 personas = cantExperiencia personas 0 >2

cantExperiencia :: [Persona]->Int->Int
cantExperiencia personas cantExp
    |null personas = cantExp
    |tieneExperiencia (head personas) = cantExperiencia (drop 1 personas) (cantExp+1)
    |not (tieneExperiencia (head personas)) = cantExperiencia (drop 1 personas) cantExp

tieneExperiencia :: Persona->Bool
tieneExperiencia (UnaPersona _ _ actuaciones) = experiencia actuaciones 4