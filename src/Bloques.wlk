import wollok.game.*
import Selector.*
import Textos.*
import Juego.*
import dir.*

class Block {

	const property position

	method blocked() = true
	
	method connectable() = false
	
	method image() {
		return "Obstacle.png"
	}

}

class Pipe inherits Block {

	const property dir
	
	override method connectable() = true
	
	method connected() {
		return self.connectionDetected()
	}

	method connectionDetected() {
		return dir.hayConexion(position)
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
			return north.hayConexion(position) && south.hayConexion(position)
		} else {
			return east.hayConexion(position) && west.hayConexion(position)
		}
	}

	method increaseSelectorPipe() {
		selectorPipeTypeI.increase()
	}

	override method image() {
		return 'pipeTypeI_' + dir.name() + '.png'
	}

}

class PipeTypeL inherits CrozablePipe {

	// [n,e,s,w]
	override method connectionDetected() {
		if (dir.equals(north)) { // N
			return east.hayConexion(position) && south.hayConexion(position)
		} else if (dir.equals(east)) { // E
			return north.hayConexion(position) && east.hayConexion(position)
		} else if (dir.equals(south)) { // S
			return north.hayConexion(position) && west.hayConexion(position)
		} else { // W
			return west.hayConexion(position) && south.hayConexion(position)
		}
	}

	method increaseSelectorPipe() {
		selectorPipeTypeL.increase()
	}

	override method image() {
		return 'pipeTypeL_' + dir.name() + '.png'
	}

}

class PipeTypeT inherits CrozablePipe {

	override method connectionDetected() {
		if (dir.equals(north)) { // N
			return east.hayConexion(position) && west.hayConexion(position) && north.hayConexion(position)
		} else if (dir.equals(east)) { // E
			return east.hayConexion(position) && south.hayConexion(position) && north.hayConexion(position)
		} else if (dir.equals(south)) { // S
			return east.hayConexion(position) && west.hayConexion(position) && south.hayConexion(position)
		} else { // W
			return south.hayConexion(position) && west.hayConexion(position) && north.hayConexion(position)
		}
	}

	method increaseSelectorPipe() {
		selectorPipeTypeT.increase()
	}

	override method image() {
		return 'pipeTypeT_' + dir.name() + '.png'
	}

}

