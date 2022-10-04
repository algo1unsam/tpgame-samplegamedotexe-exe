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
object bloque {

	var property position = game.center() // necesito definir el property para tener el getter
	var property image = "guyN.png"
	const property brujula = [ true, false, false, false ] // [N,E,S,W]

//	method rotateRight(){
//		/*
//		 * lo que explico el profe para hacer esto es que pueda hacer un shifteo en binario
//		 * lo mejor que puedo hacer es desarrollaro un algoritmo que cambie la posicion de la lista
//		 * 
//		*/
//		
//		//shifteo la brujula -> [false, true, false, false]
//		//update del image
//		self.shiftRight()
//		self.image("guyE.png")
//		
//		
//	}
	method rotateLeft() {
	}

	method shiftLeft() {
		
	}

//	method shiftRight(){
//		const aux = []
//		if (brujula.last())
//			brujula.reverse()
//		else
//			aux.add(brujula.subList(0,2))
//			brujula.clear()
//			brujula.add(false)
//			brujula.add(aux)
//			
//	}
}

object juego {

	method iniciar() {
		game.title("Juego Base")
		game.width(5)
		game.height(5)
		game.cellSize(50)
		game.addVisualCharacter(bloque)
		game.start()
		self.consultaBloqueRotacion()
	}

	method consultaBloqueRotacion() {
		// we ask the block rotate
		// esto lo tiene que hacer el objeto, y no el juego
		// el juego corrobora que esten las condiciones para abrir, cerrar, inicio, fin
		// nivel completado, nivel finalizado
		keyboard.q().onPressDo{ bloque.image("guyW.png")} // shift left
		keyboard.e().onPressDo{ bloque.image("guyE.png")} // shift rigt		
	}

}

