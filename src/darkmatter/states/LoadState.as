package darkmatter.states 
{
	import darkmatter.utilities.Environment;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class LoadState extends FlxState 
	{		
		private var textBox:FlxText;
		private var button:FlxButton;
		private var game:PlayState;
		
		public function LoadState(/*levelName:String*/) 
		{
			textBox = new FlxText(FlxG.width / 2, FlxG.height / 2, 200, "");
			button = new FlxButton(FlxG.width / 2, FlxG.height - 50, "Start", buttonClick); 
			
			add(textBox);
			add(button);
			
			button.visible = false;
			
			Environment.initData();
			
			game = new PlayState();
			game.Report = handleReports;
			game.loadLevel("testLevel");
		}
		
		private function handleReports(message:String) : void
		{
			textBox.text = message;
			
			if (message == "READY")
			{
				button.visible = true;
			}
		}
		
		private function buttonClick() : void
		{
			FlxG.switchState(game);
		}
	}

}