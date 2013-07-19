package darkmatter.utilities 
{
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class ResearchCenter 
	{
		public var researchList:Vector.<Research> = new Vector.<Research>();
		
		public var attackMod:int = 0;
		public var shieldMod:int = 0;
		public var healthMod:int = 0;
		public var rangeMod:int = 0;
		public var taxMod:int = 0;
		public var mineMod:int = 0;
		
		public function ResearchCenter() 
		{
			inititalize();
		}
		
		private function inititalize() : void
		{
			// TODO fill research list
			var r1:Research = new Research();
			r1.name = "research1";
			r1.description = "blablablabla";
			r1.isResearchable = true;
			r1.price = 500;
			r1.property = "shield";
			r1.value = 2;
			
			var r2:Research = new Research();
			r2.name = "research2";
			r2.description = "blablablabla";
			r2.price = 500;
			r2.property = "attack";
			r2.value = 2;
			r2.conditions.push("research1");
			
			var r3:Research = new Research();
			r3.name = "research3";
			r3.description = "blablablabla";
			r3.isResearchable = true;
			r3.price = 500;
			r3.property = "attack";
			r3.value = 2;
			
			var r4:Research = new Research();
			r4.name = "research4";
			r4.description = "blablablabla";
			r4.isResearchable = false;
			r4.price = 500;
			r4.property = "attack";
			r4.value = 2;
			r4.conditions.push("research3");
			
			var r5:Research = new Research();
			r5.name = "research5";
			r5.description = "blablablabla";
			r5.isResearchable = true;
			r5.price = 500;
			r5.property = "attack";
			r5.value = 2;

			var r6:Research = new Research();
			r6.name = "research5";
			r6.description = "blablablabla";
			r6.isResearchable = true;
			r6.price = 500;
			r6.property = "attack";
			r6.value = 2;
			
			var r7:Research = new Research();
			r7.name = "research5";
			r7.description = "blablablabla";
			r7.isResearchable = true;
			r7.price = 500;
			r7.property = "attack";
			r7.value = 2;
			
			var r8:Research = new Research();
			r8.name = "research5";
			r8.description = "blablablabla";
			r8.isResearchable = true;
			r8.price = 500;
			r8.property = "attack";
			r8.value = 2;

			var r9:Research = new Research();
			r9.name = "research5";
			r9.description = "blablablabla";
			r9.isResearchable = true;
			r9.price = 500;
			r9.property = "attack";
			r9.value = 2;
			
			var r10:Research = new Research();
			r10.name = "research10";
			r10.description = "blablablabla";
			r10.isResearchable = true;
			r10.price = 500;
			r10.property = "attack";
			r10.value = 2;
			
			var r11:Research = new Research();
			r11.name = "research11";
			r11.description = "blablablabla";
			r11.isResearchable = true;
			r11.price = 500;
			r11.property = "attack";
			r11.value = 2;
			
			researchList.push(r1);
			researchList.push(r2);
			researchList.push(r3);
			researchList.push(r4);
			researchList.push(r5);
			researchList.push(r6);
			researchList.push(r7);
			researchList.push(r8);
			researchList.push(r9);
			researchList.push(r10);
			researchList.push(r11);
		}
		
		public function research(name:String) : void
		{
			for each(var item:Research in researchList)
			{
				if (item.name == name)
				{
					applyResearch(item);
					item.isReasearched = true;
					Environment.money -= item.price;
					return;
				}
			}
		}
		
		private function applyResearch(research:Research) : void
		{
			switch(research.property)
			{
				case "attack":
					attackMod += research.value;
					break;
				case "shield":
					shieldMod += research.value;
					break;
				case "health":
					healthMod += research.value;
					break;
				case "range":
					rangeMod += research.value;
					break;
				case "tax":
					taxMod += research.value;
					break;
				case "mine":
					mineMod += research.value;
					break;
			}
			
			clearConditions(research.name);
		}
		
		private function clearConditions(research:String) : void
		{
			for each(var item:Research in researchList)
			{
				if (item.isConditon(research))
				{
					item.clearCondition(research);
				}
			}
		}
	}

}