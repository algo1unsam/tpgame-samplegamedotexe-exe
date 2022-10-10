import wollok.game.*

/*
 * *****N******
 *           *
 *           *
 * 	W           E
 *           *
 *           *
 * *****S******

 */
/**/
class Block {

	var property position

	method blocked() {
		return true
	}

}

class Pipe inherits Block { //no se pueden mover

	var property image

}

class CrozablePipe inherits Pipe { //se pueden atravezar

	override method blocked() {
		return false
	}

// var property dir
}

object selector {

	const property pipes = [ "pipeTypeI_", "pipeTypeL_", "pipeTypeT_" ]
	var property indexPipe = 0
	var property direction = [ "N", "E", "S", "W" ]
	var property indexDirection = 0
	var property position = game.center() // necesito definir el property para tener el getter
	var property image = "S_pipeTypeI_N.png"

	method selectorRotacion(pipe, dir) {
		self.image("S_" + self.selectedPipe())
	// (object + direction + type)
	}

	method updateImage() {
		self.image("S_" + self.selectedPipe())
	}

	method selectedPipe() {
		return self.pipes().get(self.indexPipe()) + self.direction().get(self.indexDirection()) + self.imageFormat()
	}

	method imageFormat() = ".png"

	method movimientoUp() {
		if (not game.getObjectsIn(position.up(1)).any({ element => element.blocked()})) {
			position = position.up(1)
		}
	}

	method movimientoDown() {
		if (not game.getObjectsIn(position.down(1)).any({ element => element.blocked()})) {
			position = position.down(1)
		}
	}

	method movimientoLeft() {
		if (not game.getObjectsIn(position.left(1)).any({ element => element.blocked()})) {
			position = position.left(1)
		}
	}

	method movimientoRight() {
		if (not game.getObjectsIn(position.right(1)).any({ element => element.blocked()})) {
			position = position.right(1)
		}
	}

}

//object pipeInicio {
//
//	var property position = game.at(0, 0) // necesito definir el property para tener el getter
//	var property image = "inicio_N.png"
//
//}
//
//object pipeFin {
//
//	var property position = game.at(4, 4) // necesito definir el property para tener el getter
//	var property image = "fin_N.png"
//
//}
object juego {

	const activePipes = []

	method iniciar() {
		game.title("Juego Base")
		game.width(15)
		game.height(10)
		game.cellSize(50)
		game.boardGround("background_beta(01).png")
		game.start()
		self.creaPersonajes()
		self.setKeys()
	}

	method creaPersonajes() {
		self.createBeginAndEndPipe()
		self.setBarrier()
		game.addVisual(selector)
	}

	method setBarrier() {
		const barrier3x7 = new Block(position = game.at(4, 7))
		const barrier3x6 = new Block(position = game.at(4, 6))
		const barrier3x5 = new Block(position = game.at(4, 5))
		const barrier3x4 = new Block(position = game.at(4, 4))
		const barrier3x3 = new Block(position = game.at(4, 3))
		const barrier8x2 = new Block(position = game.at(9, 2))
		const barrier7x2 = new Block(position = game.at(8, 2))
		const barrier6x2 = new Block(position = game.at(7, 2))
		const barrier5x2 = new Block(position = game.at(6, 2))
		const barrier4x2 = new Block(position = game.at(5, 2))
		const barrier8x8 = new Block(position = game.at(9, 8))
		const barrier7x8 = new Block(position = game.at(8, 8))
		const barrier6x8 = new Block(position = game.at(7, 8))
		const barrier5x8 = new Block(position = game.at(6, 8))
		const barrier4x8 = new Block(position = game.at(5, 8))
		const barrier9x7 = new Block(position = game.at(10, 7))
		const barrier9x6 = new Block(position = game.at(10, 6))
		const barrier9x5 = new Block(position = game.at(10, 5))
		const barrier9x4 = new Block(position = game.at(10, 4))
		const barrier9x3 = new Block(position = game.at(10, 3))
		const barrier = [ barrier3x7, barrier3x6, barrier3x5, barrier3x4, barrier3x3, barrier8x2, barrier7x2, barrier6x2, barrier5x2, barrier4x2, barrier8x8, barrier7x8, barrier6x8, barrier5x8, barrier4x8, barrier9x7, barrier9x6, barrier9x5, barrier9x4, barrier9x3 ]
		barrier.forEach({ blockBarrier => game.addVisual(blockBarrier)})
	}

	method createBeginAndEndPipe() {
		const pipeInicio = new Pipe(position = game.at(5, 3), image = "inicio_N.png")
		const pipeFin = new Pipe(position = game.at(9, 7), image = "fin_N.png")
		game.addVisual(pipeInicio)
		game.addVisual(pipeFin)
	}

	method setKeys() {
		keyboard.w().onPressDo{ selector.selectorRotacion(self.selectorPipe(), self.selectorDirection(0))} // North (N)
		keyboard.s().onPressDo{ selector.selectorRotacion(self.selectorPipe(), self.selectorDirection(1))} // East (E)
		keyboard.a().onPressDo{ selector.selectorRotacion(self.selectorPipe(), self.selectorDirection(2))} // South (S)
		keyboard.d().onPressDo{ selector.selectorRotacion(self.selectorPipe(), self.selectorDirection(3))} // West (W)		
		keyboard.up().onPressDo{ selector.movimientoUp()}
		keyboard.down().onPressDo{ selector.movimientoDown()}
		keyboard.left().onPressDo{ selector.movimientoLeft()}
		keyboard.right().onPressDo{ selector.movimientoRight()}
		keyboard.space().onPressDo{ self.colocarPipe()}
		keyboard.z().onPressDo{ self.deleteLastPipe()}
		keyboard.backspace().onPressDo{ self.deleteOverPipe()}
		keyboard.q().onPressDo{ self.switchPipeQ()}
		keyboard.e().onPressDo{ self.switchPipeE()}
	}

	method colocarPipe() {
		if (self.notUnderSelector()) {
			const newPipe = new CrozablePipe(position = selector.position().clone(), image = selector.selectedPipe())
			activePipes.add(newPipe)
			game.addVisual(newPipe)
		}
	}

	method deleteLastPipe() {
		if (not self.isActivePipesEmpty()) {
			game.removeVisual(activePipes.last())
			activePipes.remove(activePipes.last())
		}
	}

	method deleteOverPipe() {
		if (not self.notUnderSelector()) {
			activePipes.remove(game.colliders(selector).last())
			game.removeVisual(game.colliders(selector).last())
		}
	}

	method notUnderSelector() {
		return game.colliders(selector).size() == 0
	}

	method isActivePipesEmpty() {
		return activePipes.size() == 0
	}

	method switchPipeE() {
		if (selector.indexPipe() == 2) {
			selector.indexPipe(0)
			selector.updateImage()
		} else {
			selector.indexPipe(selector.indexPipe() + 1)
			selector.updateImage()
		}
	}

	method switchPipeQ() {
		if (selector.indexPipe() == 0) {
			selector.indexPipe(2)
			selector.updateImage()
		} else {
			selector.indexPipe(selector.indexPipe() - 1)
			selector.updateImage()
		}
	}

	method selectorPipe() {
		return selector.pipes().get(selector.indexPipe())
	}

	method selectorDirection() {
		return selector.direction().get(selector.indexDirection())
	}

	method selectorDirection(dir) {
		selector.indexDirection(dir)
		return selector.direction().get(selector.indexDirection())
	}

}

