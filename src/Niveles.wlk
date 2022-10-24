import wollok.game.*
import Bloques.*
import Juego.*
import Textos.*
import Selector.*
import dir.*

object nivelUno {

	const pipeInicio = new InitPipe(dir = north, position = game.at(5, 3))
	const pipeFin = new EndPipe(dir = south, position = game.at(9, 7))

	method iniciar() {
		//
		selectorPipeTypeI.quantity(10)
		selectorPipeTypeL.quantity(10)
		selectorPipeTypeT.quantity(10)
		juego.pipesInGame().add(pipeInicio)
		juego.pipesInGame().add(pipeFin)
		game.addVisual(pipeInicio)
		game.addVisual(pipeFin)
	}

	method terminar() {
		juego.pipesInGame().remove(pipeInicio)
		juego.pipesInGame().remove(pipeFin)
		game.removeVisual(pipeInicio)
		game.removeVisual(pipeFin)
	}

}

object nivelDos {

	const pipeInicio = new InitPipe(dir = north, position = game.at(5, 3))
	const pipeFin = new EndPipe(dir = south, position = game.at(9, 7))

	method iniciar() {
		//
		selectorPipeTypeI.quantity(10)
		selectorPipeTypeL.quantity(10)
		selectorPipeTypeT.quantity(10)
		juego.pipesInGame().add(pipeInicio)
		juego.pipesInGame().add(pipeFin)
		game.addVisual(pipeInicio)
		game.addVisual(pipeFin)
	}

	method terminar() {
		juego.pipesInGame().remove(pipeInicio)
		juego.pipesInGame().remove(pipeFin)
		game.removeVisual(pipeInicio)
		game.removeVisual(pipeFin)
	}

}

object nivelTres {

	const pipeInicio = new InitPipe(dir = north, position = game.at(5, 3))
	const pipeFin = new EndPipe(dir = south, position = game.at(9, 7))

	method iniciar() {
		//
		selectorPipeTypeI.quantity(10)
		selectorPipeTypeL.quantity(10)
		selectorPipeTypeT.quantity(10)
		juego.pipesInGame().add(pipeInicio)
		juego.pipesInGame().add(pipeFin)
		game.addVisual(pipeInicio)
		game.addVisual(pipeFin)
	}

	method terminar() {
		juego.pipesInGame().remove(pipeInicio)
		juego.pipesInGame().remove(pipeFin)
		game.removeVisual(pipeInicio)
		game.removeVisual(pipeFin)
	}

}

object nivelCuatro {

	const pipeInicio1 = new InitPipe(dir = north, position = game.at(5, 3))
	const pipeFin1 = new EndPipe(dir = west, position = game.at(8, 4))
	const pipeFin2 = new EndPipe(dir = west, position = game.at(9, 5))
	const pipeFin3 = new EndPipe(dir = west, position = game.at(8, 6))
	const staticPipeT = new PipeTypeT(dir = east, position = game.at(6,5))
	
	method iniciar() {
		//
		selectorPipeTypeI.quantity(10)
		selectorPipeTypeL.quantity(10)
		selectorPipeTypeT.quantity(10)
		juego.pipesInGame().add(pipeInicio1)
		juego.pipesInGame().add(pipeFin1)
		juego.pipesInGame().add(pipeFin2)
		juego.pipesInGame().add(pipeFin3)
		juego.pipesInGame().add(staticPipeT)
		game.addVisual(pipeInicio1)
		game.addVisual(pipeFin1)
		game.addVisual(pipeFin2)
		game.addVisual(pipeFin3)
		game.addVisual(staticPipeT)
		
	}

	method terminar() {
		juego.pipesInGame().remove(pipeInicio1)
		juego.pipesInGame().remove(pipeFin1)
		juego.pipesInGame().remove(pipeFin2)
		juego.pipesInGame().remove(pipeFin3)
		juego.pipesInGame().remove(staticPipeT)
		game.removeVisual(pipeInicio1)
		game.removeVisual(pipeFin1)
		game.removeVisual(pipeFin2)
		game.removeVisual(pipeFin3)
		game.removeVisual(staticPipeT)
	}

	method createInitPipes(){
		
	}
	
	method createEndPipes(){
		
	}
	
	method createStaticPipes(){
		
	}
}

object nivelCinco {

	const pipeInicio = new InitPipe(dir = north, position = game.at(5, 3))
	const pipeFin = new EndPipe(dir = south, position = game.at(9, 7))

	method iniciar() {
		//
		selectorPipeTypeI.quantity(10)
		selectorPipeTypeL.quantity(10)
		selectorPipeTypeT.quantity(10)
		juego.pipesInGame().add(pipeInicio)
		juego.pipesInGame().add(pipeFin)
		game.addVisual(pipeInicio)
		game.addVisual(pipeFin)
	}

	method terminar() {
		juego.pipesInGame().remove(pipeInicio)
		juego.pipesInGame().remove(pipeFin)
		game.removeVisual(pipeInicio)
		game.removeVisual(pipeFin)
	}

}
