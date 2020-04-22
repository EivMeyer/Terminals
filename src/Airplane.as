
package 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.SimpleButton;
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import Explosion;
	import Route;
	import flash.utils.Timer;
	import flash.geom.ColorTransform;
	import fl.controls.Button;
	import flash.display.DisplayObject;

	final public class Airplane extends Sprite
	{
		public static var SPEED:Number = 0.5;

		public var lastX:int = 0;
		public var lastY:int = 0;
		public var lastRot:Number = 0;
		public var startingPoint_x:Number;
		public var startingPoint_y:Number;
		public var startingName:String;
		public var destination_x:Number;
		public var destination_y:Number;
		public var vector_x:Number;
		public var vector_y:Number;
		public var absvector:Number;
		public var vector:Array;
		public var stigningstall:Number;
		public var destroyed:Boolean = false;

		public var free:Boolean;
		public var waiting:Boolean;
		public var throughCheck:Boolean;
		public var flightRotation:Number;
		public var flightCounter:Number;
		public var circleMovement:Boolean;
		public var circleCounter:Number;
		public var currentLocation:String;
		public var continuationFlight:Boolean;
		public var budget:Number;
		public var passengers:int;
		public var landingQueue:Boolean;
		public var landingApproachQueue:Boolean;
		
		public var carryPlayer:Boolean = false;
		
		public var currentRoute;

		// FlightQueue..
		public var destX:Number;
		public var destY:Number;
		public var destName:String;
		
		public var nextPlan:Boolean;
		public var nextX:Number;
		public var nextY:Number;
		public var nextDest:String;
		public var nextMovO:Boolean;
		public var movingOn:Boolean;
		
		private var PMyParent:Sprite;
		
		public static var incomingTransport:Boolean = false;
		
		private var explosion:Explosion;

		public function Airplane(PMyParent, xValue:int = 0, yValue:int = 0, free:Boolean = true, waiting:Boolean = false, throughCheck:Boolean = false,  flightRotation:Number = 0, flightCounter:Number = 0, circleMovement:Boolean = false, circleCounter:Number = 0, currentLocation:String = "Open", playerTransport:Boolean = false, newCreation:Boolean = true, visibility:Boolean = false, rotationValue = 0, startingPoint_x = undefined, startingPoint_y = undefined, destination_x = undefined, destination_y = undefined, vector_x = undefined, vector_y = undefined, absvector = undefined, stigningstall = undefined, budget = false, passengers = false, landingQueue:Boolean = false, landingApproachQueue:Boolean = false, nextPlan:Boolean = false, nextX:Number = 0, nextY:Number = 0, nextDest:String = "", movingOn:Boolean = true, startingName:String = "", currentRoute = false):void
		{
			//trace("Opprettet fly ved: " + this.x + " " + this.y + " Free, currentlocation: " + this.free + " " + this.currentLocation);
			this.x = xValue;
			this.y = yValue;
			this.free = free;
			this.waiting = waiting;
			this.throughCheck = throughCheck;
			this.flightRotation = flightRotation;
			this.flightCounter = flightCounter;
			this.circleMovement = circleMovement;
			this.circleCounter = circleCounter;
			this.currentLocation = currentLocation;
			
			this.startingName = startingName;
			this.startingPoint_x = startingPoint_x;
			this.startingPoint_y = startingPoint_y;
			this.destination_x = destination_x;
			this.destination_y = destination_y;
			this.vector_x = vector_x;
			this.vector_y = vector_y;
			this.absvector = absvector;
			this.stigningstall = stigningstall;
			this.budget = budget;
			this.passengers = passengers;
			this.landingQueue = landingQueue;
			this.landingApproachQueue = landingApproachQueue;
			
			
			this.nextPlan = nextPlan;
			this.nextX = nextX;
			this.nextY = nextY;
			this.nextDest = nextDest;
			this.movingOn = movingOn;

			if (this.free == false)
			{
				this.vector = [this.vector_x / this.absvector,this.vector_y / this.absvector];
			}

			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.visible = visibility;
			this.rotation = rotationValue;

			if (newCreation == true && playerTransport == false)
			{
				Main.numPlanes +=  1;
				Main.airplane_field.text = String(Main.numActivePlanes) + " / " + String(Main.numPlanes);
				Main.airplane_field.setTextFormat(Main.airplane_format);
			}
			
			this.PMyParent = PMyParent;
			
			this.currentRoute = currentRoute;
			if (this.currentRoute != false)
			{
				Main.parentRouteDict[this.currentRoute]["numPlanes"] += 1;
				
				if (Line.selectedRoute.routeParent.parentRoute == this.currentRoute)
				{
					Main.numAirplanesText.text = String(Main.parentRouteDict[this.currentRoute]["numPlanes"])
					Main.numAirplanesText.setTextFormat(Main.cash_format);
				}
			}
			
			if (Main.currentLocation == this.currentLocation)
			{
				Main.numAirplanesTextR.text = String(int(Main.numAirplanesTextR.text) + 1)
				Main.numAirplanesTextR.setTextFormat(Main.cash_format);
			}
			
			Main.airportDict[this.currentLocation]["planesHere"] += 1;
		}



		public function Flight(startingPoint_x,startingPoint_y,destination_x,destination_y, destination, budget = false, passengers = false, continuationFlight:Boolean = false, carryingPlayer:Boolean = false, movingOn = true)
		{

			
			this.visible = true;
			//trace(budget);
			this.budget = budget;
			this.passengers = passengers;
			this.free = false;
			this.waiting = false;
			this.movingOn = movingOn;
			
			/*for (var countAi:int = 0; countAi < Main.airportDict[this.currentLocation]["flightQueue"].length; countAi++)
			{
				if (Main.airportDict[this.currentLocation]["flightQueue"][countAi][0] == this)
				{
					Main.airportDict[this.currentLocation]["flightQueue"].splice(countAi, 1);
				}
			}*/

			this.startingName = this.currentLocation;
			this.currentLocation = destination;
			this.continuationFlight = continuationFlight;

			this.flightCounter = 0;

			this.startingPoint_x = startingPoint_x;
			this.startingPoint_y = startingPoint_y;

			this.x = startingPoint_x;
			this.y = startingPoint_y;

			this.destination_x = destination_x;
			this.destination_y = destination_y;

			this.vector_x = this.destination_x - this.startingPoint_x;
			this.vector_y = this.startingPoint_y - this.destination_y;
			this.stigningstall = this.vector_y / this.vector_x;

			this.scaleX = Main.flightScale;
			this.scaleY = Main.flightScale;

			var inAirCounter:int = 0;

			for (var countSR:int = 0; countSR < Main.collectedAirportArray.length; countSR ++)
			{
				Main.airportDict[Main.collectedAirportArray[countSR].country]["planesHere"] = 0;
			}
			
			for (var countST:int = 0; countST < Main.collectedRouteArray.length; countST ++)
			{
				Main.collectedRouteArray[countST].numPlanes = 0;
			}

			for (var countR:int = 0; countR < Main.collectedAirplaneArray.length; countR ++)
			{
				if (Main.collectedAirplaneArray[countR].free == false)
				{
					inAirCounter +=  1;
				}
				
				else
				{
					Main.airportDict[Main.collectedAirplaneArray[countR].currentLocation]["planesHere"] += 1;
				}
				
				if (Main.collectedAirplaneArray[countR].currentRoute != false)
				{
					Main.parentRouteDict[Main.collectedAirplaneArray[countR].currentRoute]["numPlanes"] += 1;
				}
			}
			
			if (this.startingName == Main.currentLocation)
			{
				Main.numAirplanesTextR.text = String(Main.airportDict[this.startingName]["planesHere"])
				Main.numAirplanesTextR.setTextFormat(Main.cash_format);
			}

			Main.numActivePlanes = inAirCounter;
			Main.airplane_field.text = String(Main.numActivePlanes) + " / " + String(Main.numPlanes);
			Main.airplane_field.setTextFormat(Main.airplane_format);

			if (startingPoint_x < destination_x)
			{
				this.rotation = -(Math.atan((vector_y)/(vector_x)))/(Math.PI)*180;
			}
			else
			{
				this.rotation = 180-(Math.atan((vector_y)/(vector_x)))/(Math.PI)*180;
			}

			this.absvector = Math.sqrt(Math.pow((this.vector_x),2) + Math.pow((this.vector_y),2));
			this.vector = [this.vector_x / this.absvector,this.vector_y / this.absvector];

			var myColorTransformThingy:ColorTransform = new ColorTransform();
			if (this.budget)
			{
				myColorTransformThingy.color = 0x000000;
				
				Main.checkpointToLineDict[this.startingName + this.currentLocation].passengerArray[Main.checkpointToLineDict[this.startingName + this.currentLocation].passengerArray.length] = this.passengers;
				Main.checkpointToLineDict[this.startingName + this.currentLocation].incomeArray[Main.checkpointToLineDict[this.startingName + this.currentLocation].incomeArray.length] = this.budget;
				
				if (Main.checkpointToLineDict[this.startingName + this.currentLocation].passengerArray.length > 10)
				{
					Main.checkpointToLineDict[this.startingName + this.currentLocation].passengerArray.splice(0, 1);
					Main.checkpointToLineDict[this.startingName + this.currentLocation].incomeArray.splice(0, 1);
				}
				
				if (Line.selectedRoute == Main.checkpointToLineDict[this.startingName + this.currentLocation])
				{
					var incomeSum:int = 0;
					var passengerSum:int = 0;
					
					for (var ac:int = 0; ac < Main.checkpointToLineDict[this.startingName + this.currentLocation].passengerArray.length; ac ++)
					{
						incomeSum += Main.checkpointToLineDict[this.startingName + this.currentLocation].incomeArray[ac];
						passengerSum += Main.checkpointToLineDict[this.startingName + this.currentLocation].passengerArray[ac];
					}
					Main.average_income.text = String(Math.round(incomeSum / Main.checkpointToLineDict[this.startingName + this.currentLocation].incomeArray.length));
					Main.averagePassengersText.text = String(Math.round(passengerSum / Main.checkpointToLineDict[this.startingName + this.currentLocation].passengerArray.length));
					Main.average_income.setTextFormat(Main.cash_format);
					Main.averagePassengersText.setTextFormat(Main.airplane_format);
				}
			}
			else
			{
				myColorTransformThingy.color = 0xCC0000;
			}
			 // green: 0x00CC00
			 // red: 0xCC0000

			this.transform.colorTransform = myColorTransformThingy;
			
			this.carryPlayer = carryingPlayer;
			if (this.carryPlayer == true)
			{
				Main.player.transport = this;
			}
		}
		
		public function planFlight(toX, toY, toName, movOn):void
		{
			this.nextPlan = true;
			this.nextX = toX;
			this.nextY = toY;
			this.nextDest = toName;
			this.nextMovO = movOn;
		}

		public function crash():void
		{
			// MAY NEED COUNT INSTEAD OF THIS BUGGY SYSTEM
			if (this.currentRoute != false)
			{
				Main.parentRouteDict[Main.collectedAirplaneArray[countR].currentRoute]["numPlanes"] += 1;
				
				if (Line.selectedRoute != false)
				{
					if (Line.selectedRoute.routeParent.parentRoute == this.currentRoute)
					{
						Main.numAirplanesText.text = String(Main.parentRouteDict[Main.collectedAirplaneArray[countR].currentRoute]["numPlanes"])
						Main.numAirplanesText.setTextFormat(Main.cash_format);
					}
				}
			}
			
			// Play animation
			explosion = new Explosion(this.PMyParent);
			explosion.scaleX = Main.flightScale;
			explosion.scaleY = Main.flightScale;
			explosion.x = this.x + this.width * 0.5;
			explosion.y = this.y + this.height * 0.5;
			//trace(this.x, explosion.x, this.y, explosion.y);
			this.PMyParent.addChild(explosion);
			explosion.play();
			
			//trace("crash");
			this.visible = false;
			Main.collectedAirplaneArray.splice(Main.collectedAirplaneArray.indexOf(this), 1);

			this.free = false;
			this.destroyed = true;

			var inAirCounter:int = 0;

			for (var countR:int = 0; countR < Main.collectedAirplaneArray.length; countR ++)
			{
				if (Main.collectedAirplaneArray[countR].free == false)
				{
					inAirCounter +=  1;
				}
			}

			Main.numActivePlanes = inAirCounter;
			
			Main.numPlanes -= 1;

			Main.airplane_field.text = String(Main.numActivePlanes) + " / " + String(Main.numPlanes);
			Main.airplane_field.setTextFormat(Main.airplane_format);
			
			this.PMyParent.removeChild(this);
		}
	}
}