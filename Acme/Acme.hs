type Nombre=String
type Empleados=Int
cantEmpleados :: Nombre->Empleados
cantEmpleados "Acme" =10
cantEmpleados nombre
    |cond1 nombre = length nombre  -2
    |esCapyPar nombre = 2*(length nombre -2)
    |cond3 nombre = 3
    |otherwise = 0


cond1 :: Nombre->Bool
cond1 nombre = head nombre>last nombre

esCapyPar :: Nombre->Bool    
esCapyPar nombre = esCapicua nombre && esPar (length nombre)

esCapicua :: Nombre->Bool
esCapicua nombre = nombre == reverse nombre

esPar :: Int->Bool
esPar = even

cond3 :: Nombre->Bool
cond3 nombre = div3 (length nombre) || div7 (length nombre)

div3 :: Int->Bool
div3 x = mod x 3 ==0

div7 :: Int->Bool
div7 x = mod x 7 ==0