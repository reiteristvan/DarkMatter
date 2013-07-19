package darkmatter.entities 
{
	import darkmatter.assets.Images;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class Planet extends FlxEntity 
	{
		public var name:String = "";
		public var population:Number = 1000;
		public var popPerTurn:Number = 10;
		public var baseTax:int = 10;
		//public var owner:int = 0; // 0 == neutral, 1 == friendly, -1 == enemy
		
		public function Planet(x:Number, y:Number, team:int = 0, graphic:Class = null) : void
		{
			super(x, y, Images.Planet);
			coordinate = new FlxPoint(x, y);
			owner = team;
		}
		
	}

}