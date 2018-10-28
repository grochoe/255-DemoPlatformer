package code {

	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.display.Stage;


	/**
	 * This Class handles anything that the player has to do within the game
	 */
	public class Player extends MovieClip {
		/** this will be used to move the player and effect the velocity of the player*/
		private var velocity: Point = new Point(1, 5);
		/** this will be what forces the player down and adds gravity to the platform*/
		private var gravity: Point = new Point(0, 100);
		/** this is the fastest that the player will be able to move the left and right*/
		private var maxSpeed: Number = 250; //pixals per second
		/** this will track how long the space bar has been held*/
		private var jumpTimer: Number = 0;
		/** allows th eplayer to double jump only once*/
		private var canDoubleJump: Boolean = false;
		/** this represents the ground plane, how far the player can move down in the y axis*/
		private var ground: Number;
		/** this is how fast the player can accelerate */
		private const HORIZONTAL_ACCELERATION: Number = 800;
		/**  this is how the player decelerates*/
		private const HORIZONTAL_DECELERATION: Number = 800;

		/**
		 * this function is the initial set up for Player
		 */
		public function Player() {
			// constructor code

		} // end Player

		/**
		 * this function updates each function within the player
		 */
		public function update(): void {
			checkJump();
			handleHorzMovement();
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

		/**
		 * this function compairs the ground with the player and makes sure the player never goes beyond the ground plane
		 */
		private function detectGround(): void {
			// look at y position
			ground = 350
			if (y > ground) {
				y = ground; // clamp
				velocity.y = 0;
			} // end if
		} // end detectGround

		/**
		 * this function moves the player and applies gravity to the player within the y axis
		 */
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



		/**
		 * this function makes the player jump up in the y axis
		 */
		private function playerJump(): void {
			trace("jump");
			y -= jumpTimer;
		}

		/**
		 * this function checks if the player is able to jump when the space key is pushed
		 */
		private function checkJump(): void {
			if (KeyboardInput.onKeyDown(Keyboard.SPACE)) {
				//trace("jump");
				//jumpTimer = 0;
			} // end if
			if (KeyboardInput.isKeyDown(Keyboard.SPACE)) {
				if (jumpTimer < 100) {
					jumpTimer += Time.dt * 200;
				} // end if
			} // end if
			//trace(jumpTimer);

			if (KeyboardInput.onKeyUp(Keyboard.SPACE)) {
				//trace("New Jump");
				if (y == ground) {
					canDoubleJump = true;
					playerJump();
					jumpTimer = 0;
				} else if (y != ground && canDoubleJump) {
					canDoubleJump = false;
					playerJump();
					jumpTimer = 0;
				} // end if
			} // end if
		} // end checkJump
	} //end Class
} // end Package