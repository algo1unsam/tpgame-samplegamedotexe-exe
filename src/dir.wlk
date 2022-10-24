import wollok.game.*
import Bloques.*
import Juego.*
import Textos.*
import Niveles.*

object north {

	const property name = 'N'

	method bloquePorDelante(pos) {
		return game.getObjectsIn(pos.up(1)).size() >= 1
	}

}

object south {

	const property name = 'S'

	method bloquePorDelante(pos) {
		return game.getObjectsIn(pos.down(1)).size() >= 1
	}

}

object east {

	const property name = 'E'

	method bloquePorDelante(pos) {
		return game.getObjectsIn(pos.right(1)).size() >= 1
	}

}

object west {

	const property name = 'W'

	method bloquePorDelante(pos) {
		return game.getObjectsIn(pos.left(1)).size() >= 1
	}

}