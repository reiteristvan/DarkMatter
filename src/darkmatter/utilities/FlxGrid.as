package darkmatter.utilities 
{
	import darkmatter.entities.FlxEntity;
	import org.flixel.FlxBasic;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	
	/**
	 * ...
	 * @author Istvan Reiter
	 * 
	 * AI Use
	 */
	public class FlxGrid extends FlxGroup 
	{
		public var width:Number = 0;
		public var height:Number = 0;
		
		private var cells:Vector.<FlxEntity> = null;
		
		public function FlxGrid(width:Number, height:Number) : void 
		{
			this.width = width;
			this.height = height;
			this.cells = new Vector.<FlxEntity>();
			
			for (var i:int = 0; i < this.width * this.height;++i)
			{
				cells.push(null);
			}
		}
		
		public function getFirst(filter:Function) : FlxEntity
		{
			for (var i:int = 0; i < members.length;++i)
			{
				if (filter(members[i]) == true)
				{
					return members[i] as FlxEntity;
				}
			}
			
			return null;
		}
		
		override public function add(Object:FlxBasic):FlxBasic 
		{
			return super.add(Object);
		}
		
		public function getXY(row:Number, column:Number) : FlxEntity
		{
			var result:FlxEntity = null;
			var target:FlxPoint = new FlxPoint(row, column);
			
			for each(var item:FlxEntity in members)
			{
				if (coordinatesEqual(item.coordinate, target))
				{
					result = item;
					break;
				}
			}
			
			return result;
		}
		
		public function moveEntity(oldPos:FlxPoint, newPosition:FlxPoint) : void
		{
			var e:FlxEntity = this.getFirst(function(obj:FlxEntity) : Boolean
			{
				return coordinatesEqual(oldPos, new FlxPoint(obj.x, obj.y));
			});
			
			e.x = newPosition.x; e.y = newPosition.y;
			e.coordinate.x = e.x / 32; e.coordinate.y = (e.y - 25) / 32;
		}
		
		public function count(predicate:Function) : int
		{
			var result:int = 0;
			
			for each(var entity:FlxEntity in members)
			{
				if (predicate(entity))
				{
					++result;
				}
			}
			
			return result;
		}
		
		public function all(predicate:Function) : Array
		{
			var result:Array = new Array();
			
			for each(var entity:FlxEntity in members)
			{
				if (predicate(entity))
				{
					result.push(entity);
				}
			}
			
			return result;
		}
		
		public function setXY(row:Number, column:Number, entity:FlxEntity) : void
		{
			cells[(width * row) + column] = entity;
		}
		
		private function coordinatesEqual(a:FlxPoint, b:FlxPoint) : Boolean
		{
			return a.x == b.x && a.y == b.y;
		}
	}

}