type Cargo=String
type Horas=Int
type Antiguedad=Int
type Sueldo=Float
type Porcentaje=Float
type Familia=Int


cayoEnPobreza :: Horas->Cargo->Antiguedad->Familia->String
cayoEnPobreza horas cargo antiguedad familia
    |aumentoSueldo (calcSueldo horas cargo antiguedad)-inflacionCanastaBasica (canastaBasica familia)<0 = "Esta " ++ show (inflacionCanastaBasica (canastaBasica familia)-aumentoSueldo (calcSueldo horas cargo antiguedad)) ++ " bajo la linea de pobreza"
    |aumentoSueldo (calcSueldo horas cargo antiguedad)-inflacionCanastaBasica (canastaBasica familia)>=0 = "Está " ++ show(aumentoSueldo (calcSueldo horas cargo antiguedad)-inflacionCanastaBasica (canastaBasica familia)) ++ " sobre la linea de pobreza"

--cayoEnPobreza :: Sueldo->Familia->String
--cayoEnPobreza sueldo familia
  --  |aumentoSueldo sueldo-inflacionCanastaBasica(canastaBasica familia)>0

canastaBasica :: Familia->Sueldo
canastaBasica 1 = 126000
canastaBasica 3 = 310000
canastaBasica 4 = 390000
canastaBasica 5 = 410000
canastaBasica x = error "No se conoce el valor de esa canásta básica"


calcSueldo :: Horas->Cargo->Antiguedad->Sueldo
calcSueldo horas cargo antiguedad = basico cargo * bonAntiguedad antiguedad * bonHoras horas


basico :: Cargo->Float
basico "titular"=149000
basico "adjunto"=116000
basico "ayudante"=66000
basico x = error "No es un cargo"


bonAntiguedad :: Antiguedad->Float
bonAntiguedad antiguedad
    |antiguedad <3  = porcentaje 10
    |antiguedad <5  = porcentaje 20
    |antiguedad <10 = porcentaje 30
    |antiguedad <24 = porcentaje 50
    |antiguedad >24 = porcentaje 120

porcentaje :: Float->Porcentaje
porcentaje x = (x/100)+1


bonHoras :: Horas->Float
bonHoras horas
    |horas<5 || horas>50 = error "No se puede haber trabajado esa cantidad de horas"
    |otherwise = fromIntegral (redondearUnidad horas) / 10


redondearUnidad :: Int->Int
redondearUnidad x
    |truncDecena x >=5 = x+(10-truncDecena x)
    |otherwise = x-truncDecena x

truncDecena :: Int->Int
truncDecena x = mod x 10

inflacionCanastaBasica :: Sueldo->Sueldo
inflacionCanastaBasica sueldo = sueldo * porcentaje 71

aumentoSueldo :: Sueldo->Sueldo
aumentoSueldo sueldo = sueldo * porcentaje 22