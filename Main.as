package  
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import com.matttuttle.GameWorld;
	
	public class Main extends Engine
	{
		
		public function Main() 
		{
			super(480, 200, 30, true);
			FP.world = new GameWorld();
		}
		
	}

}