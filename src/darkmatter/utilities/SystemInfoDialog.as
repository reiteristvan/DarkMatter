package darkmatter.utilities 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class SystemInfoDialog extends FlxDialog 
	{
		public var data:String = "";
		
		private var _systemImage:FlxSprite = null;
		private var _planetCountText:FlxText = null;
		private var _conquered:FlxSprite = null;
		
		public function SystemInfoDialog() : void
		{
			super();
			
			width = 150;
			height = 100;
		}
		
		public function set systemImage(graphic:Class) : void
		{
			_systemImage.loadGraphic(graphic);
		}
		
		public function set planetCount(count:Number) : void
		{
			_planetCountText.text = count;
		}
		
		public function set conquered(value:Boolean)  : void
		{
			//TODO set image of _conquered sprite
		}
	}

}