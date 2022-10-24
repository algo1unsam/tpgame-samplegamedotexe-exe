import wollok.game.*
import Selector.*
import Textos.*
import Juego.*
import dir.*

class Block {

	const property position

	method blocked() = true

	method image() {
		return "Obstacle.png"
	}

}

class Pipe inherits Block {

	const property dir

	method connected() {
		return self.connectionDetected()
	}

	method connectionDetected() {
		return dir.hayBloquePorDelante(position)
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
			return north.hayBloquePorDelante(position) && south.hayBloquePorDelante(position)
		} else {
			return east.hayBloquePorDelante(position) && west.hayBloquePorDelante(position)
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
			return east.hayBloquePorDelante(position) && south.hayBloquePorDelante(position)
		} else if (dir.equals(east)) { // E
			return north.hayBloquePorDelante(position) && east.hayBloquePorDelante(position)
		} else if (dir.equals(south)) { // S
			return north.hayBloquePorDelante(position) && west.hayBloquePorDelante(position)
		} else { // W
			return west.hayBloquePorDelante(position) && south.hayBloquePorDelante(position)
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
			return east.hayBloquePorDelante(position) && west.hayBloquePorDelante(position) && north.hayBloquePorDelante(position)
		} else if (dir.equals(east)) { // E
			return east.hayBloquePorDelante(position) && south.hayBloquePorDelante(position) && north.hayBloquePorDelante(position)
		} else if (dir.equals(south)) { // S
			return east.hayBloquePorDelante(position) && west.hayBloquePorDelante(position) && south.hayBloquePorDelante(position)
		} else { // W
			return south.hayBloquePorDelante(position) && west.hayBloquePorDelante(position) && north.hayBloquePorDelante(position)
		}
	}

	method increaseSelectorPipe() {
		selectorPipeTypeT.increase()
	}
	
	override method image(){
		return 'pipeTypeT_' + dir.name() + '.png'
	}

}



