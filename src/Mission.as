package  
{
	import flash.utils.Dictionary;
	import Mail;
	public class Mission 
	{		
		
		public var org:String;
		public var origin;
		public var country;
		public var payment:int;
		
		public var textString:String;
		public var endingStrings:Array = new Array();
		public var relation:String;
		
		public var originHover:String;
		public var countryHover:String;
		
		public var expires;
		
		public var missionCounter:int = 0;
		
		public var missionSuccess:Number = 0;
		
		public var Type:String;
		
		//public static var suggestedMission:Object = {"isMission": true, "org": "", "origin": "", "country": "", "payment": 0, "ending": "", "expires": false, "type": ""}

		public function Mission() 
		{
			// Pause game
			
			// Update mission text field
			//Main.missionBox.visible = true;
			
			
		}
		
		public function declareVariables(org, origin, country, payment, expires, Type, relation):void
		{			
			this.Type = Type;
			this.relation = relation;
			this.originHover = originHover;
		
			this.org = org;
			
			this.endingStrings = Main.organizations[this.org]["endings"];
			
			this.country = country;
			this.origin = origin;
			if (country == "random")
			{
				do
				{
					this.country = Main.dataDict[Main.organizations[this.org]["tcountries"]][Math.floor(Math.random() * Main.dataDict[Main.organizations[this.org]["tcountries"]].length)];
				}
				while (Main.notMissionArray.indexOf(this.country) == -1)
			}
			
			else
			{
				this.country = country;
			}
			
			if (origin == "random")
			{
				do 
				{
					var removedItem:Boolean = false;
					for (var CountR:uint = 0; CountR < Main.dataDict[Main.organizations[this.org]["countries"]].length; CountR ++)
					{
						if (Main.dataDict[Main.organizations[this.org]["countries"]][CountR] == this.country)
						{
							removedItem = Main.dataDict[Main.organizations[this.org]["countries"]][CountR];
							Main.dataDict[Main.organizations[this.org]["countries"]].splice(CountR, 1);
						}
					}
		
					this.origin = Main.dataDict[Main.organizations[this.org]["countries"]][Math.floor(Math.random() * Main.dataDict[Main.organizations[this.org]["countries"]].length)];
		
					if (removedItem != false)
					{
						Main.dataDict[Main.organizations[this.org]["countries"]][Main.dataDict[Main.organizations[this.org]["countries"]].length] = removedItem;
					}
				}
				while (Main.notMissionArray.indexOf(this.origin) == -1)
			}
			
			else
			{
				this.origin = origin;
			}
			
			if (payment == "random")
			{
				// FIX THIS
				this.payment = 50000000;
			}
			
			else
			{
				this.payment = payment;
			}
			
			this.expires = expires;
		}
		
		public function doMission():void
		{
			var pattern1:RegExp = /%ORIGIN/g;
			var pattern2:RegExp = /%COUNTRY/g;
			var pattern3:RegExp = /%ORIGINADJECTIVE/g;
			var pattern4:RegExp = /%COUNTRYADJECTIVE/g;
			
			var textFrom:String = Main.organizations[this.org]["string"][0];
			this.textString = Main.organizations[this.org]["string"][2];
			
			this.originHover = Main.organizations[this.org]["string"][3];
			this.countryHover = Main.organizations[this.org]["string"][4];
			trace("Mission, 121, ", Main.organizations[this.org]["string"][3], Main.organizations[this.org]["string"][4], Main.organizations[this.org]["string"]);
			trace(this.originHover, this.countryHover);
			
			if (this.origin != false)
			{
				textFrom = textFrom.replace(pattern3,Main.airportDict[this.origin]["adjective"]);
				this.textString = this.textString.replace(pattern3,Main.airportDict[this.origin]["adjective"]);
				textFrom = textFrom.replace(pattern1,this.origin);
				this.textString = this.textString.replace(pattern1,this.origin);
				
				Main.notMissionArray.splice(Main.notMissionArray.indexOf(this.origin), 1);
				Main.airportDict[this.origin]["mission"] = [this, "origin"];
			}
			
			if (this.country != false)
			{
				Main.notMissionArray.splice(Main.notMissionArray.indexOf(this.country), 1);
				Main.airportDict[this.country]["mission"] = [this, "country"];
			}
			
			textFrom = textFrom.replace(pattern4,Main.airportDict[this.country]["adjective"]);
			this.textString = this.textString.replace(pattern4,Main.airportDict[this.country]["adjective"]);
			textFrom = textFrom.replace(pattern2,this.country);
			this.textString = this.textString.replace(pattern2,this.country);
			
			var nMail:Mail = new Mail(textFrom, "Mission", this.textString, "MissionRequest", this.expires, this) 
			//Main.missionText.text = this.textString;
			//Main.missionText.setTextFormat(Main.hoverformat);
			//trace(Main.missionText.text);
		}
	}
}
