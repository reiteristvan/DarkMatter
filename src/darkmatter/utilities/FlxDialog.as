package darkmatter.utilities 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class FlxDialog extends FlxGroup 
	{
		public var onClose:Function = null;
		
		public var background:FlxSprite = null;
		
		public var backgroundColor:uint = 0xFFFF0000;
		public var width:Number = 300;
		public var height:Number = 100;
		public var isVisible:Boolean = false;
		
		public function FlxDialog() 
		{
			background = new FlxSprite(0, 0);
			background.makeGraphic(width, height, backgroundColor);
			background.x = 0;
			background.y = 0;
			
			add(background);
			
			alive = false;
			isVisible = false;
			visible = false;
		}
		
		override public function update() : void 
		{
			super.update();
		}
		
		public function show(x:Number, y:Number) : void
		{	
			background.x = x;
			background.y = y;
			
			alive = true;
			isVisible = true;
			visible = true;	
		}
		
		public function hide() : void
		{
			alive = false;
			isVisible = false;
			visible = false;
			
			if (onClose != null)
			{
				onClose();
			}
		}
		
		override public function kill():void 
		{
			//super.kill();
		}
	}

}