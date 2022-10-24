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

	method updateImage() {
		self.image("S_" + self.selectedPipe())
	}

	method selectedPipe() {
		return recentPipe.name() + dir.name() + ".png"
	}

	method movimientoUp() {
		if (self.collideUp()) {
			position = position.up(1)
		}
	}

	method collideUp() = not (self.position().up(1).y() == 8) && not game.getObjectsIn(self.position().up(1)).any({ element => element.blocked()})

	method movimientoDown() {
		if (self.collideDown()) {
			position = position.down(1)
		}
	}

	method collideDown() = not (self.position().down(1).y() == 2) && not game.getObjectsIn(self.position().down(1)).any({ element => element.blocked()})

	method movimientoLeft() {
		if (self.collideLeft()) {
			position = position.left(1)
		}
	}

	method collideLeft() = not (self.position().left(1).x() == 4) && not game.getObjectsIn(self.position().left(1)).any({ element => element.blocked()})

	method movimientoRight() {
		if (self.collideRight()) {
			position = position.right(1)
		}
	}

	method collideRight() = not (self.position().right(1).x() == 10) && not game.getObjectsIn(self.position().right(1)).any({ element => element.blocked()})

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

