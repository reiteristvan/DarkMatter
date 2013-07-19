package darkmatter.states.partials 
{
	import darkmatter.utilities.Environment;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class InfoPanel extends FlxGroup 
	{
		private var moneyText:FlxText = null;
		private var metalText:FlxText = null;
		private var turnText:FlxText = null;
		
		private var background:FlxSprite = null;
		
		public function InfoPanel(x:Number, y:Number, width:Number, height:Number) : void 
		{
			background = new FlxSprite(x, y);
			background.ID = 34567;
			background.makeGraphic(width, height, 0xFF342237);
			add(background);
			
			moneyText = new FlxText(20, 5, 100, "Money: 0");
			metalText = new FlxText(140, 5, 100, "Metal: 0");
			turnText = new FlxText(540, 5, 100, "Turn: 1");
			add(moneyText);
			add(metalText);
			add(turnText);
			
			Environment.update = updateInfo;
		}
		
		public function updateInfo(money:int, metal:int, turn:int) : void
		{
			moneyText.text = "Money: " + money.toString();
			metalText.text = "Metal: " + metal.toString();	
			turnText.text = "Turn: " + turn.toString();
		}
	}

}