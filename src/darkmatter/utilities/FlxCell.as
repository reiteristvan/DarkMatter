package darkmatter.utilities 
{
	import darkmatter.entities.FlxEntity;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class FlxCell extends FlxGroup 
	{		
		static const size:FlxPoint = new FlxPoint(24, 24);
		
		private var background:FlxSprite = null;
		
		public function FlxCell() : void
		{
			background = new FlxSprite();
			background.makeGraphic(FlxCell.size.x, FlxCell.size.y, 0xFFFF0000);
			add(background);
		}
		
		public function addObject(entity:FlxEntity) : void
		{
			add(entity);
		}
		
		public function highlight() : void
		{
			
		}
	}

}