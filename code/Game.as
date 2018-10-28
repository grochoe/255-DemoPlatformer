package code {

	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * This Class handles the main game
	 */
	public class Game extends MovieClip {

		/**
		 * This function is the main Game set up
		 */
		public function Game() {
			KeyboardInput.setup(stage);
			addEventListener(Event.ENTER_FRAME, gameLoop);

		} // end Game

		/**
		 * This function is the main game loop
		 */
		private function gameLoop(e: Event): void {

			Time.update();
			player.update();



			KeyboardInput.update(); // should be the last thing called within the gameLoop
		} //end gameLoop


	} // end Class
} //end Package