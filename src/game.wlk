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
/*	0			0			0			0
 * 	N			E			S			W
 * 
 * validez de tubo
 * 
 * bin  - dir 		-	dec		- type
 * 0000 - null		-	0		- null
 * 0001 - W 		-	1		- init/end		I/E
 * 0010 - S 		-	2		- init/end		I/E
 * 0011 - S W 		-	3		- codo			C
 * 0100 - E			-	4		- init/end		I/E
 * 0101 - E W		-	5		- tubo			P
 * 0110 - E S		-	6		- codo			C
 * 0111	- E S W		-	7		- t 			X
 * 1000	- N			-	8		- init/end		I/E
 * 1001 - N W		-	9		- codo			C
 * 1010 - N S		-	10      - tubo 			P
 * 1011 - N S W		-	11		- t				X
 * 1100 - N E		-	12		- codo			C
 * 1101 - N E W		-	13		- t				X
 * 1110 - N E S		-	14		- t				X
 * 1111 - N E S W	-	15		- estrella 		X
 * 
 * 	
 */
class Block {

	const property conectable = true
	const property position
	var property image

}

class Pipe inherits Block { //no se pueden mover

	const property direction = [ "N", "E", "S", "W" ]
	const property indexDirection
	const property validPipes = []

	method blocked() {
		return true
	}

// var property connectionsFinish = [ false, false, false, true]//        				  "W"= ←
}

class CrozablePipe inherits Pipe { //se pueden atravezar
//	var property connectionsTypeI = [ true, false, true, false] //"N"= ↑,       , "S"= ↓, 
//	var property connectionsTypeL= [ false, true, true, false] //       , "E"= →, "S"= ↓, 
//	var property connectionsTypeT= [ false, true, true, true] //        , "E"= →, "S"= ↓, "W"= ←

	const property pipes = [ "pipeTypeI_", "pipeTypeL_", "pipeTypeT_" ]
	var property indexPipe = 0

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

	method collideRight() = not (self.position().right(1).x() == 11) && not game.getObjectsIn(self.position().right(1)).any({ element => element.blocked()})

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

	const property activePipes = []
	const property pipesInGame = []

	method iniciar() {
		game.title("Juego Base")
		game.width(15)
		game.height(10)
		game.cellSize(50)
		game.boardGround("background_beta(01).png")
			// MUSICA y TIEMPO
		game.start()
		self.setTimeAndMusic()
		self.creaPersonajes()
		self.setKeys()
	}

	method setTimeAndMusic() {
		const musica = game.sound("songBSO.mp3")
		musica.shouldLoop(true)
		musica.volume(0.01)
		game.schedule(0, { musica.play()})
		game.addVisual(textoTiempo)
	}

	method creaPersonajes() {
		self.createBeginAndEndPipe()
		game.addVisual(selector)
	}

	method createBeginAndEndPipe() {
		const pipeInicio = new Pipe(position = game.at(5, 3), image = "initPipe_N.png", indexDirection = 0)
		const pipeFin = new Pipe(position = game.at(9, 7), image = "endPipe_S.png", indexDirection = 2)
		self.pipesInGame().add(pipeInicio)
		game.addVisual(pipeInicio)
		game.addVisual(pipeFin)
	}

	method setKeys() {
		keyboard.w().onPressDo{ self.rotateSelector(0)} // North (N)
		keyboard.s().onPressDo{ self.rotateSelector(1)} // East (E)
		keyboard.a().onPressDo{ self.rotateSelector(2)} // South (S)
		keyboard.d().onPressDo{ self.rotateSelector(3)} // West (W)		
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
			const newPipe = new CrozablePipe(position = selector.position().clone(), image = selector.selectedPipe(), indexPipe = selector.indexPipe(), indexDirection = selector.indexDirection())
			activePipes.add(newPipe)
			game.addVisual(newPipe)
			self.win()
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

	method rotateSelector(value) {
		self.selectorDirection(value)
		selector.updateImage()
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
	}

	method win() {
		if (self.connected()) {
		// emite un mensaje de que ganaste
		}
	}

	method connected() {
		return true
	}

}

object textoTiempo {

	method position() = game.at(12, 6)

	method text() = "   Tiempo:" + contador.tiempo().toString() + " Segundos"

	method textColor() = "2080DFFF"

}

object contador {

	var milisegundos = 0
	var segundos = 0

	method tiempo() {
		milisegundos += 1
		segundos = milisegundos / 100
		return segundos.truncate(0)
	}

}

