package com.matttuttle
{
	
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	
	public class Block extends Entity
	{
		
		public function Block(x:int, y:int) 
		{
			this.x = x;
			this.y = y;
			
			graphic = new Image(Assets.GfxBlock);
			setHitbox(32, 32);
			
			// This block is collidable with a physics character
			type = "solid";
		}
		
	}

}