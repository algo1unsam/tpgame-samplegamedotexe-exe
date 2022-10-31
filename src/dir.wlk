import wollok.game.*
import Bloques.*
import Juego.*
import Textos.*
import Niveles.*
import Selector.*

object north {

	const property name = 'N'

	method hayConexion(pos) {
		return game.getObjectsIn(pos.up(1)).any({pipe => pipe.connectable()})
	}

	method bloquesPorDelante(pos) {
		return game.getObjectsIn(pos.up(1))
	}

	method limite() {
		return (selector.position().y() + 1) == 8
	}

}

object south {

	const property name = 'S'

	method hayConexion(pos) {
		return game.getObjectsIn(pos.down(1)).any({pipe => pipe.connectable()})
	}

	method bloquesPorDelante(pos) {
		return game.getObjectsIn(pos.down(1))
	}

	method limite() {
		return (selector.position().y() - 1) == 2
	}

}

object east {

	const property name = 'E'

	method hayConexion(pos) {
		return game.getObjectsIn(pos.right(1)).any({pipe => pipe.connectable()})
	}

	method bloquesPorDelante(pos) {
		return game.getObjectsIn(pos.right(1))
	}

	method limite() {
		return (selector.position().x() + 1) == 10
	}

}

object west {

	const property name = 'W'

	method hayConexion(pos) {
		return game.getObjectsIn(pos.left(1)).any({pipe => pipe.connectable()})
	}

	method bloquesPorDelante(pos) {
		return game.getObjectsIn(pos.left(1))
	}

	method limite() {
		return ((selector.position().x() - 1) == 4)
	}

}

