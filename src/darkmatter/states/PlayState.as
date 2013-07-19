package darkmatter.states 
{
	import adobe.utils.CustomActions;
	import darkmatter.entities.*;
	import darkmatter.levels.Level1;
	import darkmatter.states.partials.ControlPanel;
	import darkmatter.states.partials.InfoPanel;
	import darkmatter.states.partials.ResearchDialog;
	import darkmatter.utilities.*;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class PlayState extends FlxState 
	{
		public var Report:Function = null;
		private var level:Level = null;
		private var objects:FlxGrid = null;
		private var ships:FlxGrid = null;
		private var hud:FlxGroup = null;
		private var controlPanel:ControlPanel = null;
		private var infoPanel:InfoPanel = null;
		private var hudTop:FlxSprite = null;
		private var selectedShip:Ship = null;
		private var highLightSprite:FlxSprite = new FlxSprite();
		private var isAITurn:Boolean = false;
		private var movementGroup:FlxGroup = null;
		private var friendlyGroup:FlxGroup = null;
		private var isDialogOn:Boolean = false;
		private var researchDialog:ResearchDialog = new ResearchDialog();
		private var selectedMother:Ship = null;
		
		public function PlayState() 
		{						
			highLightSprite.makeGraphic(32, 32, 0x4400FF00);
			
			ships = new FlxGrid(20, 10);
			objects = new FlxGrid(20, 10);
			add(objects);
			add(ships);
				
			hud = new FlxGroup();
			infoPanel = new InfoPanel(0, 0, 640, 25);
			controlPanel = new ControlPanel(512, 25, 128, 448);
			hud.add(infoPanel);
			hud.add(controlPanel);
			add(hud);
			
			add(highLightSprite);
			
			movementGroup = new FlxGroup();
			friendlyGroup = new FlxGroup();
			add(movementGroup);
			add(friendlyGroup);
			
			add(researchDialog);
			
			controlPanel.endTurn = endTurn;
			controlPanel.research = research;
			controlPanel.onCreate = createShip;
			researchDialog.onClose = function() : void { isDialogOn = false; };
		}
		
		private function createShip(type:String) : void
		{
			var rect:FlxRect = getFactoryRectangle(selectedMother);
			var point:FlxPoint = null;
			
			for (var i:int = rect.x; i <= rect.x + rect.width;++i)
			{
				for (var j:int = rect.y; j <= rect.y + rect.height;++j)
				{
					if (ships.getXY(i, j) == null && objects.getXY(i, j) == null)
					{
						point = new FlxPoint(i, j);
						break;
					}
				}
			}
			
			if (point == null)
			{
				return;
			}
			
			var s:Ship = Ship.create(type); 
			s.x = point.x * 32; s.y = (point.y * 32) + 25;
			s.coordinate = point;
			
			ships.add(s);
			
			// update resources
			Environment.money -= Environment.prices[type]["money"];
			Environment.metal -= Environment.prices[type]["metal"];
			
			controlPanel.updateFactory();
		}
		
		private function research() : void
		{
			researchDialog.show(0, 25);
			isDialogOn = true;
		}
		
		private function endTurn() : void
		{
			highLightSprite.x = -32;
			movementGroup.clear();
			isAITurn = true;
			AIMove();
			Environment.turn += 1;
			startTurn();
		}
		
		private function startTurn() : void
		{
			// research enable
			researchDialog.isResearchedInThisTurn = false;
			
			// get allied ships
			var allyShips:Array = ships.all(function(entity:FlxEntity) : Boolean
			{
				return (entity is Ship) && entity.owner == 1;
			});
			
			for each(var ship:Ship in allyShips)
			{
				// restore movement points
				ship.movementPoints = ship.baseMovementPoints + Environment.Research.rangeMod;
			}
			
			// select first friendly ship
			
			if (selectedShip == null)
			{
				selectShip(ships.getFirst(function(entity:FlxEntity) : Boolean
				{
					var ship:Ship = entity as Ship;
					return ship.owner == 1;
				}) as Ship);
			}
			else
			{
				selectShip(selectedShip);
			}
			
			// highlight friendly objects
			highlightAllies();
			
			// get number of friendly planets
			var taxMul:int = objects.count(function(entity:FlxEntity) : Boolean 
			{ 
				return (entity is Planet) && entity.owner == 1;
			});
			
			// get friendly mines
			var mines:Array = objects.all(function(entity:FlxEntity) : Boolean
			{
				return (entity is Mine) && entity.owner == 1;
			});
			
			// calculate total metal income and destroy empty mines
			var metal:int = 0;
			var value:int = Environment.Research.mineMod + Environment.metalPerTurn;
			for each(var mine:Mine in mines)
			{
				var x:int = mine.capacity - value;
				
				if (x < 0)
				{
					metal += value + x;
					objects.remove(mine);
					mine.kill();
				}
				else
				{
					metal += value;
				}
			}
			
			// calc resources after first turn
			if (Environment.currentTurn != 1)
			{
				Environment.money += (Environment.taxPerTurn + Environment.Research.taxMod) * taxMul;
				Environment.metal += value;
			}
			
			// update infopanel
			infoPanel.updateInfo(Environment.currentMoney, Environment.currentMetal, Environment.turn);
			controlPanel.updateFactory();
		}
		
		private function highlightAllies() : void
		{
			friendlyGroup.clear();
			
			for each(var item:FlxEntity in objects.members)
			{			
				if (item.owner == 1)
				{
					var sprite:FlxSprite = new FlxSprite(item.x, item.y);
					sprite.makeGraphic(32, 32, 0x4400FF00);
					friendlyGroup.add(sprite);
				}
			}
		}
		
		public function loadLevel(levelName:String) : void
		{
			//level = LevelFactory.create(levelName);
			level = new Level1();
			Report("LEVEL_DATA");
			
			Report("ASSETS");
			
			Environment.currentMoney = level.startMoney;
			Environment.currentMetal = level.startMetal;
			
			for (var i:int = 0; i < level.entities.length;++i)
			{
				var entity:FlxEntity = level.entities[i] as FlxEntity;
				//entity.coordinate.x = entity.x; entity.coordinate.y = entity.y;
				entity.x = entity.coordinate.x * 32; 
				entity.y = (entity.coordinate.y * 32) + 25;
				
				switch(Class(Object(entity).constructor))
				{
					case Ship: ships.add(entity); break;
					case Planet: objects.add(entity); break;
					case Mine: objects.add(entity); break;
				}
			} 
			
			// create mothership
			//var mother:Ship = Ship.create(Ship.MOTHERSHIP);
			//mother.coordinate.x = level.motherPosition.x; mother.coordinate.y = level.motherPosition.y;
			//mother.x = level.motherPosition.x * 32; mother.y = (level.motherPosition.y * 32) + 25;
			//ships.add(mother);
			
			// enemy mothership
			//var enemyMother:Ship = Ship.create(Ship.MOTHERSHIP);
			//enemyMother.owner = 0;
			//enemyMother.coordinate.x = 10; enemyMother.coordinate.y = 5;
			//enemyMother.x = 10 * 32; enemyMother.y = (5 * 32) + 25;
			//ships.add(enemyMother);
			
			Report("ENTITIES");
			
			startTurn();
			
			Report("READY");
		}
		
		override public function update() : void 
		{	
			if (FlxG.mouse.justReleased() && (FlxG.mouse.screenY > 25 && FlxG.mouse.screenX < 540) && !isAITurn && !isDialogOn)
			{
				var _x:int = FlxG.mouse.screenX / 32;
				var _y:int = (FlxG.mouse.screenY - 25) / 32;
				
				var ship:Ship = ships.getXY(_x, _y) as Ship;
				
				// clicked on ship
				if (ship != null)
				{
					// ship is friendly
					if (ship.owner == 1)
					{
						selectShip(ship);
						
						// mothership selected
						if (ship.ID == 1)
						{
							selectedMother = ship;
							// enable factory on controlpanel
							controlPanel.enableFactory(true);
						}
						else if(controlPanel.factory == true)
						{
							controlPanel.enableFactory(false);
						}
					}
					else if (ship.owner == 0 && selectedShip != null && isMovementValid(_x, _y)) // attack
					{					
						// play sound if allowed
						// TODO Options sound on/off
						// attack enemy ship, calc damage
						ship.damage(selectedShip.attack + Environment.Research.attackMod);
						
						// if ship killed it must clear from group
						if (ship.alive == false)
						{
							ships.remove(ship, true);
						}
						
						// re-select ship
						selectedShip.movementPoints -= 1;
						
						// attack cost to movement too
						if (selectedShip.movementPoints < 0)
						{
							selectedShip.movementPoints = 0;
						}
						
						selectShip(selectedShip);
					}
				}
				else
				{			
					// movement
					if (selectedShip != null)
					{	
						// check if movement is valid
						if (isMovementValid(_x, _y))
						{
							// decrease movementpoints
							var tmp:FlxPoint = getGameCoordinates(selectedShip);
							selectedShip.movementPoints -= Math.abs(tmp.x - _x) + Math.abs(tmp.y - _y);
							// move ship && update grid
							ships.moveEntity(new FlxPoint(selectedShip.x, selectedShip.y), 
											 new FlxPoint(_x * 32, (_y * 32) + 25));
							
							// check if conquer a planet or mine
							var object:FlxEntity = objects.getXY(_x, _y);
							
							// find something
							if (object != null)
							{
								if (object is Planet)
								{
									var planet:Planet = object as Planet;
									planet.owner = 1;
								}
								else
								{
									var mine:Mine = object as Mine;
									mine.owner = 1;
								}
							}
							
							// re-select ship
							selectShip(selectedShip);
						}
					}
				}
			}
			
			super.update();
		}
		
		private function AIMove() : void
		{
			isAITurn = true;
			
			// get motherBoards
			var mothers:Array = ships.all(function(enemy:FlxEntity) : Boolean
			{
				return enemy.ID == 1 && enemy.owner == 0;
			});
			
			// get ships
			var eships:Array = ships.all(function(enemy:FlxEntity) : Boolean
			{
				return enemy.owner == 0;
			});
			
			// get player's ships
			var fships:Array = ships.all(function(enemy:FlxEntity) : Boolean
			{
				return enemy.owner == 1;
			});
			
			// move ships
			// if enemy is defensive
			if (level.isEnemyOnDefense)
			{
				// get ships near defended point
				var p:Ship = null;
				for each(var ss:Ship in fships)
				{
					if (distance(ss.coordinate, level.pointToDefend) < 3)
					{
						
					}
				}
			}
			else // offensive AI
			{
				// if there is a target(s)
				if (level.pointsToOffense != null)
				{
					
				}
				else // random violence
				{
					// go and attack ship
				}
			}
			
			// build ships
			
			isAITurn = false;
		}
		
		private function distance(a:FlxPoint, b:FlxPoint) : int
		{
			return Math.abs(a.x - b.x) + Math.abs(a.y - b.y);
		}
		
		private function selectShip(ship:Ship) : void
		{
			if (ship == null)
			{
				return;
			}
			
			selectedShip = ship;
			// highlight ship
			highLightSprite.x = ship.x; highLightSprite.y = ship.y;		
			// update information panel
			controlPanel.updateInfo(ship);
			// show possible movings
			drawMovements(getMovementRectangle(ship), ship);
		}
		
		private function drawMovements(rect:FlxRect, ship:Ship) : void
		{
			movementGroup.clear();
			var shipCoords:FlxPoint = getGameCoordinates(ship);
			
			for (var i:int = rect.x; i < rect.x + rect.width;++i)
			{
				for (var j:int = rect.y; j < rect.y + rect.height;++j)
				{
					var shipMaybe:Ship = ships.getXY(i, j) as Ship;
					
					//check range
					if (Math.abs(shipCoords.x - i) + Math.abs(shipCoords.y - j) < ship.movementPoints)
					{
						var color:uint = 0x4400FF00;
						
						// enemy or allied ship
						if (shipMaybe != null)
						{
							// enemy
							if (shipMaybe.owner == 0)
							{
								color = 0x44FF0000;
							}
							else
							{
								continue;
							}
						}
							
						var sprite:FlxSprite = new FlxSprite(i * 32, (j * 32) + 25);
						sprite.makeGraphic(32, 32, color);
						movementGroup.add(sprite);
					}
				}
			}
		}
		
		private function getMovementRectangle(ship:Ship) : FlxRect
		{
			var shipCoords:FlxPoint = getGameCoordinates(ship);
			var rect:FlxRect = new FlxRect();
			
			// top left x
			rect.x = shipCoords.x - ship.movementPoints;
			if (rect.x < 0) { rect.x = 0; }
			
			//top left y
			rect.y = shipCoords.y - ship.movementPoints;
			if (rect.y < 0) { rect.y = 0; }
			
			// width of the rectangle
			rect.width = shipCoords.x - rect.x + 1 + ship.movementPoints;
			if (rect.x + rect.width > 15) { rect.width = 15 - rect.x; }
			
			//height of the rectangle
			rect.height = shipCoords.y - rect.y + 1 + ship.movementPoints;
			if (rect.y + rect.height > 14) { rect.height = 14 - rect.y; }
			
			return rect;
		}
		
		private function getFactoryRectangle(mother:Ship) : FlxRect
		{
			var shipCoords:FlxPoint = getGameCoordinates(mother);
			var rect:FlxRect = new FlxRect();
			
			rect.x = shipCoords.x - 1;
			if (rect.x < 0) { rect.x = 0; }
			
			rect.y = shipCoords.y - 1;
			if (rect.y < 0) { rect.y = 0; }
			
			rect.width = 2;
			if (shipCoords.x == 15) { rect.width = 1; }
			
			rect.height = 2;
			if (shipCoords.y == 14) { rect.height = 1; }
			
			return rect;
		}
		
		private function getGameCoordinates(entity:FlxObject) : FlxPoint
		{
			return new FlxPoint(entity.x / 32, (entity.y - 25) / 32);
		}
		
		private function isMovementValid(x:int, y:int) : Boolean
		{
			for each(var item:FlxSprite in movementGroup.members)
			{
				var coords:FlxPoint = getGameCoordinates(item);
				
				if (coords.x == x && coords.y == y)
				{
					return true;
				}
			}
			
			return false;
		}
	}

}