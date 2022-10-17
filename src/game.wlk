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
class Block {

	var property image
	const property position

}

class Pipe inherits Block { //no se pueden mover

	const property direction = [ "N", "E", "S", "W" ]
	const property indexDirection
	const property connectedPipe = [ {game.getObjectsIn(self.position().up(1))}, {game.getObjectsIn(self.position().right(1))}, {game.getObjectsIn(self.position().down(1))}, {game.getObjectsIn(self.position().left(1))} ]
	const property pipeList = [ "obstacle.png" ]
	const property validPipes = []

	method blocked() {
		return true
	}

	method connected() {
		return self.connectionDetected() && self.isPipeValid()
	}

	method isPipeValid() {
		return self.validPipes().contains(self.connectedPipe().get(indexDirection).apply().last().image())
	}

	method connectionDetected() {
		return self.connectedPipe().get(self.indexDirection()).apply().size() >= 1
	}

// var property connectionsFinish = [ false, false, false, true]//        				  "W"= ←
}

class CrozablePipe inherits Pipe { //se pueden atravezar
//	var property connectionsTypeI = [ true, false, true, false] //"N"= ↑,       , "S"= ↓, 
//	var property connectionsTypeL= [ false, true, true, false] //       , "E"= →, "S"= ↓, 
//	var property connectionsTypeT= [ false, true, true, true] //        , "E"= →, "S"= ↓, "W"= ←

	const property pipes = [ "pipeTypeI_", "pipeTypeL_", "pipeTypeT_" ]
	var property indexPipe

	override method blocked() {
		return false
	}

}

class PipeTypeI inherits CrozablePipe {

}

class PipeTypeL inherits CrozablePipe {

}

class PipeTypeT inherits CrozablePipe {

}

// var property dir

object selector {

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
	 */
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
	const property validPipes = [ ["pipeTypeI_N.png","pipeTypeI_S.png","pipeTypeI_W.png","pipeTypeI_E.png","pipeTypeL_W.png","pipeTypeL_N.png","endPipe_S.png"], ["pipeTypeI_E.png","pipeTypeI_W.png","pipeTypeI_N.png","pipeTypeI_S.png","pipeTypeL_W.png","pipeTypeL_S.png","endPipe_W.png"], ["pipeTypeI_N.png","pipeTypeI_S.png","pipeTypeL_S.png","pipeTypeL_E.png","endPipe_N.png"], ["pipeTypeI_E.png","pipeTypeI_W.png","pipeTypeL_N.png","pipeTypeL_E.png","endPipe_E.png"] ]

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
		const pipeInicio = new Pipe(position = game.at(5, 3), image = "initPipe_N.png", indexDirection = 0, validPipes = [ "pipeTypeI_N.png", "pipeTypeI_S.png", "pipeTypeI_E.png" ])
		const pipeFin = new Pipe(position = game.at(9, 7), image = "endPipe_S.png", indexDirection = 2)
		self.pipesInGame().add(pipeInicio)
		game.addVisual(pipeInicio)
		game.addVisual(pipeFin)
	}

	method setKeys() {
		keyboard.w().onPressDo{ self.rotateSelector(0)} // North (N)
		keyboard.a().onPressDo{ self.rotateSelector(3)} // East (E)
		keyboard.s().onPressDo{ self.rotateSelector(2)} // South (S)
		keyboard.d().onPressDo{ self.rotateSelector(1)} // West (W)		
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
			const newPipe = new CrozablePipe(position = selector.position().clone(), image = selector.selectedPipe(), indexPipe = selector.indexPipe(), indexDirection = selector.indexDirection(), validPipes = self.validPipes().get(selector.indexDirection()))
			self.activePipes().add(newPipe)
			self.pipesInGame().add(newPipe)
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
			self.activePipes().remove(game.colliders(selector).last())
			self.pipesInGame().remove(game.colliders(selector).last())
			game.removeVisual(game.colliders(selector).last())
		}
	}

	method notUnderSelector() {
		return game.colliders(selector).size() == 0
	}

	method isActivePipesEmpty() {
		return activePipes.size() == 0
	}

	method rotateSelector(dir) {
		selector.indexDirection(dir)
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

	method win() {
		if (self.winCondition()) {
			game.say(selector, "Ahora lo entiendo, yo soy el pipeGame")
		}
	}

	method winCondition() {
		var winingCondition = true
		self.pipesInGame().forEach({ pipe => winingCondition = winingCondition && pipe.connected() })
		return winingCondition
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

