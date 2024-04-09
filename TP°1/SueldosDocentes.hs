type Cargo=String
type Horas=Int
type Antiguedad=Int
type Sueldo=Float
type Porcentaje=Float


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
   -- |otherwise = fromIntegral (redondearUnidad horas) / 10
   |horas<15 = 1
   |horas<25 = 2
   |horas<35 = 3
   |horas<45 = 4
   |horas<=50 =5

redondearUnidad :: Int->Int
redondearUnidad x 
    |truncDecena x >=5 = x+(10-truncDecena x)    
    |otherwise = x-truncDecena x

truncDecena :: Int->Int
truncDecena x = mod x 10