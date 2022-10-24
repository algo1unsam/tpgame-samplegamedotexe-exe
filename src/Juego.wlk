import wollok.game.*
import Textos.*
import Niveles.*
import dir.*
import Bloques.*
import Selector.*

object juego {
	
	const property activePipes = []
	const property pipesInGame = []
	var property recentLevel = nivelCuatro
	
	method colocarPipe() {
		if (self.pipeQuantity() > 0) {
			if (self.notUnderSelector()) {
				self.decreasePipeQuantity()
				selector.createNewPipe()
				self.win()
			}
		}
	}
	
	method pipeQuantity(){
		return selector.recentPipe().quantity()
	}
	
	method increasePipeQuantity(){
		selector.recentPipe().increase()
	}
	method decreasePipeQuantity(){
		selector.recentPipe().decrease()
	}
	
	method addNewPipe(newPipe){
		self.activePipes().add(newPipe)
		self.pipesInGame().add(newPipe)
		game.addVisual(newPipe)
	}
	

	method deleteLastPipe() {
		if (not self.isActivePipesEmpty()) {
			//
			activePipes.last().increaseSelectorPipe()
			//
			game.removeVisual(activePipes.last())
			activePipes.remove(activePipes.last())
		}
	}

	method deleteOverPipe() {
		if (not self.notUnderSelector()) {
			game.colliders(selector).last().increaseSelectorPipe()
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


	method win() {
		if (self.winCondition()) {
			mario.felicitar()
		}
	}

	method winCondition() {
		var winingCondition = true
		self.pipesInGame().forEach({ pipe => winingCondition = winingCondition && pipe.connected()})
		return winingCondition
	}
	
}