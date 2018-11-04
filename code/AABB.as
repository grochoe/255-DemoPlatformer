package code {
	import flash.geom.Point;
	import com.adobe.tvsdk.mediacore.events.PauseAtPeriodEnd;

	/**
	 * This Class calculates all of the AABB type collision
	 */
	public class AABB {

		/** hold the half width of the object for collision detection */
		private var halfWidth: Number;
		/** hold the half height of the object for collision detection */
		private var halfHeight: Number;
		/** the far left side of the box collision */
		public var xmin: Number;
		/** the far right side of the box collision */
		public var xmax: Number;
		/** the top of the box collision*/
		public var ymin: Number;
		/** the bottom of the box collision */
		public var ymax: Number;

		/** 
		 * This function sets up the AABB class
		 * @param halfWidth is the half width of the box being tested for collision
		 * @param halfHeight is the half height of the box being tested for collision
		 */
		public function AABB(halfWidth: Number, halfHeight: Number) {
			setSize(halfWidth, halfHeight);
		} // end AABB

		/** 
		 * This function sets the local half width and half height vars
		 * @param halfWidth gets the halfwidth for the local var
		 * @param halfHeight gets the halfHeight for the local var
		 */
		public function setSize(halfWidth: Number, halfHeight: Number): void {
			this.halfWidth = halfWidth;
			this.halfHeight = halfHeight;
			//recalulate edges!!
			calcEdges((xmin + xmax) / 2, (ymin + ymax) / 2);
		} // end setSize

		/**
		 * calculate the position of the 4 edges from the center (x,y) position.
		 */
		public function calcEdges(x: Number, y: Number): void {
			xmin = x - halfWidth;
			xmax = x + halfWidth;
			ymin = y - halfHeight;
			ymax = y + halfHeight;
		} // end calcEdges

		/**
		 * this function checks to see if this AABB is overlapping with another AABB.
		 * @param other The other AABB to check this AABB against.
		 * @return Whether or not they are overlapping.if true, they are overlapping.
		 */
		public function checkOverlap(other: AABB): Boolean {
			if (this.xmax < other.xmin) return false; // gap to the right
			if (this.xmin > other.xmax) return false; // gap to the left
			if (this.ymax < other.ymin) return false; // gap below
			if (this.ymin > other.ymax) return false; // gap apbove

			return true;
		} // end checkOverlap

		/**
		 * This function calculates how far to move THIS box so that it no longer intercects another AABB.
		 * @param other The other AABB.
		 * @return the "fix" vector - how far to move this box.
		 */
		public function findOverlapFix(other: AABB): Point {

			var moveL: Number = other.xmin - this.xmax;
			var moveR: Number = other.xmin - this.xmin;
			var moveU: Number = other.ymin - this.ymax;
			var moveD: Number = other.ymax - this.ymin;

			var fix: Point = new Point();

			fix.x = (Math.abs(moveL) < Math.abs(moveR)) ? moveL : moveR;
			fix.y = (Math.abs(moveU) < Math.abs(moveD)) ? moveU : moveD;

			if (Math.abs(fix.x) < Math.abs(fix.y)) fix.y = 0;
			else fix.x = 0;

			return fix;

		} // end findOverlapFix
	} // end Class
} //end Package