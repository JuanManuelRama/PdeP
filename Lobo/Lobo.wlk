object feroz{
    const pesoInicial = 10
    var peso = 10
    method saludable() = peso>=20 || peso<=150
    method cambioPeso(cantidad) {peso +=cantidad}
    method crisis(){peso = pesoInicial}
    method comer(victima) {self.cambioPeso(victima.peso()*1.1)}
    method correr(){self.cambioPeso(-1)}
    method recibirDisparo(){self.crisis()}
    method soplar(casa){self.cambioPeso(-casa.resistencia() - casa.ocupante().peso())}
}

object caperucita{
    const peso = 60
    var manzanas = 6
    const pesoManzana = 0.2
    method peso() = peso + manzanas*pesoManzana
    method cambioManzanas(cantidad){manzanas += cantidad}
}

object abuelita{
    const peso = 50
    method peso() = peso
}

object cazador{
    const peso = 80
    const pesoRifle = 40
    var balas = 8
    const pesoBala = 3
    method peso() = peso+pesoRifle+pesoBala*pesoRifle
    method disparar(victima){
        victima.recibirDisparo()
        balas-=1
    }
}

/*feroz.correr()
  feorz.correr()
  feroz.comer(abuelita)
  caperucita.cambioManzanas(-1)
  feroz.comer(caperucita)
  cazador.disparar(feroz)
  feroz.comer(cazador)
*/

object casaPaja{
    method resistencia() = 0
    method ocupante() = chanchito1
}

object casaMadera{
    method resistencia() = 5
    method ocupante() = chanchito2
}

object casaLadrillo{
    const ladrillos = 10
    method resistencia() = 2*ladrillos
    method ocupante() = chanchito3
}

object chanchito1{
    method peso() = 30
}

object chanchito2{
    method peso () = 35
}

object chanchito3{
    method peso () = 40
}