import wollok.game.*
import Textos.*
import Juego.*

class Block {

	var property image													//	******N******
	const property position												//	*           *
																		//	*           *	
	method blocked() = true												//	*W         E*
																		//	*           *
}																		//	*           *
																		//	******S******
class Pipe inherits Block { //no se pueden mover
//	const property direction = [ "N", "E", "S", "W" ]

	const property indexDirection
	const property connectedPipe = [ {game.getObjectsIn(self.position().up(1))}, {game.getObjectsIn(self.position().right(1))}, {game.getObjectsIn(self.position().down(1))}, {game.getObjectsIn(self.position().left(1))} ]

	method connected() {
		return self.connectionDetected()
	}

	method connectionDetected() {
		return self.connectedPipe().get(self.indexDirection()).apply().size() >= 1
	}

}

class CrozablePipe inherits Pipe { //se pueden atravezar

	const property indexPipe

	method connectionDetected(dir) {
		return self.connectedPipe().get(dir).apply().size() >= 1
	}

	override method blocked() = false

}

class PipeTypeI inherits CrozablePipe {

	override method connectionDetected() {
		if ((self.indexDirection() == 0) || (self.indexDirection() == 2)) {
			return self.connectionDetected(0) && self.connectionDetected(2)
		} else {
			return self.connectionDetected(1) && self.connectionDetected(3)
		}
	}

}

class PipeTypeL inherits CrozablePipe {

	override method connectionDetected() {
		if (self.indexDirection() == 0) { // N
			return self.connectionDetected(1) && self.connectionDetected(2)
		} else if (self.indexDirection() == 1) { // E
			return self.connectionDetected(0) && self.connectionDetected(1)
		} else if (self.indexDirection() == 2) { // S
			return self.connectionDetected(0) && self.connectionDetected(3)
		} else { // indexDirection() == 3
			return self.connectionDetected(2) && self.connectionDetected(3)
		}
	}

}

class PipeTypeT inherits CrozablePipe {

	override method connectionDetected() {
		if (self.indexDirection() == 0) { // N
			return self.connectionDetected(0) && self.connectionDetected(1) && self.connectionDetected(3)
		} else if (self.indexDirection() == 1) { // E
			return self.connectionDetected(0) && self.connectionDetected(1) && self.connectionDetected(2)
		} else if (self.indexDirection() == 2) { // S
			return self.connectionDetected(1) && self.connectionDetected(2) && self.connectionDetected(3)
		} else { // indexDirection() == 3 //W
			return self.connectionDetected(0) && self.connectionDetected(3) && self.connectionDetected(2)
		}
	}

}

// var property dir
object selector {


	const property pipes = [ "pipeTypeI_", "pipeTypeL_", "pipeTypeT_" ]
	var property indexPipe = 0
	var property direction = [ "N", "E", "S", "W" ]
	var property indexDirection = 0
	var property position = game.center() // necesito definir el property para tener el getter
	var property image = "S_pipeTypeI_N.png"
	var property pipeValidator = 10

	method updateImage() {
		self.image("S_" + self.selectedPipe())
	}

	method selectedPipe() {
		return self.pipes().get(self.indexPipe()) + self.direction().get(self.indexDirection()) + self.imageFormat()
	}

	method imageFormat() = ".png"

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

}


