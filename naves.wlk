
class Nave {
	var velocidad = 0

	method propulsar() {
		velocidad = (velocidad + 20000).min(300000)
	}

	method prepararseParaViajar() {
		velocidad = (velocidad + 15000).min(300000)
	}

	method recibirAmenaza()

	method encontrarseEnemigo() {
		self.recibirAmenaza()
		self.propulsar()
	}
}
class NaveDeCarga inherits Nave() {

	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	override method recibirAmenaza() {
		carga = 0
	}
}


class NaveDeCargaDeResiduos inherits NaveDeCarga() {

	var selladaAlVacio = false

	override method recibirAmenaza() {
		velocidad = 0
		if (not selladaAlVacio) {carga = 0}
	}

	override method prepararseParaViajar() {
		super()
		selladaAlVacio = true
	}

}


class NaveDePasajeros inherits Nave() {

	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	override method recibirAmenaza() {
		alarma = true
	}

}

class NaveDeCombate inherits Nave() {

	var property modo = reposo
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	override method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}

	override method prepararseParaViajar() {
		super()
		modo.preparacion(self)

	}

}

object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

	method preparacion(nave) {
		nave.emitirMensaje("Saliendo en misión")
		nave.modo(ataque)
	}

}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

	method preparacion(nave) {
		nave.emitirMensaje("Volviendo a la base")
	}

}
