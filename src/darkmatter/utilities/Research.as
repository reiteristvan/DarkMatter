package darkmatter.utilities 
{
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class Research 
	{
		public var name:String = "";
		public var description:String = "";
		public var price:int = 0;
		public var property:String = "";
		public var value:int = 0;
		
		public var isReasearched:Boolean = false;
		public var isResearchable:Boolean = false;
		public var conditions:Array = new Array();
		
		public function Research() 
		{
			
		}
		
		public function isConditon(name:String) : Boolean
		{
			for each(var item:String in conditions)
			{
				if (item == name)
				{
					return true;
				}
			}
			
			return false;
		}
		
		public function clearCondition(name:String) : void
		{
			var idx:int = conditions.indexOf(name);
			conditions.splice(idx, 1);
			
			if (conditions.length == 0)
			{
				isResearchable = true;
			}
		}
	}

}