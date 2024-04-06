esDiv :: Int->Int->Bool
esDiv divisor dividendo = mod divisor dividendo == 0

esBisiesto :: Int-> Bool
esBisiesto anio = (esDiv anio 4 &&  not (esDiv anio 100))  || esDiv anio 400

esCapicua :: String->Bool
esCapicua palabra = reverse palabra == palabra

valAbs :: Int->Int
valAbs x 
    | x >= 0 = x
    | otherwise = x * (-1)

mult3 :: Int->Bool
mult3 x = mod x 3 == 0 

doblediv :: Int->Int->Int->Bool
doblediv x div1 div2 = mod x div1 == 0 && mod x div2 == 0

pow :: Int->Int->Int
pow bas exp 
    | bas==0 && exp==0 = error "NOOOO"
    | exp==0 = 1
    |otherwise = bas * pow bas (exp-1)