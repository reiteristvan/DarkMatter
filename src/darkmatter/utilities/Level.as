package darkmatter.utilities 
{
	import darkmatter.entities.FlxEntity;
	import darkmatter.entities.Planet;
	import darkmatter.entities.Ship;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class Level 
	{	
		public var entities:Vector.<FlxEntity> = null;
		
		public var isEnemyCanBuild:Boolean = false;
		public var isEnemyOnDefense:Boolean = false;
		public var pointToDefend:FlxPoint = new FlxPoint();
		public var pointsToOffense:Array = null;
		
		public var startMoney:int = 1000;
		public var startMetal:int = 500;
		public var motherPosition:FlxPoint = null;
		
		public var success:Function = null;
		public var failure:Function = null;
		
		public function Level() : void
		{
			entities = new Vector.<FlxEntity>();
		}
		
		public function addEntity(entity:FlxEntity) : void
		{
			entities.push(entity);
		}
	}

}