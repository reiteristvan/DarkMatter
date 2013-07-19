package darkmatter.entities 
{
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class Mine extends FlxEntity 
	{
		public var capacity:int = 100;
		
		public function Mine(x:Number, y:Number, team:int) : void
		{
			// FIXME default mine graphic
			super(x, y, null);
			owner = team;
		}
	}

}