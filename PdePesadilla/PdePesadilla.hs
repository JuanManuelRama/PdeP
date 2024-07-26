type Nombre = String

type Recuerdo = String

type Pesadilla = Persona -> Persona

type Excepcion = [Pesadilla] -> Persona -> Bool

data Persona = UnaPersona
  { nombre :: Nombre,
    recuerdos :: [Recuerdo]
  }
  deriving (Show, Eq)

--PESADILLAS
suki :: Persona
suki = UnaPersona "Susana Kitimporta" ["abuelita", "escuela primaria", "examen aprobado", "novio"]

aplicarPesadilla :: ([Recuerdo] -> [Recuerdo]) -> Pesadilla
aplicarPesadilla pesadilla persona = persona {recuerdos = (pesadilla . recuerdos) persona}

pesadillaMovimiento :: Int -> Int -> Pesadilla
pesadillaMovimiento num1 num2 = aplicarPesadilla (movimiento num1 num2)

movimiento :: Int -> Int -> [Recuerdo] -> [Recuerdo]
movimiento num1 num2 recuerdos = take num1 recuerdos ++ [recuerdos !! num2] ++ take (num2 - num1 -1) (drop (num1 + 1) recuerdos) ++ [recuerdos !! num1] ++ take (length recuerdos - num2 -1) (reverse recuerdos)
--movimiento num1 num2 recuerdos = (sustitucion num2 (recuerdos !! num1).sustitucion num1 (recuerdos !! num2)) recuerdos  //No se me occurrió en el parcial

pesadillaSustitucion :: Int -> Recuerdo -> Pesadilla
pesadillaSustitucion posicion = aplicarPesadilla . sustitucion posicion

sustitucion :: Int -> Recuerdo -> [Recuerdo] -> [Recuerdo]
sustitucion posicion recuerdo recuerdos = take posicion recuerdos ++ [recuerdo] ++ drop (posicion + 1) recuerdos

pesadillaDesmemorizar :: Recuerdo -> Pesadilla
pesadillaDesmemorizar = aplicarPesadilla . filter . (/=)

pesadillaEspejo :: Pesadilla
pesadillaEspejo = aplicarPesadilla reverse

pesadillaSuenio :: Pesadilla
pesadillaSuenio = aplicarPesadilla id

noche :: [Pesadilla] -> Pesadilla
noche pesadillas persona = foldr ($) persona pesadillas

pesadillaPdeP :: Pesadilla
pesadillaPdeP = aplicarPesadilla (\a -> a ++ ["haskell", "lazy evaluation", "currificacion", "repeticion logica", "aplicacion parcial", "funcion lambda"])

---- SITUACIONES EXEPCIONALES

detectarExepcion :: Excepcion -> [Pesadilla] -> Persona -> Bool
detectarExepcion exepcion = exepcion

segFault :: Excepcion
segFault pesadillas persona = length pesadillas > (length . recuerdos) persona

bugInicial :: Excepcion
bugInicial pesadillas persona = (head . recuerdos . head pesadillas) persona /= (head . recuerdos) persona

falsaAlarma :: Excepcion
falsaAlarma pesadillas persona = persona == noche pesadillas persona && (any . cambiaRecuerdos) persona pesadillas

--falsaAlarma pesadillas persona = persona == noche pesadillas persona && (any . (\a b -> recuerdos a /= (recuerdos . b) a)) persona pesadillas

cambiaRecuerdos :: Persona -> Pesadilla -> Bool
cambiaRecuerdos persona pesadilla = recuerdos persona /= (recuerdos . pesadilla) persona

cantidadExepciones :: Excepcion -> [Pesadilla] -> [Persona] -> Int
cantidadExepciones exepcion pesadillas = length . filter (detectarExepcion exepcion pesadillas)

todasExepciones :: Excepcion -> [Pesadilla] -> [Persona] -> Bool
todasExepciones exepcion = all . detectarExepcion exepcion

--NOCHE INFINITA
{-
Si una persona pasase una noche con pesadillas infinitas, se podrá evaluar sin ningún problema si ocurrió un bug inicial, ya que simplemente se toma el primer elemento de la lista,
y como haskell realiza una lazy evaluation no le interesa si la misma es infinita o no, solo sabe que debe tomar el primer elemento de ella.
falsaAlarma nuncá podrá dar un resultado, la función consiste de 2 booleanos unidos por un "&&". El que busca si alguno lo modifica (any) podrá dar verdadero, lo que
nos llevará a evaluar el segundo elemento, osea la noche completa, la cual nunca terminará de evaluarse. El any nunca podrá dar falso, ya que tendría que revisar
toda la lista para hacerlo, entonces pase lo que pase la función estará atascada
-}
