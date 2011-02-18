package com.matttuttle
{
	
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	
	// Example character class using simple physics
	public class Character extends PhysicsEntity
	{
		
		private var sprite:Spritemap = new Spritemap(Assets.GfxCharacter, 32, 32);
		
		private static const kMoveSpeed:uint = 5;
		private static const kJumpForce:uint = 25;
		
		public function Character(x:int, y:int)
		{
			this.x = x;
			this.y = y;
			
			sprite.add("right_idle", [0, 0, 0, 1], 0.1, true);
			sprite.add("right_walk", [2, 3, 4], 0.25, true);
			sprite.add("right_jump", [5]);
			
			sprite.add("left_idle", [6, 6, 6, 7], 0.1, true);
			sprite.add("left_walk", [8, 9, 10], 0.25, true);
			sprite.add("left_jump", [11]);

			graphic = sprite;
			setHitbox(32, 32);

			// Set physics properties
			gravity.y = 2.6;
			maxVelocity.y = kJumpForce;
			maxVelocity.x = kMoveSpeed * 2;
			friction.x = friction.y = 1.6;
			
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
				acceleration.y = -kJumpForce;
			
			// Make animation changes here
			setAnimation();
			
			super.update();
			
			// Always face the direction we were last heading
			if (velocity.x < 0)
				facing = LEFT;
			else if (velocity.x > 0)
				facing = RIGHT;
		}
		
		private function setAnimation():void
		{
			var animation:String;
			
			if (facing == LEFT)
				animation = "left_";
			else
				animation = "right_";
			
			if (onGround)
			{
				if (velocity.x == 0)
					animation += "idle";
				else
					animation += "walk";
			}
			else
			{
				animation += "jump";
			}
			
			sprite.play(animation);
		}
		
	}

}
