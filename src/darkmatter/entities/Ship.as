package darkmatter.entities 
{
	import adobe.utils.CustomActions;
	import darkmatter.assets.Images;
	import darkmatter.utilities.Environment;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class Ship extends FlxEntity 
	{
		static public var HUNTER:String = "hunter";
		static public var CRUISER:String = "cruiser";
		static public var DESTROYER:String = "destroyer";
		static public var MOTHERSHIP:String = "mothership";
		static public var MINER:String = "miner";
		
		public var type:String = Ship.HUNTER;
		public var baseAttack:Number = 10;
		public var baseShield:Number = 100
		public var baseHealth:Number = 100;
		public var baseMovementPoints:Number = 3;
		
		public var attack:Number = 100;
		public var shield:Number = 100;
		public var movementPoints:Number = 3;
		
		//public var player:Number = 1; // 1 == player, 0 == enemy
		
		private var shieldBar:FlxSprite = null;
		private var healthBar:FlxSprite = null;
		
		public function Ship(x:Number = 0, y:Number = 0, team:Number = 1, graphic:Class = null) : void
		{
			// TODO get ship image based on type
			super(x, y, Images.Ship);

			owner = team;
			health = 100;
			
			shieldBar = new FlxSprite(x, y + 24);
			shieldBar.makeGraphic(32, 4, 0xFF0000FF);
			healthBar = new FlxSprite(x, y + 28);
			healthBar.makeGraphic(32, 4, 0xFFFF0000);
		}
		
		override public function draw():void 
		{		
			super.draw();
			if(shield > 0) { shieldBar.draw(); }
			healthBar.draw();
		}
		
		override public function update():void 
		{
			shieldBar.x = x; shieldBar.y = y + 24;
			healthBar.x = x; healthBar.y = y + 28;
			super.update();
		}
		
		public function damage(damage:Number) : void
		{
			if (shield > 0)
			{
				shield -= damage;
				
				if (shield < 0) { damage = shield * ( -1); shield = 0; }
				else { damage = 0; }
			}
			
			if (damage > 0)
			{
				health -= damage;
				
				if (health <= 0) { kill(); return; }
			}
			
			if (shield > 0 ) 
			{ 
				shieldBar.makeGraphic((32.0 / (shield + Environment.Research.shieldMod)) * shield, 4, 0xFF0000FF) 
			};
			
			healthBar.makeGraphic((32.0 / (health + Environment.Research.healthMod)) * health, 4, 0xFFFF0000);
		}
		
		public function clone() : Ship
		{
			var s:Ship = new Ship();
			s.attack = attack;
			s.health = health;
			s.shield = shield;
			s.baseMovementPoints = baseMovementPoints;
			s.movementPoints = 0;
			s.ID = ID;
			
			return s;
		}
		
		static public function create(type:String) : Ship
		{
			return Environment.ships[type].clone();
		}
	}
}