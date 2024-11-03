class Persona{
    var monedas = 20
    var anios

    method ganarMonedas(monto) {monedas += monto}
    method gastarMonedas(monto) {monedas -= monto}
    method recursos() = monedas

    method cumplir() {anios += 1}
    method edad() = anios

    method destacada() = anios.between(18, 65) && self.recursos()>30

    method trabajar(planeta, tiempo){}
}

class Productor inherits Persona{
    const property tecnicas = ["cultivo"]
    override method recursos() = super() * tecnicas.size()
    override method destacada() = super() || tecnicas.size() > 5

    method realizarTecnica(tecnica, tiempo) {
        if(tecnicas.contains(tecnica)){
            self.ganarMonedas(3*tiempo)
        }
        else
            self.gastarMonedas(1)
    }
    method aprenderTecnica(tecnica) {tecnicas.add(tecnica)}
    override method trabajar(tiempo, planeta){
        if(planeta.habitantes().contains(self))
            self.realizarTecnica(tecnicas.last(), tiempo)}
}

class Constructor inherits Persona{
    const property construcciones = []
    var property region

    override method recursos() = super() + 10*construcciones.size()
    override method destacada() = construcciones.size()>5

    override method trabajar(tiempo, planeta){
        const construccion  = region.construccion(tiempo, self)
        construcciones.add(construccion)
        planeta.construcciones().add(construccion)
        self.ganarMonedas(5)
    }
}

object montania{
    method construccion(tiempo, obrero) = new Muralla(longitud = tiempo/2)
}

object costa{
    method construccion(tiempo, obrero) = new Museo(superficie = tiempo, factorPropio = 1)
}

object llanura{
    method construccion(tiempo, obrero) = if(obrero.destacado()) new Museo(superficie = tiempo, factorPropio = 1) else new Muralla(longitud = tiempo/2)
}

class Muralla{
    const longitud
    method valor() = longitud*10
}

class Museo{
    const superficie
    const factorPropio
    method valor() = superficie*factorPropio
}

class Planeta{
    const property habitantes = []
    const property construcciones = []

    method destacados() = habitantes.filter({x=>x.destacada()})
    method masValioso () = [habitantes.max({x=>x.recursos()})]

    method delegacion() = (self.destacados() + self.masValioso()).asSet()
    method valioso() = construcciones.sum({x=>x.valor()}) > 100
}