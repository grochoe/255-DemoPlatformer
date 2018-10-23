package code {

	import flash.display.MovieClip;
	import flash.events.Event;


	public class Game extends MovieClip {


		public function Game() {
			KeyboardInput.setup(stage);
			addEventListener(Event.ENTER_FRAME, gameLoop);
		} // end Game

		private function gameLoop(e: Event): void {
			Time.update();
			player.update();
			
			
			
			KeyboardInput.update(); // should be the last thing called within the gameLoop
		} //end gameLoop
	} // end Class
} //end Package