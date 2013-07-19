package darkmatter.utilities 
{
	import darkmatter.assets.LevelData;
	import darkmatter.entities.FlxEntity;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class LevelFactory 
	{		
		static public function create(levelName:String) : Level
		{
			var level:Level = new Level();
			var data:Array = LevelData.fetch(levelName);
			
			level.startMoney = data[1] as int;
			level.startMetal = data[2] as int;
			var entities:Array = data[3] as Array;
			level.motherPosition = data[4] as FlxPoint;
			
			for (var i:int = 0; i < entities.length;++i)
			{
				var entity:FlxEntity = entities[i] as FlxEntity;
				entity.coordinate.x = entity.x;
				entity.coordinate.y = entity.y;
				level.addEntity(entity);
			}
			
			return level;
		}
	}

}