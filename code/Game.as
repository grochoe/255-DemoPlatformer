package code {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;

	/**
	 * This Class handles the main game
	 */
	public class Game extends MovieClip {

		static public var platforms: Array = new Array;

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

			doCollisionDetection();


			KeyboardInput.update(); // should be the last thing called within the gameLoop
		} //end gameLoop

		private function doCollisionDetection(): void {

			for (var i: int = 0; i < platforms.length; i++) {
				if (player.collider.checkOverlap(platforms[i].collider)) { // if overlapping
					//find the fix:
					var fix: Point = player.collider.findOverlapFix(platforms[i].collider);
					//apply the fix:
					player.applyFix(fix);

				}//end if


			}// end for

		}// end doCollisionoDetection
	} // end Class
} //end Package