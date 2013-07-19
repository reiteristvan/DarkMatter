package darkmatter.utilities 
{
	import adobe.utils.CustomActions;
	import darkmatter.entities.Ship;
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class Environment 
	{
		static public var prices:Object = {
			"hunter": { "money": 100, "metal": 50 },
			"cruiser": { "money": 100, "metal": 50 }
		};
		
			static public var ships:Object = new Object();
		
		static public var update:Function = null;
		
		static public var Research:ResearchCenter = new ResearchCenter();
		
		static public var taxPerTurn:int = 150;
		static public var metalPerTurn:int = 50;
		static public var currentTurn:int = 1;
		static public var currentMoney:int = 1000;
		static public var currentMetal:int = 500;
		static public var enemyMoney:int = 1000;
		static public var enemyMetal:int = 200;
		
		public function Environment() 
		{
			
		}
		
		static public function initData() : void
		{
			var hunter:Ship = new Ship();
			hunter.type = Ship.HUNTER;
			
			var cruiser:Ship = new Ship();
			cruiser.type = Ship.CRUISER;
			
			var destroyer:Ship = new Ship();
			destroyer.type = Ship.DESTROYER;
			
			var miner:Ship = new Ship();
			miner.type = Ship.MINER;
			
			var motherShip:Ship = new Ship();
			motherShip.type = Ship.MOTHERSHIP;
			motherShip.ID = 1; motherShip.baseMovementPoints = 2;
			motherShip.movementPoints = 2; motherShip.attack = 4;
			motherShip.shield = 16; motherShip.health = 200;
			
			ships["hunter"] = hunter;
			ships["cruiser"] = cruiser;
			ships["destroyer"] = destroyer;
			ships["miner"] = miner;
			ships["mothership"] = motherShip;
		}
		
		static public function set money(value:int) : void
		{
			currentMoney = value;
			updateEnvironment();
		}
		
		static public function get money() : int
		{
			return currentMoney;
		}

		static public function set metal(value:int) : void
		{
			currentMetal = value;
			updateEnvironment();
		}
		
		static public function get metal() : int
		{
			return currentMetal;
		}
		
		static public function set turn(value:int) : void
		{
			currentTurn = value;
			updateEnvironment();
		}
		
		static public function get turn() : int
		{
			return currentTurn;
		}
		
		static private function updateEnvironment() : void
		{
			if (update != null)
			{
				update(currentMoney, currentMetal, currentTurn);
			}
		}
	}

}