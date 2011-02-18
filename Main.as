package  
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import com.matttuttle.GameWorld;
	
	public class Main extends Engine
	{
		
		public function Main() 
		{
			super(480, 260, 30, true);
			FP.world = new GameWorld();
		}
		
	}

}