package darkmatter.entities 
{
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class SolarSystem extends FlxEntity 
	{
		public var name:String = ""; 
		public var planetCount = 0;
		public var conquered:Boolean = false;
		
		public function SolarSystem(x:Number, y:Number, graphic:Class = null) : void 
		{
			super(x, y, graphic);
		}
	}

}