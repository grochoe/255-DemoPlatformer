package code {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;


	public class Game extends MovieClip {


		public function Game() {
			KeyboardInput.setup(stage);
			addEventListener(Event.ENTER_FRAME, gameLoop);
			addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
		} // end Game

		private function gameLoop(e: Event): void {
			
			Time.update();
			player.update();
			
			
			
			KeyboardInput.update(); // should be the last thing called within the gameLoop
		} //end gameLoop
				public function handleMouseUp(e: MouseEvent): void {
			//if needed
			trace("working");
		}

		public function handleMouseDown(e: MouseEvent): void {
			trace("jumpTimer++");
		}

	} // end Class
} //end Package