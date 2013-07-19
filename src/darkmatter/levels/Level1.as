package darkmatter.levels 
{
	import adobe.utils.CustomActions;
	import darkmatter.entities.FlxEntity;
	import darkmatter.entities.Planet;
	import darkmatter.entities.Ship;
	import darkmatter.states.PlayState;
	import darkmatter.utilities.Level;
	import org.flixel.FlxPoint;
	
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class Level1 extends Level 
	{
		public function Level1() 
		{
			this.isEnemyOnDefense = false;
			this.motherPosition = new FlxPoint(2, 2);
			this.startMoney = 1500;
			this.startMetal = 300;
			
			var s1:Ship = Ship.create(Ship.MOTHERSHIP); s1.owner = 1;
			s1.coordinate = new FlxPoint(2, 2);
			var s2:Ship = Ship.create(Ship.HUNTER); s2.owner = 1;
			s2.coordinate = new FlxPoint(2, 3);
			var s3:Ship = Ship.create(Ship.HUNTER); s3.owner = 1;
			s3.coordinate = new FlxPoint(2, 1);
			
			var s4:Ship = Ship.create(Ship.HUNTER); s4.owner = 0;
			s4.coordinate = new FlxPoint(6, 6);
			var s5:Ship = Ship.create(Ship.HUNTER); s5.owner = 0;
			s5.coordinate = new FlxPoint(6, 7);
			
			var p1:Planet = new Planet(4, 4); p1.owner = -1;
			var p2:Planet = new Planet(4, 5); p2.owner = -1;
			
			addEntity(s1); addEntity(s2); addEntity(s3); addEntity(s4); addEntity(s5);
			addEntity(p1); addEntity(p2);
			
			this.success = successFunction;
		}
		
		private function successFunction() : Boolean
		{
			var result:Boolean = false;
			var target:int = 2;
			
			var i:int = 0;
			for each(var entity:FlxEntity in entities)
			{
				if (entity.owner == 0 && entity.exists == false)
				{
					++i;
				}
			}
			
			if (i == target)
			{
				result = true;
			}
			
			return result;
		}
		
		private function failureFunction() : Boolean
		{
			var result:Boolean = false;
			
			for each(var entity:FlxEntity in entities)
			{
				if (entity.ID == 1 && entity.owner == 0 && entity.exists == false)
				{
					result = true;
					break;
				}
			}
			
			return result;
		}
	}

}