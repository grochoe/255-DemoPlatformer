package code {

	import flash.display.MovieClip;
	import flash.geom.Point;


	public class Player extends MovieClip {


		private var velocity: Point = new Point(1, 5);
		private var gravity: Point = new Point(0, 100);
		private var maxSpeed:Number = 250; //pixals per second
		private const HORIZONTAL_ACCELERATION: Number = 800;
		private const HORIZONTAL_DECELERATION: Number = 800;

		public function Player() {
			// constructor code
		} // end Player

		public function update(): void {
			if (KeyboardInput.keyLeft) velocity.x -= HORIZONTAL_ACCELERATION * Time.dt;
			if (KeyboardInput.keyRight) velocity.x += HORIZONTAL_ACCELERATION * Time.dt;

			if (!KeyboardInput.keyLeft && !KeyboardInput.keyRight) {
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

			doPhysics();
			detectGround();
		} // end update

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
		}

	} //end Class
} // end Package