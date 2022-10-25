import wollok.game.*
import Bloques.*
import Juego.*
import Textos.*
import Selector.*
import dir.*

object nivelUno {

	const pipeInicio = new InitPipe(dir = north, position = game.at(5, 3))
	const pipeFin = new EndPipe(dir = south, position = game.at(9, 7))
	const pipesDelNivel = [ pipeInicio, pipeFin ]
	var obstaculosDelNivel = []

	method crearObstaculos() {
		const obstacle1 = new Block(position = game.at(5, 7))
		const obstacle2 = new Block(position = game.at(5, 6))
		const obstacle3 = new Block(position = game.at(6, 7))
		const obstacle4 = new Block(position = game.at(9, 3))
		const obstacle5 = new Block(position = game.at(9, 4))
		const obstacle6 = new Block(position = game.at(8, 3))
		obstaculosDelNivel = [ obstacle1, obstacle2, obstacle3, obstacle4, obstacle5, obstacle6 ]
	}

	method iniciar() {
		//
		self.crearObstaculos()
		selectorPipeTypeI.quantity(10)
		selectorPipeTypeL.quantity(10)
		selectorPipeTypeT.quantity(0)
		juego.pipesInGame().add(pipeInicio)
		juego.pipesInGame().add(pipeFin)
		pipesDelNivel.forEach({ blocks => game.addVisual(blocks)})
		obstaculosDelNivel.forEach({ blocks => game.addVisual(blocks)})
	}

	method terminar() {
		juego.pipesInGame().remove(pipeInicio)
		juego.pipesInGame().remove(pipeFin)
		juego.deleteAllPipes()
		pipesDelNivel.forEach({ blocks => game.removeVisual(blocks)})
		obstaculosDelNivel.forEach({ blocks => game.removeVisual(blocks)})
		selector.position(game.center())
	}

}

object nivelDos {

	const pipeInicio = new InitPipe(dir = north, position = game.at(5, 3))
	const pipeInicio1 = new InitPipe(dir = south, position = game.at(5, 7))
	const pipeFin = new EndPipe(dir = north, position = game.at(9, 3))
	const pipeFin1 = new EndPipe(dir = west, position = game.at(9, 7))
	const pipesDelNivel = [ pipeInicio, pipeInicio1, pipeFin, pipeFin1 ]
	var obstaculosDelNivel = []

	method crearObstaculos() {
		const obstacle1 = new Block(position = game.at(7, 7))
		const obstacle2 = new Block(position = game.at(7, 6))
		const obstacle3 = new Block(position = game.at(7, 4))
		const obstacle4 = new Block(position = game.at(7, 3))
		obstaculosDelNivel = [ obstacle1, obstacle2, obstacle3, obstacle4 ]
	}

	method iniciar() {
		//
		self.crearObstaculos()
		selectorPipeTypeI.quantity(6)
		selectorPipeTypeL.quantity(5)
		selectorPipeTypeT.quantity(2)
		juego.pipesInGame().add(pipeInicio)
		juego.pipesInGame().add(pipeFin)
		pipesDelNivel.forEach({ blocks => game.addVisual(blocks)})
		obstaculosDelNivel.forEach({ blocks => game.addVisual(blocks)})
	}

	method terminar() {
		juego.deleteAllPipes()
		pipesDelNivel.forEach({ blocks => game.removeVisual(blocks)})
		obstaculosDelNivel.forEach({ blocks => game.removeVisual(blocks)})
		selector.position(game.center())
	}

}

object nivelTres {

	const pipeInicio = new InitPipe(dir = north, position = game.at(7, 3))
	const pipeFin = new EndPipe(dir = south, position = game.at(9, 7))
	const pipeFin1 = new EndPipe(dir = south, position = game.at(8, 7))
	const pipeFin2 = new EndPipe(dir = south, position = game.at(7, 7))
	const pipeFin3 = new EndPipe(dir = south, position = game.at(5, 7))
	const pipesDelNivel = [ pipeInicio, pipeFin, pipeFin1, pipeFin2, pipeFin3 ]
	var obstaculosDelNivel = []

	method crearObstaculos() {
		const obstacle1 = new Block(position = game.at(5, 3))
		const obstacle2 = new Block(position = game.at(9, 3))
		const obstacle3 = new Block(position = game.at(9, 4))
		const obstacle4 = new Block(position = game.at(5, 4))
		const obstacle5 = new Block(position = game.at(6, 7))
		obstaculosDelNivel = [ obstacle1, obstacle2, obstacle3, obstacle4, obstacle5 ]
	}

	method iniciar() {
		//
		self.crearObstaculos()
		selectorPipeTypeI.quantity(2)
		selectorPipeTypeL.quantity(5)
		selectorPipeTypeT.quantity(5)
		juego.pipesInGame().add(pipeInicio)
		juego.pipesInGame().add(pipeFin)
		juego.pipesInGame().add(pipeFin1)
		juego.pipesInGame().add(pipeFin2)
		juego.pipesInGame().add(pipeFin3)
		pipesDelNivel.forEach({ blocks => game.addVisual(blocks)})
		obstaculosDelNivel.forEach({ blocks => game.addVisual(blocks)})
	}

	method terminar() {
		juego.deleteAllPipes()
		pipesDelNivel.forEach({ blocks => game.removeVisual(blocks)})
		obstaculosDelNivel.forEach({ blocks => game.removeVisual(blocks)})
		selector.position(game.center())
	}

}

object nivelCuatro {

	const pipeInicio = new InitPipe(dir = south, position = game.at(5, 7))
	const pipeFin = new EndPipe(dir = west, position = game.at(9, 5))
	const pipeFin1 = new EndPipe(dir = west, position = game.at(8, 6))
	const pipeFin2 = new EndPipe(dir = west, position = game.at(8, 4))
	const pipesDelNivel = [ pipeInicio, pipeFin, pipeFin1, pipeFin2 ]
	var obstaculosDelNivel = []

	method crearObstaculos() {
		const obstacle1 = new Block(position = game.at(7, 7))
		const obstacle2 = new Block(position = game.at(8, 7))
		const obstacle3 = new Block(position = game.at(9, 7))
		const obstacle4 = new Block(position = game.at(9, 6))
		const obstacle5 = new Block(position = game.at(9, 4))
		const obstacle6 = new Block(position = game.at(9, 3))
		const obstacle7 = new Block(position = game.at(8, 3))
		const obstacle8 = new Block(position = game.at(7, 3))
		obstaculosDelNivel = [ obstacle1, obstacle2, obstacle3, obstacle4, obstacle5, obstacle6, obstacle7, obstacle8 ]
	}

	method iniciar() {
		//
		self.crearObstaculos()
		selectorPipeTypeI.quantity(4)
		selectorPipeTypeL.quantity(2)
		selectorPipeTypeT.quantity(2)
		juego.pipesInGame().add(pipeInicio)
		juego.pipesInGame().add(pipeFin)
		pipesDelNivel.forEach({ blocks => game.addVisual(blocks)})
		obstaculosDelNivel.forEach({ blocks => game.addVisual(blocks)})
	}

	method terminar() {
		juego.deleteAllPipes()
		pipesDelNivel.forEach({ blocks => game.removeVisual(blocks)})
		obstaculosDelNivel.forEach({ blocks => game.removeVisual(blocks)})
		selector.position(game.center())
	}

}

object nivelCinco {

	const pipeInicio = new InitPipe(dir = east, position = game.at(5, 3))
	const pipeFin = new EndPipe(dir = west, position = game.at(9, 7))
	const pipesDelNivel = [ pipeInicio, pipeFin ]
	var obstaculosDelNivel = []

	method crearObstaculos() {
		const obstacle1 = new Block(position = game.at(5, 7))
		const obstacle2 = new Block(position = game.at(5, 6))
		const obstacle3 = new Block(position = game.at(5, 5))
		const obstacle4 = new Block(position = game.at(5, 4))
		const obstacle5 = new Block(position = game.at(6, 4))
		const obstacle6 = new Block(position = game.at(7, 4))
		const obstacle7 = new Block(position = game.at(8, 4))
		const obstacle8 = new Block(position = game.at(9, 6))
		const obstacle9 = new Block(position = game.at(8, 6))
		obstaculosDelNivel = [ obstacle1, obstacle2, obstacle3, obstacle4, obstacle5, obstacle6, obstacle7, obstacle8, obstacle9 ]
	}

	method iniciar() {
		//
		self.crearObstaculos()
		selectorPipeTypeI.quantity(6)
		selectorPipeTypeL.quantity(5)
		selectorPipeTypeT.quantity(2)
		juego.pipesInGame().add(pipeInicio)
		juego.pipesInGame().add(pipeFin)
		pipesDelNivel.forEach({ blocks => game.addVisual(blocks)})
		obstaculosDelNivel.forEach({ blocks => game.addVisual(blocks)})
	}

	method terminar() {
		juego.deleteAllPipes()
		pipesDelNivel.forEach({ blocks => game.removeVisual(blocks)})
		obstaculosDelNivel.forEach({ blocks => game.removeVisual(blocks)})
		selector.position(game.center())
	}

}

