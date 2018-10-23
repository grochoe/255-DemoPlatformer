package code {
	import flash.events.KeyboardEvent;
	import flash.display.Stage;

	/**
	 * This static Class holds all of the keyboard input information that will be used though the entirity of the game
	 */
	public class KeyboardInput {

		/** publicly accessable var for if the left arrow key is pressed */
		static public var keyLeft: Boolean = false;
		/** publicly accessable var for if the up arrow key is pressed */
		static public var keyUp: Boolean = false;
		/** publicly accessable var for if the right arrow key is pressed */
		static public var keyRight: Boolean = false;
		/** publicly accessable var for if the down arrow key is pressed */
		static public var keyDown: Boolean = false;
		/** publicly accessable var for if the enter key is pressed */
		static public var keyEnter: Boolean = false;
		/** publicly accessable var for if the w key is pressed */
		static public var keyW: Boolean = false;
		/** publicly accessable var for if the a key is pressed */
		static public var keyA: Boolean = false;
		/** publicly accessable var for if the s key is pressed */
		static public var keyS: Boolean = false;
		/** publicly accessable var for if the d key is pressed */
		static public var keyD: Boolean = false;
		/** publicly accessable var for if the space key is pressed */
		static public var keySpace: Boolean = false;

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
		 * This function is called when a key is pressed
		 * @param: keyCode is the code associated with each key.
		 * based on the keycode provided, that boolean is set as isDown.
		 * @param: isDown in a boolean that sets wether the key is pressed down or not.
		 */
		static private function updateKey(keyCode: int, isDown: Boolean): void {
			if (keyCode == 13) keyEnter = isDown;
			if (keyCode == 37) keyLeft = isDown;
			if (keyCode == 38) keyUp = isDown;
			if (keyCode == 39) keyRight = isDown;
			if (keyCode == 40) keyDown = isDown;
			if (keyCode == 87) keyW = isDown;
			if (keyCode == 65) keyA = isDown;
			if (keyCode == 83) keyS = isDown;
			if (keyCode == 68) keyD = isDown;
			if (keyCode == 32) keySpace = isDown;
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
	} // end Class
} // end Package