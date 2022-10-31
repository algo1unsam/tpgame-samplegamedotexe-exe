import wollok.game.*
import Textos.*
import Niveles.*
import dir.*
import Bloques.*
import Juego.*

object selectorPipeTypeI {

	var property quantity = 0
	const property name = 'pipeTypeI_'

	method increase() {
		quantity += 1
	}

	method decrease() {
		quantity -= 1
	}

	method createPipe(dir, position) {
		const newPipe = new PipeTypeI(dir = dir, position = position)
		juego.addNewPipe(newPipe)
	}

}

object selectorPipeTypeL {

	var property quantity = 0
	const property name = 'pipeTypeL_'

	method increase() {
		quantity += 1
	}

	method decrease() {
		quantity -= 1
	}

	method createPipe(dir, position) {
		const newPipe = new PipeTypeL(dir = dir, position = position)
		juego.addNewPipe(newPipe)
	}

}

object selectorPipeTypeT {

	var property quantity = 0
	const property name = 'pipeTypeT_'

	method increase() {
		quantity += 1
	}

	method decrease() {
		quantity -= 1
	}

	method createPipe(dir, position) {
		const newPipe = new PipeTypeT(dir = dir, position = position)
		juego.addNewPipe(newPipe)
	}

}

// var property dir
object selector {

	var property position = game.center() // necesito definir el property para tener el getter
	var property dir = north
	var property recentPipe = selectorPipeTypeI
	var property image = "S_pipeTypeI_N.png"
	var property pipeValidator = 10

	method connectable() = false

	method updateImage() {
		self.image("S_" + self.selectedPipe())
	}

	method selectedPipe() {
		return recentPipe.name() + dir.name() + ".png"
	}

	method movimientoUp() {
		if (self.puedoMoverme(north)) {
			position = position.up(1)
		}
	}

	method movimientoLeft() {
		if (self.puedoMoverme(west)) {
			position = position.left(1)
		}
	}

	method movimientoRight() {
		if (self.puedoMoverme(east)) {
			position = position.right(1)
		}
	}

	method movimientoDown() {
		if (self.puedoMoverme(south)) {
			position = position.down(1)
		}
	}

	method puedoMoverme(dirr) = not self.chocaConRecuadro(dirr) && not (self.hayAlgunoBloqueado(dirr))

	method chocaConRecuadro(dirr) {
		return dirr.limite()
	}

	method hayAlgunoBloqueado(dirr) {
		return dirr.bloquesPorDelante(position).any({ element => element.blocked() })
	}

	// bloque -> bloqueado -> true
	// norte -> hay un bloque -> esta bloquado -> true
	method switchPipe(type) {
		self.recentPipe(type)
		self.updateImage()
	}

	method rotateSelector(dirr) {
		self.dir(dirr)
		self.updateImage()
	}

	method increaseRecentPipe() {
		recentPipe.increase()
	}

	method decreaseRecentPipe() {
		recentPipe.decrease()
	}

	method createNewPipe() {
		recentPipe.createPipe(dir, position)
	}

}

