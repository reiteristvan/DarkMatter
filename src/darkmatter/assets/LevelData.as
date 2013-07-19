package darkmatter.assets 
{
	import darkmatter.entities.Mine;
	import darkmatter.entities.Planet;
	import darkmatter.entities.Ship;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class LevelData 
	{		
		static public function fetch(levelName:String) : Array
		{
			var levelData:Array = data.filter(function(element:*, idx:int, a:Array) : Boolean
			{
				return (element as Array)[0] == this;
			}, levelName);
			
			return levelData[0];
		}
		
		static public var data:Array = new Array(
			new Array(
				"testLevel", // name 
				300, // money
				500, // metal
				new Array( // entities
					new Ship(1, 2, 1),
					new Ship(1, 3, 0),
					new Ship(5, 3, 0),
					new Ship(5, 13, 0),
					new Planet(5, 9, 1),
					new Planet(2, 9, 0),
					new Planet(2, 7, 1),
					new Mine(5, 3, 1),
					new Mine(15, 7, 0)
				),
				new FlxPoint(2, 2), // Mothership position
				new FlxPoint(0, 0), // Point to defend
				new FlxPoint(0, 0) // Point to offense -> AI
			)
		);
	}

}