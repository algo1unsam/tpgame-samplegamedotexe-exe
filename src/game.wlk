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

	method deleteYourself() {
		game.removeVisual(self)
	}

// var property dir
}

object selector {

	var property position = game.center() // necesito definir el property para tener el getter
	var property image = "guy_N.png"

	method selectorRotacion(dir) {
		self.image("guy_" + dir + ".png")
	// (object + direction + type)
	}

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

	method overPipe() {
		return (not game.colliders(self).any({ element => element.blocked()}))
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
		game.boardGround("background_beta.png")
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
		keyboard.w().onPressDo{ selector.selectorRotacion("N")} // North (N)
		keyboard.s().onPressDo{ selector.selectorRotacion("S")} // shift rigt
		keyboard.a().onPressDo{ selector.selectorRotacion("W")} // shift rigt
		keyboard.d().onPressDo{ selector.selectorRotacion("E")} // shift rigt		
		keyboard.up().onPressDo{ selector.movimientoUp()}
		keyboard.down().onPressDo{ selector.movimientoDown()}
		keyboard.left().onPressDo{ selector.movimientoLeft()}
		keyboard.right().onPressDo{ selector.movimientoRight()}
		keyboard.space().onPressDo{ self.colocarPipe()}
		keyboard.backspace().onPressDo{ self.deletePipe()}
	}

	method colocarPipe() {
		const newPipe = new CrozablePipe(position = selector.position().clone(), image = "pipe.png")
		activePipes.add(newPipe)
		game.addVisual(newPipe)
	}

	method deletePipe() {
		if (selector.overPipe()) {
			game.removeVisual(activePipes.last())
			activePipes.remove(activePipes.last())
		}
	}

}

