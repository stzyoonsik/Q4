package
{
	import flash.display.Sprite;	
	import starling.core.Starling;
	
	[SWF(width="1024", height="768", backgroundColor="0xFFFFFF")]
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