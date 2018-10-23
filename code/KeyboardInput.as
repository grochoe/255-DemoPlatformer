package code {
	import flash.events.KeyboardEvent;
	import flash.display.Stage;

	/**
	 * This static Class holds all of the keyboard input information that will be used though the entirity of the game
	 */
	public class KeyboardInput {

		static public var keyState:Array = new Array();
		static public var keyPrevState:Array = new Array();
		

		/**
		 * This function sets up the event listeners to know when each of the keys are being pressed
		 * this is set up to be called into action as these buttons are pressed throughout the game.
		 * @param: stage is a Stage object that will use event listeners to know when keys are being pressed
		 */
		static public function setup(stage: Stage) {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
		} // end setup
		
		/**
		* this function's job is to cashe all of the key values, for the NEXT frame. 
		*/
		static public function update(): void {
			keyPrevState = keyState.slice(); // in this context, slice() gives us a copy of the array
		}

		/**
		 * This function is called when a key is pressed
		 * @param: keyCode is the code associated with each key.
		 * based on the keycode provided, that boolean is set as isDown.
		 * @param: isDown in a boolean that sets wether the key is pressed down or not.
		 */
		static private function updateKey(keyCode: int, isDown: Boolean): void {
				keyState[keyCode] = isDown;
			} // end updateKey

		/**
		 * This function is called when a key is pressed on the keyboard
		 * @param:e is a keyboard event that will be used in the updateKey function.
		 * It also will set isDown as true;
		 */
		static private function handleKeyDown(e: KeyboardEvent): void {
			//trace(e.keyCode);
			updateKey(e.keyCode, true);
		} // end handleKeyDown

		/**
		 * This function is called when a key is pressed on the keyboard
		 * @param:e is a keyboard event that will be used in the updateKey function.
		 * It also will set isDown as false;
		 */
		static private function handleKeyUp(e: KeyboardEvent): void {
			updateKey(e.keyCode, false);
		} // end handleKeyUp
		
		static public function isKeyDown(keyCode:int):Boolean {
			if (keyCode < 0) return false;
			if (keyCode >= keyState.length) return false;
			return keyState[keyCode];
		}// end isKeyDown
		
		static public function onKeyDown(keyCode:int):Boolean {
			if (keyCode < 0) return false;
			if (keyCode >= keyState.length) return false;
			return (keyState[keyCode] && !keyPrevState[keyCode]);
		}// end onKeyDown
	} // end Class
} // end Package