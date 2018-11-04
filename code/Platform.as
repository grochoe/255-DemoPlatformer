package code {

	import flash.display.MovieClip;

	/**
	 * This Class handles all the platform pieces that the player can land on
	 */
	public class Platform extends MovieClip {
		/** this sets up the colliding edges and checks them agains the player */
		public var collider: AABB;

		public function Platform() {
			collider = new AABB(width / 2, height / 2);
			collider.calcEdges(x, y);

			//add to array of platforms
			Game.platforms.push(this);
		}
	}

}