package darkmatter.ai 
{
	import darkmatter.utilities.FlxGrid;
	import darkmatter.entities.FlxEntity;
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class Helper 
	{
		static public function getAIShips(ships:FlxGrid) : Array
		{
			return ships.all(function(enemy:FlxEntity) : Boolean
			{
				return enemy.owner == 0;
			});
		}
		
		static public function getPlayerShips(ships:FlxGrid) : Array
		{
			return ships.all(function(enemy:FlxEntity) : Boolean
			{
				return enemy.owner == 1;
			});
		}
	}

}