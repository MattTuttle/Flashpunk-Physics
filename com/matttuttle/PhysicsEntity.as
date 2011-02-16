package com.matttuttle
{
	import flash.geom.Point;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	
	public class PhysicsEntity extends Entity
	{
		public static const LEFT:uint  = 0;
		public static const RIGHT:uint = 1;
		public static const UP:uint    = 2;
		public static const DOWN:uint  = 3;
		
		// Define variables
		public var velocity:Point      = new Point(0, 0);
		public var acceleration:Point  = new Point(0, 0);
		public var drag:Point          = new Point(0, 0);
		public var maxVelocity:Point   = new Point(0, 0);
		public var gravity:Point       = new Point(0, 0);
		
		public var onGround:Boolean = false;
		public var onWall:Boolean = false;
		public var facing:uint = LEFT;
		public var solid:String = "solid";
		
		public function Physics() 
		{
		}
		
		override public function update():void
		{
			applyGravity();
			applyAcceleration();
			applyDrag();
			applyVelocity();
			super.update();
		}
		
		public function applyGravity():void
		{
			velocity.x += gravity.x;
			velocity.y += gravity.y;
		}
		
		private function applyAcceleration():void
		{
			// X-Axis
			if (acceleration.x != 0)
			{
				velocity.x += acceleration.x;
			}
			
			// Y-Axis
			if (acceleration.y != 0)
			{
				velocity.y += acceleration.y;
			}
		}
		
		private function checkMaxVelocity():void
		{
			if (maxVelocity.x)
			{
				if (Math.abs(velocity.x) > maxVelocity.x)
				{
					velocity.x = maxVelocity.x * FP.sign(velocity.x);
				}
			}
			
			if (maxVelocity.y)
			{
				if (Math.abs(velocity.y) > maxVelocity.y)
				{
					velocity.y = maxVelocity.y * FP.sign(velocity.y);
				}
			}
		}
		
		private function applyDrag():void
		{
			if (onGround)
			{
				var d:Number = drag.x * FP.elapsed;
				if (velocity.x - d > 0)
				{
					velocity.x -= d;
				}
				else if (velocity.x + d < 0)
				{
					velocity.x += d;
				}
				else
				{
					velocity.x = 0;
				}
			}
			
			// Apply Y drag??
		}
		
		private function applyVelocity():void
		{
			var i:int;
			
			checkMaxVelocity();
			
			for (i = 0; i < Math.abs(velocity.x * FP.elapsed); i++)
			{
				if (collide(solid, x + FP.sign(velocity.x), y))
				{
					velocity.x = 0;
				}
				else
				{
					x += FP.sign(velocity.x);
				}
			}
			
			for (i = 0; i < Math.abs(velocity.y * FP.elapsed); i++)
			{
				if (collide(solid, x, y + FP.sign(velocity.y)))
				{
					velocity.y = 0;
				}
				else
				{
					y += FP.sign(velocity.y);
				}
			}
		}
		
	}

}