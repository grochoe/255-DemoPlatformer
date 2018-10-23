package code {
	import flash.utils.getTimer;

	/**
	 * This is a static class
	 * it holds all of the delta time for the game to run
	 * these functions currently do not work with the game
	 */
	public class Time {
		/** hold the current delta time when set*/
		public static var dt: Number = 0;
		/** if we want to scale time we will use this scaler of delta time*/
		public static var dtScaled: Number = 0;
		/** this will help us keep track of the current delta time in milliseconds*/
		public static var time: Number = 0;
		/** this will get our scaled value*/
		public static var scale: Number = 1;
		/** this holds the previous delta time when doing calculations for the next delta time*/
		private static var timePrev: Number = 0;

		/**
		 * this function calculates delta time and the time between one frame to the next
		 * these functions currently do not work with the game
		 */
		public static function update(): void {
			time = getTimer();
			dt = (time - timePrev) / 1000;
			dtScaled = dt * scale;
			timePrev = time; // cache for next frame
		} // end update
	} // end Class
} // end Package