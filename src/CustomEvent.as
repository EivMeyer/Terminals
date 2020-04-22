package 
{
	import flash.utils.Dictionary;
	import fl.controls.Button;
	import RedSignal; 
	import Airport;
	import Mail;
	import Mission;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	public class CustomEvent
	{
		protected var random_country_int:int;
		protected var country;
		protected var causeCountry;

		protected var eventStatus:String;
		protected var eventDict;
		
		protected var bandName:String = "";
		protected var cometName:String = "";
		protected var gangName:String = "";

		protected var redDot;
		protected var eventCounter;

		protected var pMyParent;


		public function CustomEvent()
		{
			Main.event_field.x = 800;

			/*eventCounter = new Timer(30);
			eventCounter.addEventListener(TimerEvent.TIMER,CreateRedSignals);
			eventCounter.start();*/
		}

		protected function impact():void
		{
			if (this.country != "")
			{
				Main.airportDict[this.country]["popularity"] = Main.airportDict[this.country]["popularity"] * eventDict["popularityMultiplier"];
				Main.airportDict[this.country]["population"] = Main.airportDict[this.country]["population"] * eventDict["populationMultiplier"];
				Main.airportDict[this.country]["GDP"] = Main.airportDict[this.country]["GDP"] * eventDict["GDPMultiplier"];
			}

			if (this.causeCountry != false)
			{
				Main.airportDict[this.causeCountry]["popularity"] = Main.airportDict[this.causeCountry]["popularity"] * eventDict["CausePopularityMultiplier"];
				Main.airportDict[this.causeCountry]["population"] = Main.airportDict[this.causeCountry]["population"] * eventDict["CausePopulationMultiplier"];
				Main.airportDict[this.causeCountry]["GDP"] = Main.airportDict[this.causeCountry]["GDP"] * eventDict["CauseGDPMultiplier"];
			}

			if (eventDict["oilPriceMultiplier"] != false)
			{
				Main.fuel_constant +=  eventDict["oilPriceMultiplier"];
			}
			
			if (eventDict["danger"] != undefined)
			{
				Main.airportDict[this.country]["danger"] = eventDict["danger"];
			}
			
			if (eventDict["moneyChange"] != undefined)
			{
				//trace("Du har fått / blitt fratatt penger");
				Main.cash_field.text = String(int(Main.cash_field.text) + eventDict["moneyChange"]);
				Main.cash_field.setTextFormat(Main.cash_format);
			}
			
			if (eventDict["countries"] == "NotYetAdded")
			{
				var airport:Airport = new Airport(this.country,Main.airportDict[this.country]["cityname"], pMyParent);
				Main.notYetAdded.splice(Main.notYetAdded.indexOf(this.country), 1);
				airport.koordinater(Main.airportDict[this.country]["x"], Main.airportDict[this.country]["y"]);
				Main.Airport_array[Main.Airport_array.length] = this.country;
				Main.collectedAirportArray[Main.collectedAirportArray.length] = airport;
				Main.collectedAirportDict[this.country] = airport;
				airport.scaleY = Main.flightScale;
				airport.scaleX = Main.flightScale;
				pMyParent.bg_image.addChild(airport);
				
				if (this.country == "Mongolia")
				{
					Main.Poor_array[Main.Poor_array.length] = "Mongolia";
				}
				
				else if (this.country == "Congo")
				{
					Main.Poor_array[Main.Poor_array.length] = "Congo";
					Main.Tsunami_array[Main.Tsunami_array.length] = "Congo";
					Main.Pirate_array[Main.Pirate_array.length] = "Congo";
					Main.Malaria_array[Main.Malaria_array.length] = "Congo";
				}
				
				else if (this.country == "Kenya")
				{
					Main.Poor_array[Main.Poor_array.length] = "Kenya";
					Main.Tsunami_array[Main.Tsunami_array.length] = "Kenya";
					Main.Pirate_array[Main.Pirate_array.length] = "Kenya";
					Main.Malaria_array[Main.Malaria_array.length] = "Kenya";
				}
				
				else if (this.country == "Madagascar")
				{
					Main.Poor_array[Main.Poor_array.length] = "Madagascar";
					Main.Pirate_array[Main.Pirate_array.length] = "Madagascar";
					Main.Tsunami_array[Main.Tsunami_array.length] = "Madagascar";
					Main.Malaria_array[Main.Malaria_array.length] = "Madagascar";
				}
				
				else if (this.country == "Nigeria")
				{
					Main.Poor_array[Main.Poor_array.length] = "Nigeria";
					Main.Pirate_array[Main.Pirate_array.length] = "Nigeria";
					Main.Tsunami_array[Main.Tsunami_array.length] = "Nigeria";
					Main.Malaria_array[Main.Malaria_array.length] = "Nigeria";
				}
				
				else if (this.country == "Somalia")
				{
					Main.Poor_array[Main.Poor_array.length] = "Somalia";
					Main.Pirate_array[Main.Pirate_array.length] = "Somalia";
					Main.Tsunami_array[Main.Tsunami_array.length] = "Somalia";
					Main.Malaria_array[Main.Malaria_array.length] = "Somalia";
				}
				
				if (Main.notYetAdded.length == 0)
				{
					Main.randomEventArray.splice(Main.randomEventArray.indexOf(this.eventDict), 1);
				}
			}
		}
		
		protected function determineStatus():void
		{
			var textString:String = this.eventDict["status"];
			
			if (this.causeCountry != false)
			{
				var pattern:RegExp = /%CAUSECOUNTRY/g;
				textString = textString.replace(pattern,this.causeCountry);
			}
			
			Main.airportDict[this.country]["status"] = textString;
			
			if (this.country == Main.country_field.text)
			{
				Main.status_info.text = Main.airportDict[this.country]["status"];
				Main.status_info.setTextFormat(Main.hoverformat);
			}
			
			
			
		}
		
		protected function sendMail():void
		{
			if (this.eventDict["mail"] != false)
			{
				//trace(this.eventDict["mail"]);
				var i0 = this.eventDict["mail"][0];
				var i1 = this.eventDict["mail"][1];
				var i2 = this.eventDict["mail"][2];
				
				var patter1:RegExp = /%TARGETCOUNTRY/g;
				var patter2:RegExp = /%TARGETCITY/g;
				var patter3:RegExp = /%TARGETADJECTIVE/g;
	
				var patter4:RegExp = /%CAUSECOUNTRY/g;
				var patter5:RegExp = /%CAUSECITY/g;
				var patter6:RegExp = /%CAUSEADJECTIVE/g;
				
				i0 = i0.replace(patter1,this.country);
				i0 = i0.replace(patter2,Main.airportDict[this.country]["city"]);
				i0 = i0.replace(patter3,Main.airportDict[this.country]["adjective"]);
				i1 = i1.replace(patter1,this.country);
				i1 = i1.replace(patter2,Main.airportDict[this.country]["city"]);
				i1 = i1.replace(patter3,Main.airportDict[this.country]["adjective"]);
				i2 = i2.replace(patter1,this.country);
				i2 = i2.replace(patter2,Main.airportDict[this.country]["city"]);
				i2 = i2.replace(patter3,Main.airportDict[this.country]["adjective"]);
				
				if (this.causeCountry != false && this.causeCountry != "")
				{
					i0 = i0.replace(patter4,this.causeCountry);
					i0 = i0.replace(patter5,Main.airportDict[this.causeCountry]["city"]);
					i0 = i0.replace(patter6,Main.airportDict[this.causeCountry]["adjective"]);		
					i1 = i1.replace(patter4,this.causeCountry);
					i1 = i1.replace(patter5,Main.airportDict[this.causeCountry]["city"]);
					i1 = i1.replace(patter6,Main.airportDict[this.causeCountry]["adjective"]);	
					i2 = i2.replace(patter4,this.causeCountry);
					i2 = i2.replace(patter5,Main.airportDict[this.causeCountry]["city"]);
					i2 = i2.replace(patter6,Main.airportDict[this.causeCountry]["adjective"]);	
				}
				
				var i3 = this.eventDict["mail"][3];
				var i4 = this.eventDict["mail"][4];
				var mMail:Mail = new Mail(i0, i1, i2, i3, i4);
			}
		}

		protected function determineCountry(countryArray:Array):String
		{
			trace(this.eventDict["String"]);
			trace("CountryArray: " + countryArray);
			for (var CountR:uint = 0; CountR < countryArray.length; CountR ++)
			{
				if (countryArray[CountR] == this.country)
				{
					var removedItem:String = countryArray[CountR];
					countryArray.splice(CountR, 1);
				}
			}

			this.random_country_int = Math.floor(Math.random() * countryArray.length);

			if (removedItem)
			{
				countryArray[countryArray.length] = removedItem;
			}
			return countryArray[this.random_country_int];
			
			/*else
			{
				return "";
			}*/
		}

		/*protected function CreateRedSignals(evt:TimerEvent):void
		{
			if (Main.bm.x + Main.bm.width > 250)
			{
				if (eventCounter.currentCount % 100 == true)
				{
					redDot = new RedSignal(Main.airportDict[this.country]["x"],Main.airportDict[this.country]["y"]);
					pMyParent.bg_image.addChildAt(redDot,1);
				}
			}
			else
			{
				eventCounter.reset;
				eventCounter.removeEventListener(TimerEvent.TIMER,CreateRedSignals);
				eventCounter = null;

			}

		}*/

		protected function determineConsequence():void
		{
			Main.newsQueue[Main.newsQueue.length] = new Array(eventDict["following"][Math.floor(Math.random() * eventDict["following"].length)],this.country,this.causeCountry, this.bandName, this.cometName, this.gangName);
		}

		protected function determineAccessibility():void
		{
			if (this.eventDict["accessible"] != "")
			{
				Main.airportDict[this.country]["accessibility"] = this.eventDict["accessible"];
				
				if (this.causeCountry != false)
				{
					Main.airportDict[this.causeCountry]["accessibility"] = this.eventDict["accessible"];
				}
			}
		}

		protected function determineEnding():void
		{
			if (eventDict["ending"] != false)
			{
				if (this.eventDict["radius"] == false)
				{
					if (this.eventDict["spreadRisk"] != false || this.causeCountry != false)
					{
						if (this.eventDict["spreadRisk"] != false)
						{
							//trace("Pushed spreadRisk ending to news waiting queue");
							Main.newsWaitingQueue[Main.newsWaitingQueue.length] = new Array(new Array(this.eventDict["ending"],determineCountry(Main.dataDict[this.eventDict["spreadRisk"]]),this.country, this.bandName, this.cometName, this.gangName),new Array(Main.dateNow.getDate() + 1,Main.dateNow.getMonth() + this.eventDict["duration"],Main.dateNow.getFullYear()));
						}
						else
						{
							//trace("Pushed spreadRisk ending to news waiting queue");
							Main.newsWaitingQueue[Main.newsWaitingQueue.length] = new Array(new Array(this.eventDict["ending"],this.country,this.causeCountry, this.bandName, this.cometName, this.gangName),new Array(Main.dateNow.getDate() + 1,Main.dateNow.getMonth() + this.eventDict["duration"],Main.dateNow.getFullYear()));
						}
						Main.dataDict[this.eventDict["countries"]][Main.dataDict[this.eventDict["countries"]].length] = this.country;
					}
					else
					{
						//trace("Pushed non -spreadRisk ending to news waiting queue");
						if (this.eventStatus == "random")
						{
							Main.newsWaitingQueue[Main.newsWaitingQueue.length] = new Array(new Array(this.eventDict["ending"],this.country,false, this.bandName, this.cometName, this.gangName),new Array(Main.dateNow.getDate() + 1,Main.dateNow.getMonth() + this.eventDict["duration"],Main.dateNow.getFullYear()));
						}
						else
						{
							Main.newsWaitingQueue[Main.newsWaitingQueue.length] = new Array(new Array(this.eventDict["ending"],this.country,false, this.bandName, this.cometName, this.gangName),new Array(Main.dateNow.getDate() + 1,Main.dateNow.getMonth() + this.eventDict["duration"],Main.dateNow.getFullYear()));
						}
					}
				}
				else
				{
					if (this.eventDict["radius"] != false)
					{
						for (var counter:uint=0; counter < Main.Airport_array.length; counter++)
						{
							if (Math.sqrt(Math.pow((Main.airportDict[Main.Airport_array[counter]]["x"]-Main.airportDict[this.country]["x"]), 2) + Math.pow((Main.airportDict[Main.Airport_array[counter]]["y"]-Main.airportDict[this.country]["y"]), 2)) < this.eventDict["radius"])
							{
								if (this.country != Main.Airport_array[counter])
								{
									if (Main.airportDict[this.country]["accessible"] == true)
									{
										Main.newsQueue[Main.newsQueue.length] = new Array(this.eventDict["ending"],Main.Airport_array[counter],this.country, this.bandName, this.cometName, this.gangName);
									}
								}
							}
						}
					}
				}

			}
		}

		protected function editTextBox():void
		{
			var textString = eventDict["String"];

			var pattern1:RegExp = /%TARGETCOUNTRY/g;
			var pattern2:RegExp = /%TARGETCITY/g;
			var pattern3:RegExp = /%TARGETADJECTIVE/g;

			var pattern4:RegExp = /%CAUSECOUNTRY/g;
			var pattern5:RegExp = /%CAUSECITY/g;
			var pattern6:RegExp = /%CAUSEADJECTIVE/g;

			var pattern7:RegExp = /%RANDOMNUMBER/g;
			
			var pattern8:RegExp = /%RANDOMBAND/g;
			var pattern9:RegExp = /%BAND/g;
			
			var pattern10:RegExp = /%RANDOMCOMET/g;
			var pattern11:RegExp = /%COMET/g;
			
			var pattern12:RegExp = /%RANDOMGANG/g;
			var pattern13:RegExp = /%GANG/g;

			if (this.country != false && this.country != "")
			{
				trace("CustomEvent, 354", this.country);
				textString = textString.replace(pattern1,this.country);
				textString = textString.replace(pattern2,Main.airportDict[this.country]["city"]);
				textString = textString.replace(pattern3,Main.airportDict[this.country]["adjective"]);
			}
			
			if (this.causeCountry != false && this.causeCountry != "")
			{
				textString = textString.replace(pattern4,this.causeCountry);
				textString = textString.replace(pattern5,Main.airportDict[this.causeCountry]["city"]);
				textString = textString.replace(pattern6,Main.airportDict[this.causeCountry]["adjective"]);
			}
			else
			{
				textString = textString.replace(pattern4,"");
				textString = textString.replace(pattern5,"");
				textString = textString.replace(pattern6,"");
			}

			textString = textString.replace(pattern7,String(Math.round(Math.random() * 7) + 3));

			if (textString.search("%RANDOMBAND") != -1)
			{
				this.bandName = Main.bandNames[Math.floor(Math.random() * Main.bandNames.length)];
				textString = textString.replace(pattern8, this.bandName);
			}
			
			textString = textString.replace(pattern9, this.bandName);
			
			if (textString.search("%RANDOMCOMET") != -1)
			{
				this.cometName = Main.cometArray[Math.floor(Math.random() * Main.cometArray.length)];
				trace(this.cometName);
				textString = textString.replace(pattern10, this.cometName);
			}
			textString = textString.replace(pattern11, this.cometName);
			
			if (textString.search("%RANDOMGANG") != -1)
			{
				this.gangName = Main.gangArray[Math.floor(Math.random() * Main.gangArray.length)];
				textString = textString.replace(pattern12, this.gangName);
			}
			textString = textString.replace(pattern13, this.cometName);
			
			

			Main.event_field.text = textString;
			Main.event_field.setTextFormat(Main.dateFormat);
			Main.event_field.width = Main.event_field.textWidth + 5;

			Main.bmd = new BitmapData(Main.event_field.width,Main.event_field.height,true,0);
			Main.bmd.draw(Main.event_field);

			pMyParent.removeChild(Main.bm);
			Main.bm = new Bitmap(Main.bmd);
			Main.bm.visible = true;
			Main.bm.x = Main.event_field.x + 75;
			Main.bm.y = Main.event_field.y;
			Main.bm.smoothing = true;
			pMyParent.addChild(Main.bm);
			Main.bm.mask = Main.eventMask;

			if (this.country != false)
			{
				Main.event_country.text = Main.airportDict[this.country]["name"].toUpperCase();
				Main.currentNewsPlace = Main.airportDict[this.country]["name"];
				Main.event_country.setTextFormat(Main.importantRedFormat);
			}
			
			else
			{
				Main.event_country.text = "";
				Main.currentNewsPlace = "";
			}
		}
		
		public function leadToMissions():void
		{
			if (this.eventDict["mission"] != false && Main.tutorial == false)
			{
				/*trace("Tryings to initiate mission..");
				trace(this.eventDict["String"]);
				trace(this.eventDict["mission"]);
				trace(Main.organizations);
				trace(Main.organizations[this.eventDict["mission"]]);
				trace("WID", Main.organizations.length);
				trace(Main.organizations[this.eventDict["mission"]]["type"]);*/
				
				var newMission:Mission = new Mission();
				
				if (Main.organizations[this.eventDict["mission"]]["type"] == "transport")
				{
					if (Main.notMissionArray.indexOf(this.country) != -1)
					{
						newMission.declareVariables(this.eventDict["mission"], "random", this.country, Main.airplanePrice * 10, Main.organizations[this.eventDict["mission"]]["expires"], "transport", Main.organizations[this.eventDict["mission"]]["relation"]);
					}
					else
					{
						return;
					}
				}
					
				else if (Main.organizations[this.eventDict["mission"]]["type"] == "setUpRoute")
				{
					if (Main.notMissionArray.indexOf(this.country) != -1)
					{
						newMission.declareVariables(this.eventDict["mission"], false, this.country, Main.airplanePrice * 10, Main.organizations[this.eventDict["mission"]]["expires"], "setUpRoute", Main.organizations[this.eventDict["mission"]]["relation"]);
					}
					else
					{
						return;
					}
				}
					
				else if (Main.organizations[this.eventDict["mission"]]["type"] == "targetedtransport")
				{
					if (Main.notMissionArray.indexOf(this.country) != -1 && Main.notMissionArray.indexOf(this.causeCountry) != -1)
					{
						newMission.declareVariables(this.eventDict["mission"], this.country, this.causeCountry, Main.airplanePrice * 10, Main.organizations[this.eventDict["mission"]]["expires"], "targetedtransport", Main.organizations[this.eventDict["mission"]]["relation"]);
					}
					else
					{
						return;
					}
				}
				trace("Leading to missions");
				newMission.doMission();
			}
		}
	}
}