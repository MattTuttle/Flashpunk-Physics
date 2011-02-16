package com.matttuttle
{
	
	// Example character class using simple physics
	public class Character extends PhysicsEntity
	{
		
		private static const kMoveSpeed:uint = 60;
		private static const kJumpSpeed:uint = 600;
		
		public function Character(_x:int, _y:int)
		{
			x = _x;
			y = _y;
			
			graphic = sprite;
			setHitbox(32, 32);
			
			// Set physics properties
			gravity.y = 40;
			maxVelocity.y = 600;
			maxVelocity.x = 400;
			drag.x = drag.y = 25;
			
			// Define input keys
			Input.define("left", Key.A, Key.LEFT);
			Input.define("right", Key.D, Key.RIGHT);
			Input.define("jump", Key.W, Key.SPACE, Key.UP);
		}
		
		override public function update():void
		{
			acceleration.x = acceleration.y = 0;
			
			if (Input.check("left"))
				acceleration.x = -kMoveSpeed;
			
			if (Input.check("right"))
				acceleration.x = kMoveSpeed;
			
			if (Input.pressed("jump") && onGround)
				velocity.y = -kJumpSpeed;
			
			super.update();
		}
		
	}

}