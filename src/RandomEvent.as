package 
{
	import CustomEvent;
	final public class RandomEvent extends CustomEvent
	{

		public function RandomEvent(inputDict, pMyParent)
		{
			this.eventDict = inputDict;
			this.eventStatus = "random";
			this.causeCountry = false;
			this.pMyParent = pMyParent;
			trace("random event");
			trace(eventDict);
			trace(eventDict.name);
			trace(eventDict["String"]);
			
			if (eventDict["countries"] != false)
			{
				this.country = determineCountry(Main.dataDict[eventDict["countries"]]);
			}
			
			else
			{
				this.country = "";
			}
			
			if (eventDict["String"] == false)
			{
				Main.event_field.x = - 500;
			}
			
			else
			{
				this.editTextBox();
			}
			
			if (eventDict["countries"] != false)
			{
				if (eventDict["following"] != false)
				{
					this.determineConsequence();
				}
				else
				{
					this.determineEnding();
				}
				this.determineAccessibility();
				this.determineStatus();
			}
			
			this.impact();
			this.leadToMissions();
			this.sendMail();
		}
	}
}