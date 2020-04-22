package 
{

	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Shape;
	import flash.utils.Dictionary;
	import flash.geom.ColorTransform;
	import Airplane;
	import Main;

	final public class Route
	{
		public var routePoints:Array;
		public var routeTimer:Timer;

		public var frequency_input:String;
		public var ticket_price:Number;
		public var flight_interval:Number;
		
		public var lineDisplay:Line;

		protected var calculateReport:Array;
		protected var budget:Number;
		protected var passengersOnFlight:int;
		
		public var numPlanes:uint = 0;
		
		//public var deficit:int = 1;
		public var routeCountries:Array = [];
		
		public var cMission = false;
		
		public var parentRoute:int;
		
		//public static const termArray:Array = [200, 300, 400];
		public static const frequency_dict:Object = 
		{
			"Low": [6000, 0],
			"Medium": [4000, 1],
			"High": [2000, 2]
		}
		
		public static const frequency_inverse_dict:Object = 
		{
			6000: 0,
			4000: 1,
			2000: 2
		}
		
		// ------------

		private var myparent:Main;


		public function Route(route_array:Array, pMyParent, prices, frequency, parentRoute:int)
		{
			trace("Constructing route..");
			
			trace(prices, frequency, 55);
			this.ticket_price = Number(prices);
			this.frequency_input = frequency;

			this.flight_interval = frequency_dict[frequency_input][0];

			this.myparent = pMyParent;
			this.routePoints = route_array;
			this.parentRoute = parentRoute;
			
			trace(this.routePoints.length);
			
			Main.routeArray[Main.routeArray.length] = new Array(this.routePoints, this.ticket_price, this.frequency_input, this);
			Main.collectedRouteArray[Main.collectedRouteArray.length] = this;

			routeTimer = new Timer(this.flight_interval);
			routeTimer.addEventListener(TimerEvent.TIMER, route_function);
			routeTimer.start();
			
			Main.airportDict[routePoints[routePoints.length-1][2]]["priority"] = 1;
			Main.airportDict[routePoints[routePoints.length-1][2]]["incomingroutes"] += 1;
			
			this.routeCountries[this.routeCountries.length] = routePoints[0][2];
				
			Main.airportDict[routePoints[0][2]]["active"] = true;
			if (Main.Active_array.indexOf(routePoints[0][2]) == -1)
			{
				Main.Active_array[Main.Active_array.length] = routePoints[0][2];
			}
			Main.airportDict[routePoints[0][2]]["priority"] = 1;
			Main.airportDict[routePoints[0][2]]["routes"] += 1;
				
			Main.airportDict[routePoints[1][2]]["incomingroutes"] += 1;

			this.lineDisplay = new Line(routePoints[0][0], routePoints[0][1], routePoints[0 + 1][0], routePoints[0 + 1][1], this, routePoints[0][2], routePoints[0 + 1][2]);
			this.myparent.bg_image.addChildAt(this.lineDisplay,2);
			Main.lineArray[Main.lineArray.length] = this.lineDisplay;
			Main.checkpointToLineDict[routePoints[0][2] + routePoints[0 + 1][2]] = this.lineDisplay;
			
			if (Main.randomEventArray.indexOf(Main.E_RacistVideo) == -1)
			{
				Main.randomEventArray[Main.randomEventArray.length] = Main.E_RacistVideo;
			}
			
			edit_red_rep();
			
			if (Main.currentMissions.length > 0)
			{
				for (var mis:int = 0; mis < Main.currentMissions.length; mis++)
				{
					if (Main.currentMissions[mis].Type == "setUpRoute")
					{
						for (var rp:int = 0; rp < this.routePoints.length; rp ++)
						{
							trace("Routepoints: ", this.routePoints[rp][2])
							trace("MissionCountry: ", Main.currentMissions[mis]["country"]); 
							if (this.routePoints[rp][2] == Main.currentMissions[mis]["country"])
							{
								//trace("You won mission");
								//trace(currentMission["org"], "Mission Reward", currentMission["endingString"], "MissionReward");
								for (var iou:int = 0; iou < Main.currentMissions[mis]["endingStrings"].length; iou ++)
								{
									var mao = Main.currentMissions[mis]["endingStrings"][iou];
									
									var pattern2:RegExp = /%COUNTRY/g;
									var pattern4:RegExp = /%COUNTRYADJECTIVE/g;
									
									var textFrom:String = mao[0];
									var textString = mao[2];
									
									textFrom = textFrom.replace(pattern4,Main.airportDict[Main.currentMissions[mis]["country"]]["adjective"]);
									textString = textString.replace(pattern4,Main.airportDict[Main.currentMissions[mis]["country"]]["adjective"]);
									textFrom = textFrom.replace(pattern2,Main.currentMissions[mis]["country"]);
									textString = textString.replace(pattern2,Main.currentMissions[mis]["country"]);
									
									var nMail = new Mail(textFrom, mao[1], textString, mao[3], mao[4], Main.currentMissions[mis]);
								}
								
								Main.currentMissions[mis].missionSuccess = 0.5;
								this.cMission = Main.currentMissions[mis]
								break;
							}
						}
					}
				}
			}
		}
		
		private function route_function(event:TimerEvent):void
		{
			if (Main.airportDict[routePoints[0][2]]["accessibility"] == true && Main.airportDict[routePoints[0 + 1][2]]["accessibility"] == true)
			{
				this.calculateReport = calculate_income(routePoints[0][2],routePoints[0 + 1][2]);
				this.budget = calculateReport[0];
				//trace("BUDGET: " + this.budget);
				this.passengersOnFlight = calculateReport[1];


				if (Main.numPlanes > Main.numActivePlanes)
				{
					var bLoop:Boolean = false;
					var goodDestinationCounter:int = 0;
					
					for (var countR:int = 0; countR < Main.collectedAirplaneArray.length; countR ++)
					{
						if (Main.collectedAirplaneArray[countR].currentLocation == routePoints[0][2])
						{
							//trace(Main.collectedAirplaneArray[countR].currentRoute);
							if (Main.collectedAirplaneArray[countR].free == true && Main.collectedAirplaneArray[countR].waiting != true && Main.collectedAirplaneArray[countR].movingOn == true && (Main.collectedAirplaneArray[countR].currentRoute == this.parentRoute || Main.collectedAirplaneArray[countR].currentRoute == false)) // mulig parantesfeil her
							{
								if (bLoop == false)
								{
									Main.parentRouteDict[this.parentRoute]["deficit"] = Math.min(10, Main.parentRouteDict[this.parentRoute]["deficit"] - 1);
									Main.parentRouteDict[this.parentRoute]["deficit"] = Math.max(1, Main.parentRouteDict[this.parentRoute]["deficit"] - 1);
									
									Main.airportDict[routePoints[0][2]]["flightQueue"][Main.airportDict[routePoints[0][2]]["flightQueue"].length] = [Main.collectedAirplaneArray[countR], routePoints[0][0],routePoints[0][1], routePoints[0 + 1][0],routePoints[0 + 1][1], routePoints[0 + 1][2], this.budget, this.passengersOnFlight, false, false, true];
									
									Main.collectedAirplaneArray[countR].waiting = true;
									
									Main.collectedAirplaneArray[countR].currentRoute = this.parentRoute;
									
									
									bLoop = true;
										
										
									if (this.cMission != false)
									{
										trace("This. mission0", this.cMission.missionCounter);
										cMission.missionCounter += 1
										
										if (this.cMission.missionCounter == 30)
										{
											var lMail = new Mail(this.cMission["org"], "Mission Reward", "Thanks for your support stupid bitch", "MissionReward", false, this.cMission);
											if (this.cMission.country != false)
											{
												Main.airportDict[this.cMission]["relation"] = this.cMission.relation;
											}
											Main.currentMissions.splice(Main.currentMissions.indexOf(this.cMission), 1);
											this.cMission.missionSuccess = 1;
											Main.airportDict[this.cMission.country]["popularity"] *= 3;
											this.cMission = false;
											Main.notMissionArray[Main.notMissionArray.length] = this.cMission.country;
											Main.airportDict[this.cMission.country]["mission"] = false;
										}
									}
								}
							}
							else
							{
								goodDestinationCounter += 1;
							}
						}
					}
					if (bLoop == false)
					{
						Main.parentRouteDict[this.parentRoute]["deficit"] = Math.min(10, Main.parentRouteDict[this.parentRoute]["deficit"] + 1);
						Main.parentRouteDict[this.parentRoute]["deficit"] = Math.max(1, Main.parentRouteDict[this.parentRoute]["deficit"] + 1);
					}
				}
				this.edit_color(budget, 0, Main.airportDict[routePoints[0][2]]["accessibility"], Main.airportDict[routePoints[0 + 1][2]]["accessibility"]);
			}
		}
		private function calculate_income(startingPoint, destination):Array
		{
			var randomFactor:int = int(Math.random() * 10);
			var InterestStartingPoint:Number = Main.airportDict[startingPoint]["popularity"] + (2 * Main.airportDict[startingPoint]["GDP"] + Main.airportDict[startingPoint]["population"]) * (2*Main.airportDict[startingPoint]["reputation"] + 0.5 * Main.airportDict[startingPoint]["bluereputation"]);
			var InterestDestination:Number = Main.airportDict[destination]["popularity"] + Main.airportDict[destination]["population"];
			var CounterInterestHome:Number = 0.005 * (300 + this.ticket_price) * Main.airportDict[destination]["popularity"]/(Main.airportDict[destination]["reputation"]+4);
			var CounterInterestAway:Number =  this.flight_interval*(2 * Main.airportDict[startingPoint]["GDP"] * + Main.airportDict[startingPoint]["population"]) / (24000 * (Main.airportDict[startingPoint]["reputation"]+1));
			var CounterInterest:Number = CounterInterestHome +  CounterInterestAway;
			var totalInterest:Number = 0.1 * (InterestStartingPoint + InterestDestination - CounterInterest);
			var passengers = Math.min(totalInterest + randomFactor,Main.planeCapacity);
			passengers = Math.max(passengers,randomFactor);
			passengers = int(passengers);
			var generalCost:Number = 2000000 / this.flight_interval + 10000 + (Main.fuel_constant+Main.fuel_cosinus)*Math.sqrt(Math.pow((Main.airportDict[destination]["x"]-Main.airportDict[startingPoint]["x"]),2) + Math.pow((Main.airportDict[startingPoint]["y"]-Main.airportDict[destination]["y"]),2));
			var EARNINGS:Number = passengers * this.ticket_price - generalCost;

			/*trace(startingPoint, " - ", destination);
			trace("Random Factor: ", randomFactor);
			trace("Interest Start: ", InterestStartingPoint);
			trace("Interest Destination: ", InterestDestination);
			trace("Counter Interest Home: ",  CounterInterestHome);
			trace("Counter Interest Away: ",  CounterInterestAway);
			trace("Counter Interest Total: ", CounterInterest);
			trace("Sum Interest: ", totalInterest);
			trace("Fuelcost: ", generalCost);
			trace("Passengers: ", passengers, "/", Main.planeCapacity);
			trace("Ticket Price: ", this.ticket_price);
			trace("Profit: ", EARNINGS);
			trace("------------------------------");*/
			return new Array(0.25*EARNINGS, passengers);
		}
		private function edit_color(sum, order, accessStart, accessDestination)
		{
			var myColorTransformThingy:ColorTransform = new ColorTransform();
			if (sum > 0)
			{
				myColorTransformThingy.color = 0x1A4BB6;
				//trace("Sum over");
			}
			else
			{
				myColorTransformThingy.color = 0xCC0000;
				//trace("Sum under");
			}
			if (accessStart == false)
			{
				myColorTransformThingy.color = 0x000000;
			}
			if (accessDestination == false)
			{
				myColorTransformThingy.color = 0x000000;
			}
			this.lineDisplay.transform.colorTransform = myColorTransformThingy;
		}

		private function edit_red_rep()
		{
			Main.airportDict[routePoints[0][2]]["bluereputation"] =  Math.min(1, Main.airportDict[routePoints[0][2]]["bluereputation"] + 0.1);
			Main.airportDict[routePoints[0][2]]["bluereputation"] =  Math.max(0.1, Main.airportDict[routePoints[0][2]]["bluereputation"]);
		}
	}
}