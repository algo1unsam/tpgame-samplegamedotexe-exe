import wollok.game.*
import Bloques.*
import Textos.*
import Niveles.*


object juego {

	const property pipeType = [ {self.colocarPipeTypeI()}, {self.colocarPipeTypeL()}, {self.colocarPipeTypeT()} ]
	const property activePipes = []
	const property pipesInGame = []
	var property quantityPipeI = 5
	var property quantityPipeL = 2
	var property quantityPipeT = 0
	const property pipeReduction = [ {quantityPipeI=quantityPipeI-1}, {quantityPipeL=quantityPipeL-1}, {quantityPipeT=quantityPipeT-1} ]
	const property pipeAddition = [ {quantityPipeI=quantityPipeI+1}, {quantityPipeL=quantityPipeL+1}, {quantityPipeT=quantityPipeT+1} ]
	const property pipeQuantity = [ {self.quantityPipeI()}, {self.quantityPipeL()}, {self.quantityPipeT()} ]


	method colocarPipe() {
		if (self.pipeQuantity().get(selector.indexPipe()).apply() > 0) {
			if (self.notUnderSelector()) {
				self.pipeReduction().get(selector.indexPipe()).apply()
				self.pipeType().get(selector.indexPipe()).apply()
				self.win()
			}
		}
	}

	method colocarPipeTypeI() {
		const newPipe = new PipeTypeI(position = selector.position().clone(), image = selector.selectedPipe(), indexDirection = selector.indexDirection(), indexPipe = 0)
		self.activePipes().add(newPipe)
		self.pipesInGame().add(newPipe)
		game.addVisual(newPipe)
	}

	method colocarPipeTypeL() {
		const newPipe = new PipeTypeL(position = selector.position().clone(), image = selector.selectedPipe(), indexDirection = selector.indexDirection(), indexPipe = 1)
		self.activePipes().add(newPipe)
		self.pipesInGame().add(newPipe)
		game.addVisual(newPipe)
	}

	method colocarPipeTypeT() {
		const newPipe = new PipeTypeT(position = selector.position().clone(), image = selector.selectedPipe(), indexDirection = selector.indexDirection(), indexPipe = 2)
		self.activePipes().add(newPipe)
		self.pipesInGame().add(newPipe)
		game.addVisual(newPipe)
	}

	method deleteLastPipe() {
		if (not self.isActivePipesEmpty()) {
			self.pipeAddition().get(activePipes.last().indexPipe()).apply()
			game.removeVisual(activePipes.last())
			activePipes.remove(activePipes.last())
		}
	}

	method deleteOverPipe() {
		if (not self.notUnderSelector()) {
			self.pipeAddition().get(game.colliders(selector).last().indexPipe()).apply()
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
			mario.felicitar()
		}
	}

	method winCondition() {
		var winingCondition = true
		self.pipesInGame().forEach({ pipe => winingCondition = winingCondition && pipe.connected()})
		return winingCondition
	}
	
}