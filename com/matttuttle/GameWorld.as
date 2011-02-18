package com.matttuttle
{
	
	import flash.text.engine.TextBlock;
	import net.flashpunk.*;
	
	public class GameWorld extends World
	{
		
		public function GameWorld()
		{
			FP.screen.color = 0x8EDFFA;
			
			add(new Character(FP.screen.width / 2, FP.screen.height - 64));
			
			// Fill with blocks
			for (var i:int = 0; i < FP.screen.width / 32; i++)
			{
				add(new Block(i * 32, FP.screen.height - 32));
			}
		}
		
	}

}