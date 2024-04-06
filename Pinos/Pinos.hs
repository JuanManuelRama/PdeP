type Altura=Float
type Peso=Float

pesoPino :: Altura->Peso
pesoPino  altura
    | altura <=3 = altura*300
    | otherwise = 3*300+(altura-3)*200 
esPesoUtil :: Peso->Bool
esPesoUtil peso
    | peso>400 && peso<1000 = True
    | otherwise = False

sirvePino :: Altura->Bool
sirvePino altura = esPesoUtil (pesoPino altura)

costoTransporte :: Altura->Float
costoTransporte altura
    |not (sirvePino altura) = error "No sirve el pino"
    |pesoPino altura <=500 = 5000
    |pesoPino altura <=800 = 10*pesoPino altura
    |pesoPino altura <=1000 = 10*pesoPino altura + altura*100