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
		
		// conditions
		
		// return number of items which fit condition
		public function filterEntities(predicate:Function) : int
		{
			var result:int = 0;
			
			for each(var entity:FlxEntity in entities)
			{
				if (predicate(entity)) { ++result; }
			}
			
			return result;
		}
		
		public function allPlayerShipDead() : Boolean
		{		
			return filterEntities(function(entity:FlxEntity) : Boolean 
			{ 
				return entity is Ship && entity.owner == 1 && entity.exists == false 
			}) > 0;
		}
		
		public function allEnemyShipDead() : Boolean
		{
			return filterEntities(function(entity:FlxEntity) : Boolean 
			{ 
				return entity is Ship&& entity.owner == 0 && entity.exists == false 
			}) > 0;
		}
		
		public var targetNumber:int = 0; 
		public function targetToEnemyDead() : Boolean
		{
			return filterEntities(function(entity:FlxEntity) : Boolean
			{
				return entity.target == -1 && (entity.exist == false || entity.owner == 0);
			}) == targetNumber;
		}
		
		public function targetToPlayerDead() : Boolean
		{
			return filterEntities(function(entity:FlxEntity) : Boolean
			{
				return entity.target == 1 && (entity.exist == false || entity.owner == 1);
			}) == targetNumber;
		}
	}

}