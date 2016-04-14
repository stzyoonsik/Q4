package
{
	import flash.display.Sprite;
	
	import starling.core.Starling;
	
	public class Main extends Sprite
	{		
		public function Main()
		{
			var starling:Starling;
			starling = new Starling(MainStage, stage);	
			starling.showStats = true;
			starling.start();
		}
	}
}