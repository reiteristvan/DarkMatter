package darkmatter.states 
{
	import darkmatter.Global;
	import darkmatter.utilities.SystemInfoDialog;
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class MapState extends FlxState 
	{
		private var infoDialog:SystemInfoDialog = null;
		private var solarSystems:FlxGroup = null;
		
		public function MapState() 
		{
			infoDialog = new SystemInfoDialog();
			solarSystems = new FlxGroup();
			
			// load map data
			var data:String = Global.data.load();
			
			if (data == "")
			{
				data = generateData();
				Global.data.save(data);
			}
				
			initializeGame(data);
			
			add(SystemInfoDialog);
			add(solarSystems);
		}
		
		private function generateData() : String
		{
			return "";
		}
		
		private function initializeGame(data:String) : void
		{
			
		}
	}

}