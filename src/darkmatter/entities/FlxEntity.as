package darkmatter.entities 
{
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class FlxEntity extends FlxSprite 
	{		
		public var owner:int = 0;
		public var param:String = "";
		public var target:int = 0; // 0 == none, 1 == to player, -1 == to enemy
		
		// event handler for hover, function parameter is the object -> this
		public var mouseOver:Function = null;
		
		//event handler for mouse click, function parameter -> this
		public var mouseClick:Function = null;
		
		private var _movable:Boolean = true;
		
		public function FlxEntity(x:Number, y:Number, graphic:Class = null) : void 
		{
			super(x, y, graphic);
			
			if (graphic == null)
			{
				makeGraphic(32, 32, 0xFFFF1111);
			}
		}
		
		public function get movable() : Boolean
		{
			return _movable;
		}
		
		public function set movable(value:Boolean) : void
		{
			_movable = value;
			
			if (!_movable)
			{
				velocity.x = velocity.y = 0;
				acceleration.x = acceleration.y = 0;
				drag.x = drag.y = 0;
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			if (FlxG.mouse.justReleased() && isMouseOver() && mouseClick != null)
			{
				mouseClick(this);
			}
			
			
			if (isMouseOver() && mouseOver != null)
			{
				mouseOver(this);
			}
		}
		
		private function isMouseOver() : Boolean
		{
			var p:FlxPoint = FlxG.mouse.getScreenPosition();
			
			if ((p.x >= x && p.x <= x + width) && (p.y >= y && p.y <= y + height))
			{
				return true;
			}
			
			return false;
		}
		
		// Fields
		
		public var coordinate:FlxPoint = new FlxPoint(0, 0);
	}

}