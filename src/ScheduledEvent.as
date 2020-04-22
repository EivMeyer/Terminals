package 
{
	import CustomEvent;
	final public class ScheduledEvent extends CustomEvent
	{
		public function ScheduledEvent(inputArray, pMyParent)
		{
			this.eventDict = inputArray[0];
			this.eventStatus = "scheduled";
			this.pMyParent = pMyParent;
			this.causeCountry = inputArray[2];
			this.bandName = inputArray[3];
			this.cometName = inputArray[4];
			this.gangName = inputArray[5];
			
			trace("scheduled event");
			trace(eventDict);
			trace(eventDict.name);
			trace(eventDict["String"]);
			trace(inputArray[1]);
			//trace("SCHEDULED EVENT: ", eventDict["String"]);

			if (this.eventDict["countries"] != false)
			{
				
				if (inputArray[1] == "random")
				{
					this.country = determineCountry(Main.dataDict[eventDict["countries"]]);
				}
				else
				{
					this.country = inputArray[1];
				}
			}
			
			if (eventDict["String"] == false)
			{
				Main.event_field.x = - 500;
			}
			
			else
			{
				this.editTextBox();
			}
			
			if (this.eventDict["countries"] != false)
			{
				if (eventDict["following"] != false)
				{
					this.determineConsequence();
				}
				if (eventDict["ending"] != false)
				{
					this.determineEnding();
				}
				this.determineAccessibility();
				this.determineStatus();
			}
			
			else
			{
				this.country = "";
			}
			
			this.impact();
			this.leadToMissions();
			this.sendMail();
		}
	}
}