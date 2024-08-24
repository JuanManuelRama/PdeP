object afa {
  var arcas = 0
  const costoFijo = 10000000
  var precioEntrada = 10000

  method arcas()=arcas
  method ventas(jugador, estadio) = estadio.capacidad()*jugador.popularidad()/100
  method recaudacion(jugador, estadio) = self.ventas(jugador, estadio) * precioEntrada
  method gastos(jugador, estadio) = estadio.costo() + jugador.costo() + costoFijo
  method inflacion(indice) {precioEntrada = precioEntrada+precioEntrada*indice/100}

  method despedida(jugador, estadio){
    arcas = arcas + self.recaudacion(jugador, estadio) - self.gastos(jugador, estadio)
  }
}

//Jugadores
object messi {
  method popularidad() = 98
  method costo() = 10000
}

object ronaldo {
  method popularidad() = messi.popularidad()/2
  method costo() = 2000000
}

object mbape {
  var edad = 25
  const golesEnFinales = 4

  method popularidad() = edad*2+golesEnFinales
  method cumpleanio() {edad = edad + 1}
}

object roman {
  var popularidad = 90
  method popularidad() = popularidad

  method topoGigo(){popularidad = popularidad + 5}
  method sebarMate(){popularidad = popularidad + 1}
  method elogiarAPol(){popularidad = popularidad - 3}
  method ganarleAlMineiro(){popularidad = popularidad + 5}
  method costo()=500000
}


//Estadios
object bombonera {
  method capacidad() = 50000
  method costo() = 10000000
}

object monumental {
  const capacidadFinal = 80000
  var obras = 50
  method avanceObras(avance){
    obras = obras + avance
  }
  method capacidad() = capacidadFinal - capacidadFinal*(100-obras)/100
  method costo() = 2000000
}

object dobleVisera {
  var deudas = 20000000
  var destruccion = 10
  const capacidad = 45000
  method colecta(monto){deudas = deudas - monto}
  method ficharJugador(monto){deudas = deudas+monto*3}
  method costo() = deudas/10
  method partido() {destruccion = destruccion +5}
  method capacidad() = capacidad-capacidad*destruccion/100
}
