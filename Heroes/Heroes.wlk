object heroe{
    var heroe = hernesto
    method cambiarHeroe(nuevoHeroe){heroe = nuevoHeroe}
    method cumplirMision(mision) = mision.cumplir(heroe)
}

object salvarAvion{
    method cumplir(heroe) = heroe.volar()
}
object evitarChoqueTren{
    method cumplir(heroe) = heroe.energia() > 100
}

object hernesto{
    var energia = 50
    method energia()=energia
    method comerAlfajor(){energia *= 1.1}
    method volar()=false
}

object uma {
    const energia = 500
    method energia() = energia
    var transporte = bondi160
    method cambiarTransporte(transporteNuevo) {transporte = transporteNuevo}
    method volar() = transporte.despegar()
}

object bondi160{
    method despegar() = false
}

object helicoptero{
    var combustible = 5
    method cargarNafta(litros){combustible += litros}
    method despegar()= combustible>10
}

object aurora{
    var energia = 200
    var cirugias = 0
    method energia()=energia
    method cirugia(){
        energia -=energia 
        cirugias +=1
    }
    method volar() = cirugias>=2
}
