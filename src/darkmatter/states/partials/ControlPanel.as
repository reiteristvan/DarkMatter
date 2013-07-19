package darkmatter.states.partials 
{
	import darkmatter.assets.Images;
	import darkmatter.entities.FlxEntity;
	import darkmatter.entities.Ship;
	import darkmatter.utilities.Environment;
	import org.flixel.FlxBasic;
	import org.flixel.FlxButton;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class ControlPanel extends FlxGroup 
	{	
		public var onCreate:Function = null;
		public var factory:Boolean = false;
		
		public var endTurn:Function = null;
		public var research:Function = null;
		
		private var skipButton:FlxButton = null;
		private var endTurnButton:FlxButton = null;
		private var researchButton:FlxButton = null;
		
		private var hunterButton:FlxButton = null;
		private var factoryArray:Vector.<FlxButton> = new Vector.<FlxButton>();
		
		private var healtText:FlxText = null;
		private var attackText:FlxText = null;
		private var shieldText:FlxText = null;
		private var movementText:FlxText = null;
		
		private var background:FlxSprite = null;
		
		public function ControlPanel(x:Number, y:Number, width:Number, height:Number) 
		{
			background = new FlxSprite(x, y);
			background.ID = 12345;
			background.makeGraphic(width, height, 0xFF112233);
			add(background);
			
			endTurnButton = new FlxButton(550, 355, "End Turn", handleEndTurn);
			researchButton = new FlxButton(550, 375, "", handleResearch);
			researchButton.loadGraphic(Images.Planet);
			add(endTurnButton);
			add(researchButton);
			
			healtText = new FlxText(550, 100, 120, "Health: ");
			attackText = new FlxText(550, 150, 120, "Attack: ");
			shieldText = new FlxText(550, 200, 120, "Shield: ");
			
			add(healtText);
			add(attackText);
			add(shieldText);
			
			hunterButton = new FlxButton(550, 250, "Hunter", function() : void { create(Ship.HUNTER); } );
			hunterButton.name = Ship.HUNTER;
			factoryArray.push(hunterButton);
		}
		
		private function handleEndTurn() : void
		{
			if (endTurn != null)
			{
				endTurn();
			}
		}
		
		private function handleResearch() : void
		{
			if (research != null)
			{
				research();
			}
		}
		
		public function updateInfo(ship:Ship) : void
		{
			healtText.text = "Health: " + ship.health.toString() + "/" + ship.baseHealth.toString();
			attackText.text = "Attack: " + ship.attack.toString()+ "/" + ship.baseAttack.toString();
			shieldText.text = "Shield: " + ship.shield.toString()+ "/" + ship.baseShield.toString();
		}
		
		public function enableFactory(value:Boolean) : void
		{
			factory = value;
			
			if (value)
			{
				for each(var btn:FlxButton in factoryArray)
				{
					add(btn);
					
					if (Environment.prices[btn.name]["money"] > Environment.currentMoney ||
						Environment.prices[btn.name]["metal"] > Environment.currentMetal)
						{
							btn.active = false;
						}
						else
						{
							btn.active = true;
						}
				}
			}
			else
			{
				remove(hunterButton);
			}
		}
		
		public function updateFactory() : void
		{
			if (factory)
			{
				enableFactory(factory);
			}
		}
		
		private function create(type:String) : void
		{
			if (onCreate != null)
			{
				onCreate(type);
			}
		}
	}

}