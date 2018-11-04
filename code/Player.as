﻿package code {

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
		private var gravity: Point = new Point(0, 750);
		/** this is the fastest that the player will be able to move the left and right*/
		private var maxSpeed: Number = 250; //pixals per second
		/** this will track how long the space bar has been held*/
		private var jumpTimer: Number = 0;
		/** allows th eplayer to double jump only once*/
		private var canDoubleJump: Boolean = false;
		/** this represents the ground plane, how far the player can move down in the y axis*/
		private var ground: Number;
		/** determins wheather the player is on a ground plane/platform*/
		private var isGrounded = false;
		/** is the player in the air, not on a platform*/
		private var isJumping = false;
		/** number of times left the player can jump while in the air */
		private var airJumpsLeft: int = 1;
		/** number of times the player can jump while in the air */
		private var airJumpsMax: int = 1;
		/** the velocity the player has when jumping*/
		private var jumpVelocity: Number = 400;
		/** used for collision detection with platforms*/
		public var collider: AABB;

		/** this is how fast the player can accelerate */
		private const HORIZONTAL_ACCELERATION: Number = 800;
		/**  this is how the player decelerates*/
		private const HORIZONTAL_DECELERATION: Number = 800;


		/**
		 * this function is the initial set up for Player
		 */
		public function Player() {
			collider = new AABB(width / 2, height / 2);

		} // end Player

		/**
		 * this function updates each function within the player
		 */
		public function update(): void {

			handleJump();
			handleHorzMovement();
			doPhysics();

			collider.calcEdges(x, y);
			isGrounded = false; // the allows us to walk off the edge and not longer be "grounded"
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
		 * this function moves the player and applies gravity to the player within the y axis
		 */
		private function doPhysics(): void {

			var gravityMultiplier: Number = 1;
			if (!isJumping) gravityMultiplier = 2;

			// apply gravity to velocity:
			//velocity.x += gravity.x * Time.dt;
			velocity.y += gravity.y * Time.dt * gravityMultiplier;

			//clamp to max speed
			if (velocity.x > maxSpeed) velocity.x = maxSpeed;
			if (velocity.x < -maxSpeed) velocity.x = -maxSpeed;

			//apply velocity to position:
			x += velocity.x * Time.dt;
			y += velocity.y * Time.dt;
		} // end doPhysics

		/**
		 * this function checks if the player is able to jump when the space key is pushed
		 */
		private function handleJump(): void {
			if (KeyboardInput.onKeyDown(Keyboard.SPACE)) {
				if (isGrounded) {
					velocity.y = -jumpVelocity; //apply an impulse up
					isGrounded = false;
					isJumping = true;
				} else {
					if (airJumpsLeft > 0) {
						velocity.y = -jumpVelocity;
						airJumpsLeft--;
						isJumping = true;
					} //end if
				} //end else
			} //end if

			if (!KeyboardInput.isKeyDown(Keyboard.SPACE)) isJumping = false;
			if (velocity.y > 0) isJumping = false;
		} // end checkJump

		/**
		 * this function fixes the players position when colling with another platform object
		 * and stops its velocity in that direction
		 */
		public function applyFix(fix: Point): void {
			if (fix.x != 0) {
				x += fix.x;
				velocity.x = 0;
			}
			if (fix.y != 0) {
				y += fix.y;
				velocity.y = 0;
			}
			if (fix.y < 0) { //we movedd the player UP, so they are on the ground
				isGrounded = true;
				airJumpsLeft = airJumpsMax;
			}
			collider.calcEdges(x, y);
		}
	} //end Class
} // end Package