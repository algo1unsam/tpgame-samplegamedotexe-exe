import wollok.game.*
import Bloques.*
import Juego.*
import Textos.*

object nivel{
	method uno(){
		const pipeInicio = new Pipe(position = game.at(5, 3), image = "initPipe_N.png", indexDirection = 0)
		const pipeFin = new Pipe(position = game.at(9, 7), image = "endPipe_S.png", indexDirection = 2)
		juego.pipesInGame().add(pipeInicio)
		juego.pipesInGame().add(pipeFin)
		game.addVisual(pipeInicio)
		game.addVisual(pipeFin)
	}
}
