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
		public var friction:Point      = new Point(0, 0);
		public var maxVelocity:Point   = new Point(0, 0);
		public var gravity:Point       = new Point(0, 0);
		
		public var onGround:Boolean = false;
		public var facing:uint = RIGHT;
		public var solid:String = "solid";
		
		public function PhysicsEntity()
		{
		}
		
		override public function update():void
		{
			applyAcceleration();
			applyVelocity();
			
			onGround = false;
			if (collide(solid, x, y + 1))
				onGround = true;
			
			applyGravity();
			applyFriction();
			checkMaxVelocity();
			super.update();
		}
		
		public function applyGravity():void
		{
			//increase velocity based on gravity
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
		
		private function applyFriction():void
		{
			// If we're on the ground, apply friction
			if (onGround)
			{
				if (velocity.x > 0)
				{
					velocity.x -= friction.x;
					if (velocity.x < 0)
					{
						velocity.x = 0;
					}
				}
				if (velocity.x < 0)
				{
					velocity.x += friction.x;
					if (velocity.x > 0)
					{
						velocity.x = 0;
					}
				}
			}
		}
		
		private function applyVelocity():void
		{
			var i:int;
			
			for (i = 0; i < Math.abs(velocity.x); i++)
			{
				if (collide(solid, x + FP.sign(velocity.x), y))
				{
					velocity.x = 0;
					break;
				}
				else
				{
					x += FP.sign(velocity.x);
				}
			}
			
			for (i = 0; i < Math.abs(velocity.y); i++)
			{
				if (collide(solid, x, y + FP.sign(velocity.y)))
				{
					velocity.y = 0;
					break;
				}
				else
				{
					y += FP.sign(velocity.y);
				}
			}
		}
		
	}

}