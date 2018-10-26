package code {

	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
		import flash.display.Stage;

	public class Player extends MovieClip {


		private var velocity: Point = new Point(1, 5);
		private var gravity: Point = new Point(0, 100);
		private var maxSpeed: Number = 250; //pixals per second
		private var jumpTimer: Number = 0;
		private var canDoubleJump: Boolean = false;
		private const HORIZONTAL_ACCELERATION: Number = 800;
		private const HORIZONTAL_DECELERATION: Number = 800;


		public function Player() {
			// constructor code

		} // end Player

		public function update(): void {

			if (KeyboardInput.onKeyDown(Keyboard.SPACE)) {
				trace("jump");
				jumpTimer = 0;
			}



			handleHorzMovement()
			doPhysics();
			detectGround();
		} // end update

		/**
		 * this function looks at the keyboard input in order to accelerate the player left or right.
		 * this function changes the player's velocity
		 */
		private function handleHorzMovement(): void {
			if (KeyboardInput.isKeyDown(Keyboard.A)) velocity.x -= HORIZONTAL_ACCELERATION * Time.dt;
			if (KeyboardInput.isKeyDown(Keyboard.D)) velocity.x += HORIZONTAL_ACCELERATION * Time.dt;

			if (!KeyboardInput.isKeyDown(Keyboard.A) && !KeyboardInput.isKeyDown(Keyboard.D)) {
				if (velocity.x < 0) {
					//moving left
					velocity.x += HORIZONTAL_DECELERATION * Time.dt;
					if (velocity.x > 0) velocity.x = 0;
				} // end if
				if (velocity.x > 0) {
					// moving right
					velocity.x -= HORIZONTAL_DECELERATION * Time.dt;
					if (velocity.x < 0) velocity.x = 0;
				} // end if
			} // end if

		} // end handleHorzMovement
		private function detectGround(): void {
			// look at y position
			var ground: Number = 350
			if (y > ground) {
				y = ground; // clamp
				velocity.y = 0;
			} // end if
		} // end detectGround

		private function doPhysics(): void {
			// apply gravity to velocity:
			velocity.x += gravity.x * Time.dt;
			velocity.y += gravity.y * Time.dt;

			//clamp to max speed
			if (velocity.x > maxSpeed) velocity.x = maxSpeed;
			if (velocity.x < -maxSpeed) velocity.x = -maxSpeed;

			//apply velocity to position:
			x += velocity.x * Time.dt;
			y += velocity.y * Time.dt;
		} // end doPhysics

		public function handleMouseUp(e: MouseEvent): void {
			//if needed
			trace("working");
		}

		public function handleMouseDown(e: MouseEvent): void {
			jumpTimer++;
			trace(jumpTimer);
		}

	} //end Class
} // end Package