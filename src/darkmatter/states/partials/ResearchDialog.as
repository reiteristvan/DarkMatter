package darkmatter.states.partials 
{
	import darkmatter.utilities.Environment;
	import darkmatter.utilities.FlxDialog;
	import darkmatter.utilities.Research;
	import darkmatter.entities.FlxEntity;
	import org.flixel.FlxButton;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class ResearchDialog extends FlxDialog 
	{
		private var closeButton:FlxButton = null;
		private var researches:FlxGroup = new FlxGroup();
		private var leftButton:FlxButton = null;
		private var rightButton:FlxButton = null;
		private var page:int = 0;
		private var coordinates:FlxPoint = new FlxPoint();
		public var isResearchedInThisTurn:Boolean = false;
		
		public function ResearchDialog() 
		{
			width = 512; height = 448;
			background.makeGraphic(width, height, 0xFF223344);
			
			closeButton = new FlxButton(20, 433, "Close", hide);
			leftButton = new FlxButton(330, 433, "<-", function() : void { if (page > 0) --page; loadResearches(); } );
			rightButton = new FlxButton(410, 433, "->", 
				function() : void 
				{ 
					var maxPage:int = (Environment.Research.researchList.length / 8) - 1;
					
					//if (Environment.Research.researchList.length % 10 > 0)
					//{
						//++maxPage;
					//}
					
					if (maxPage > page) 
					{ 
						++page; 
						loadResearches(); 
					}
				});
			
			add(closeButton);
			add(rightButton);
			add(leftButton);
			
			add(researches);
		}
		
		override public function show(x:Number, y:Number) : void 
		{
			researches.clear();
			
			coordinates.x = x; coordinates.y = y;
			loadResearches();
			
			super.show(x, y);
		}
		
		private function loadResearches() : void
		{
			// Load researches
			
			researches.clear();
			
			var i:int = 0;
			var j:int = 0;
			var rowLength:int = 3;
			var array:Vector.<Research> = subArray(Environment.Research.researchList, page * 8, 8)
			
			if (array.length == 0) { return; }
			
			for each(var research:Research in array)
			{
				// calc startcoordinates
				if (i > rowLength) { i = 0; ++j; }
				
				var _x:int = 20 + coordinates.x + i * 122;
				var _y:int = 30 + coordinates.y + j * 180;
				
				// TODO Icon for research
				var icon:FlxSprite = new FlxSprite(_x, _y);
				icon.makeGraphic(30, 30, 0xFFFF1666);
				
				var nameText:FlxText = new FlxText(_x + 35, _y, 105, research.name);
				var descText:FlxText = new FlxText(_x, _y + 35, 105, research.description);
				var effectText:FlxText = new FlxText(_x, _y + 70, 105, "+" + research.value + " " + research.property);
				var buyButton:FlxEntity = new FlxEntity(_x, _y + 105);
				buyButton.param = research.name;
				
				var buttonColor:uint = 0xFF22FF11;
				
				// if we can't research
				if (!research.isResearchable || Environment.currentMoney < research.price || isResearchedInThisTurn)
				{
					buttonColor = 0xFF112233;
				}
				else
				{
					buyButton.mouseClick = function(sender:FlxEntity) : void 
					{ 
						Environment.Research.research(sender.param);
						isResearchedInThisTurn = true;
						loadResearches();
					};
				}
				
				buyButton.makeGraphic(105, 20, buttonColor);
				
				researches.add(icon);
				researches.add(nameText);
				researches.add(descText);
				researches.add(effectText);
				
				if (!research.isReasearched)
				{
					researches.add(buyButton);
				}
				
				++i;
			}
		}
		
		private function subArray(v:Vector.<Research>, startIndex:int, length:int) : Vector.<Research>
		{
			var i:int = 0;
			var result:Vector.<Research> = new Vector.<Research>();
			
			for each(var item:Research in v)
			{
				if (i >= startIndex && i < startIndex + length)
				{
					result.push(item);
				}
				
				i++;
			}
			
			return result;
		}
	}

}