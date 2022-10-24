import wollok.game.*
import Selector.*
import Textos.*
import Juego.*
import dir.*

class Block {

	const property position

	method blocked() = true

	method image() {
		return "default.png"
	}

}

class Pipe inherits Block {

	const property dir

	method connected() {
		return self.connectionDetected()
	}

	method connectionDetected() {
		return dir.bloquePorDelante(position)
	}

}

class InitPipe inherits Pipe {

	const property name = "initPipe_"

	override method image() {
		return self.selectedPipe()
	}

	method selectedPipe() {
		return self.name() + dir.name() + ".png"
	// type + dir + .png
	}

}

class EndPipe inherits Pipe {

	const property name = "endPipe_"

	override method image() {
		return self.selectedPipe()
	}

	method selectedPipe() {
		return self.name() + dir.name() + ".png"
	// type + dir + .png
	}

}

class CrozablePipe inherits Pipe { //se pueden atravezar

	override method blocked() = false
	
}

class PipeTypeI inherits CrozablePipe {

	// [n,e,s,w]
	override method connectionDetected() {
		if (dir.equals(north) || dir.equals(south)) {
			return north.bloquePorDelante(position) && south.bloquePorDelante(position)
		} else {
			return east.bloquePorDelante(position) && west.bloquePorDelante(position)
		}
	}

	method increaseSelectorPipe() {
		selectorPipeTypeI.increase()
	}
	
	override method image(){
		return 'pipeTypeI_' + dir.name() + '.png'
	}

}

class PipeTypeL inherits CrozablePipe {

	// [n,e,s,w]
	override method connectionDetected() {
		if (dir.equals(north)) { // N
			return east.bloquePorDelante(position) && south.bloquePorDelante(position)
		} else if (dir.equals(east)) { // E
			return north.bloquePorDelante(position) && east.bloquePorDelante(position)
		} else if (dir.equals(south)) { // S
			return north.bloquePorDelante(position) && west.bloquePorDelante(position)
		} else { // W
			return west.bloquePorDelante(position) && south.bloquePorDelante(position)
		}
	}

	method increaseSelectorPipe() {
		selectorPipeTypeL.increase()
	}
	
	override method image(){
		return 'pipeTypeL_' + dir.name() + '.png'
	}

}

class PipeTypeT inherits CrozablePipe {

	override method connectionDetected() {
		if (dir.equals(north)) { // N
			return east.bloquePorDelante(position) && west.bloquePorDelante(position) && north.bloquePorDelante(position)
		} else if (dir.equals(east)) { // E
			return east.bloquePorDelante(position) && south.bloquePorDelante(position) && north.bloquePorDelante(position)
		} else if (dir.equals(south)) { // S
			return east.bloquePorDelante(position) && west.bloquePorDelante(position) && south.bloquePorDelante(position)
		} else { // W
			return south.bloquePorDelante(position) && west.bloquePorDelante(position) && north.bloquePorDelante(position)
		}
	}

	method increaseSelectorPipe() {
		selectorPipeTypeT.increase()
	}
	
	override method image(){
		return 'pipeTypeT_' + dir.name() + '.png'
	}

}



