import wollok.game.*
import Bloques.*
import Juego.*
import Niveles.*
import dir.*
import Selector.*

object textoTiempo {

	method position() = game.at(12, 6)

	method text() = "   Tiempo:" + contador.segundos().toString() + " Segundos"

	method textColor() = "800040"

}

object textoPipes {

	method position() = game.at(2, 6)

	method text() = "\n\n  Pipe tipo I: " + selectorPipeTypeI.quantity().toString() + "\n\n\n  Pipe tipo L:" + selectorPipeTypeL.quantity().toString() + "\n\n\n  Pipe tipo T:" + selectorPipeTypeT.quantity().toString()

	method textColor() = "800040"

}

object textoNivel {

	method position() = game.at(2, 8)

	method text() = (juego.numeroDelNivelActual() + 1).toString()

	method textColor() = "800040"

}

object mario {

	const property image = "mariosar.png"
	const property position = game.at(12, 2)
	const property comentarios = [ "Mucha play, poco wollok", "Te falta pala pibe", "¿Dónde quedó tu C ahora?", "Esta dificil ¿No?", "Yo a tu edad ya tenía mi titulo", "Dale che", "Bueno vamo' a juga'" ]

	method hablar() {
		game.say(self, "Hola pibe")
	}

	method felicitar() {
		game.say(self, "Bien pibe lo lograste!")
	}

	method quejarse() {
		game.say(self, "Dale pibe, no tengo todo el dia")
	}

	method comentario() {
		game.say(self, self.comentarios().anyOne())
	}

}

object imagenNivel {

	const property image = "VICTORIA_mario.png"
	const property position = game.at(0, 0)

	method aparecer() {
		game.addVisual(self)
	}

	method desaparecer() {
		if (game.hasVisual(self)) {
			game.removeVisual(self)
		}
	}

}

object imagenFin {

	const property image = "FINAL_mario.png" // /acá pone cual es la imagen
	const property position = game.at(0, 0)

	method aparecer() {
		game.addVisual(self)
	}

}

object contador {

	var property segundos = 0

	method tiempo() {
		segundos += 1
	}

}

