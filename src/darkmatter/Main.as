package darkmatter
{
	import darkmatter.states.LoadState;
	import darkmatter.states.PlayState;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class Main extends FlxGame 
	{
		public function Main() : void
		{
			super(640, 473, LoadState);
			
			FlxG.mouse.show();
		}
	}
	
}