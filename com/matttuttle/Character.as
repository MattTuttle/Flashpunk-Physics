package com.matttuttle
{
	
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	
	// Example character class using simple physics
	public class Character extends PhysicsEntity
	{
		
		private var sprite:Spritemap = new Spritemap(Assets.GfxCharacter, 32, 32);
		
		private static const kMoveSpeed:uint = 2;
		private static const kJumpForce:uint = 20;
		
		public function Character(x:int, y:int)
		{
			this.x = x;
			this.y = y;
			
			sprite.add("right_idle", [19, 19, 19, 20], 0.1, true);
			sprite.add("right_walk", [0, 1, 2, 3, 4, 5, 6, 7], 0.25, true);
			sprite.add("right_jump", [21]);
			
			sprite.add("left_idle", [17, 17, 17, 16], 0.1, true);
			sprite.add("left_walk", [15, 14, 13, 12, 11, 10, 9, 8], 0.25, true);
			sprite.add("left_jump", [18]);

			graphic = sprite;
			setHitbox(16, 32, -8);

			// Set physics properties
			gravity.y = 2.6;
			maxVelocity.y = kJumpForce;
			maxVelocity.x = kMoveSpeed * 2;
			friction.x = 0.7; // floor friction
			friction.y = 2.0; // wall friction
			
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
			{
				acceleration.y = -FP.sign(gravity.y) * kJumpForce;
				acceleration.x = -FP.sign(gravity.x) * kJumpForce;
			}
			
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
