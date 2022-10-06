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

}

class Pipe inherits Block {

	var property image

// var property dir
}

object selector {

	var property position = game.center() // necesito definir el property para tener el getter
	var property previousPosition
	var property image = "guy_N.png"

	method selectorRotacion(dir) {
		self.image("guy_" + dir + ".png")
	// (object + direction + type)
	}

//
//	method movimientoUp(){
//		self.updatePreviousPosition()
//		position = position.up(1)
//	}
//	
//	method movimientoDown(){
//		self.updatePreviousPosition()
//		position = position.down(1)
//	}
//	
//	method movimientoLeft(){
//		self.updatePreviousPosition()
//		position = position.left(1)
//	}
//	
//	method movimientoRight(){
//		self.updatePreviousPosition()
//		position = position.right(1)
//	}
	method updatePreviousPosition() {
		previousPosition = position.clone()
	}

	method vuelvoAtras(conQuienChoco) {
		position = previousPosition
	}
	
	method volverAlCentro(){
		position = game.center()
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

	method iniciar() {
		game.title("Juego Base")
		game.width(15)
		game.height(10)
		game.cellSize(50)
		self.creaPersonajes()
		game.boardGround("background_beta.png")
		game.start()
		game.whenCollideDo(selector, { conQuienChoco =>
			selector.vuelvoAtras(conQuienChoco)
			game.say(selector, "recorcholis")
		})
		self.consultaMovimiento()
		self.consultaSelectorRotacion()
		self.consultaColocarPipe()
	}

	method consultaSelectorRotacion() {
		// we ask the block rotate
		// esto lo tiene que hacer el objeto, y no el juego
		// el juego corrobora que esten las condiciones para abrir, cerrar, inicio, fin
		// nivel completado, nivel finalizado
		keyboard.w().onPressDo{ selector.selectorRotacion("N")} // North (N)
		keyboard.s().onPressDo{ selector.selectorRotacion("S")} // shift rigt
		keyboard.a().onPressDo{ selector.selectorRotacion("W")} // shift rigt
		keyboard.d().onPressDo{ selector.selectorRotacion("E")} // shift rigt		
	}

	method consultaMovimiento() {
		keyboard.up().onPressDo{ selector.updatePreviousPosition()}
		keyboard.down().onPressDo{ selector.updatePreviousPosition()}
		keyboard.left().onPressDo{ selector.updatePreviousPosition()}
		keyboard.right().onPressDo{ selector.updatePreviousPosition()}
	}

	method creaPersonajes() {
		const pipeInicio = new Pipe(position = game.at(5, 3), image = "inicio_N.png")
		const pipeFin = new Pipe(position = game.at(9, 7), image = "fin_N.png")
		const barrier = self.setBarrier()
		barrier.forEach({ blockBarrier => game.addVisual(blockBarrier)})
		game.addVisualCharacter(selector)
		game.addVisual(pipeInicio)
		game.addVisual(pipeFin)
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
		return [ barrier3x7, barrier3x6, barrier3x5, barrier3x4, barrier3x3, barrier8x2, barrier7x2, barrier6x2, barrier5x2, barrier4x2, barrier8x8, barrier7x8, barrier6x8, barrier5x8, barrier4x8, barrier9x7, barrier9x6, barrier9x5, barrier9x4, barrier9x3 ]
	}
	
	method consultaColocarPipe() {
		keyboard.space().onPressDo{self.colocarPipe()}
	}
	
	method colocarPipe() {
		const newPipe = new Pipe(position = selector.position().clone(), image = "default.png")
		self.consultaCentrarSelector()
		game.addVisual(newPipe)
	}
	method consultaCentrarSelector() {
		selector.volverAlCentro()
	}

}

