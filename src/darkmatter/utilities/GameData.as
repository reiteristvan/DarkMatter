package darkmatter.utilities 
{
	import org.flixel.FlxSave;
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class GameData 
	{
		private var saveName:String = "DMGameData1986";
		private var save:FlxSave = null;
		private var loaded:Boolean = false;
		
		public function GameData() : void
		{
			save = new FlxSave();
			loaded = save.bind(saveName);
			
			if (!loaded)
			{
				save.data.dmSave = new String("");
			}
		}
		
		public function load() : String
		{
			return save.data.dmSave;
		}
		
		public function save(data:String) : void
		{
			save.data.dmSave = data;
			save.flush(0);
		}
	}

}