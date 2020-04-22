package 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.utils.Dictionary;
	import fl.controls.NumericStepper;
	import flash.media.Sound;
	
	final public class Line extends Sprite
	{
		public static var selectedRoute = false;
		public static var selectedRouteIndex:int = 0;
		public static var cSelectedIndex:int;
		public var standardLine:Sprite
		public var familyHoverLine:Sprite;
		public var hoverLine:Sprite;
		public static var standardWidth:Number = 3.5;
		public static var hoverWidth:Number = 5;
		public var routeParent;
		public var alphaCounter:Boolean = false;
		public var alphaIng:Boolean = false;
		public var incomeArray:Array;
		public var passengerArray:Array;
		
		private var interFace2:Sound = new InterFace2();
		private var interFace1:Sound = new Interface1();
		private var reject1:Sound = new Reject1();
		
		public static var selectedLines:Array = new Array();
		
		private var xStart:Number;
		private var yStart:Number;
		private var xFinish:Number;
		private var yFinish:Number;
		
		public var startN:String;
		public var finishN:String;
		
		public static var tutorialRoute:Line;
		
		
		public function Line(xStart, yStart, xFinish, yFinish, routeParent, startN, finishN)
		{			
			this.alpha = 1.0;
			
			this.xStart = xStart;
			this.yStart = yStart;
			this.xFinish = xFinish;
			this.yFinish = yFinish;
			
			this.startN = startN;
			this.finishN = finishN;
			
			if (this.startN == "Germany" && this.finishN == "France" && Main.tutorial == true && Main.tutorialStep == 10)
			{
				Line.tutorialRoute = this;
			}
			
			this.routeParent = routeParent;
			
			this.passengerArray = new Array();
			this.incomeArray = new Array();
			
			this.standardLine = new Sprite();
			this.addChild(this.standardLine);
			this.standardLine.graphics.lineStyle(Main.flightScale * standardWidth, 0x990000, .35);
			this.standardLine.graphics.beginFill(0x00FF00);
			this.standardLine.graphics.moveTo(xStart, yStart);
			this.standardLine.graphics.lineTo(xFinish, yFinish);
			
			this.familyHoverLine = new Sprite();
			this.addChild(this.familyHoverLine);
			this.familyHoverLine.graphics.lineStyle(Main.flightScale * 0.7*hoverWidth, 0x990099, 1);
			this.familyHoverLine.graphics.beginFill(0x00FF00);
			this.familyHoverLine.graphics.moveTo(xStart, yStart);
			this.familyHoverLine.graphics.lineTo(xFinish, yFinish);
			this.familyHoverLine.alpha = 0;
			
			this.hoverLine = new Sprite();
			this.addChild(this.hoverLine);
			this.hoverLine.graphics.lineStyle(Main.flightScale * hoverWidth, 0x990099, 1);
			this.hoverLine.graphics.beginFill(0x00FF00);
			this.hoverLine.graphics.moveTo(xStart, yStart);
			this.hoverLine.graphics.lineTo(xFinish, yFinish);
			this.hoverLine.alpha = 0;
			this.hoverLine.addEventListener(MouseEvent.MOUSE_OVER, hoverFunction);
		}
		
		private function hoverFunction(evt:MouseEvent):void
		{
			interFace1.play();
			this.hoverLine.alpha = 0.5;
			this.hoverLine.addEventListener(MouseEvent.MOUSE_OUT, outHover);
			this.hoverLine.addEventListener(MouseEvent.RIGHT_CLICK, sendPlane);
		}
		
		private function outHover(evt:MouseEvent):void
		{
			if (selectedRoute != this)
			{
				this.hoverLine.alpha = 0;
			}
			this.hoverLine.removeEventListener(MouseEvent.MOUSE_OUT, outHover);
		}
		
		public function zoomFunction():void
		{
			//trace("Zoom confirmed");
			this.standardLine.graphics.clear();
			
			this.standardLine.graphics.lineStyle(Main.flightScale * standardWidth, 0x990000, .35);
			this.standardLine.graphics.beginFill(0x00FF00);
			this.standardLine.graphics.moveTo(this.xStart, this.yStart);
			this.standardLine.graphics.lineTo(this.xFinish, this.yFinish);
			
			this.hoverLine.graphics.clear();
			
			this.hoverLine.graphics.lineStyle(Main.flightScale * hoverWidth, 0x990099, 1);
			this.hoverLine.graphics.beginFill(0x00FF00);
			this.hoverLine.graphics.moveTo(this.xStart, this.yStart);
			this.hoverLine.graphics.lineTo(this.xFinish, this.yFinish);
		}
		
		public function showInfo():void
		{
			if (Airport.currentSelect != false)
			{
				Airport.currentSelect.airportB.visible = false;
				Airport.currentSelect.airportS.visible = true;
				
				if (Airport.currentSelect.greenAirportB.visible == true)
				{
					Airport.currentSelect.greenAirport.visible = true;
					Airport.currentSelect.greenAirportB.visible = false;
				}
				
				if (Airport.currentSelect.blueAirportB.visible == true)
				{
					Airport.currentSelect.blueAirport.visible = true;
					Airport.currentSelect.blueAirportB.visible = false;
				}
			}
			
			trace("Main, 148");
			trace(Main.tutorialStep, Main.tutorialLine, this.routeParent.parentRoute);
			if (Main.tutorial == true && Main.tutorialStep == 18 && Main.tutorialLine == this.routeParent.parentRoute)
			{
				Main.tutorialStep = 19;
				Main.hovertext.text = "Rightclick on the route to Ukraine to transfer planes to it.";
				Main.TUTORIALTEXT =  "Rightclick on the route to Ukraine to transfer planes to it.";
				Main.hovertext.setTextFormat(Main.hoverformat);
			}
			
			interFace2.play();
				
			Airport.currentSelect = false;
			
			Main.buyTerminalButton.visible = false;
			Main.buyTerminalGreyButton.visible = false;
			Main.buyAntiAir.visible = false;
			Main.buyAntiAirGrey.visible = false;
			Main.buymarketing.visible = false;
			Main.modify_route.visible = true;
			Main.buyplane.visible = false;
			Main.removeterminal.visible = true;
			Main.create_new_route.visible = false;
			Main.buylanding.visible = false;
			Main.delete_button.visible = true;
			Main.store_board.visible = true;
			
			if (this.passengerArray.length > 0)
			{
				var incomeSum:int = 0;
				var passengerSum:int = 0;
						
				for (var ac:int = 0; ac < this.passengerArray.length; ac ++)
				{
					incomeSum += this.incomeArray[ac];
					passengerSum += this.passengerArray[ac];
				}
				Main.average_income.text = String(Math.round(incomeSum / this.incomeArray.length));
				Main.averagePassengersText.text = String(Math.round(passengerSum / this.passengerArray.length));
				Main.average_income.setTextFormat(Main.cash_format);
				Main.averagePassengersText.setTextFormat(Main.airplane_format);
			}
			
			else
			{
				Main.average_income.text = String(0);
				Main.averagePassengersText.text = String(0);
				Main.average_income.setTextFormat(Main.cash_format);
				Main.averagePassengersText.setTextFormat(Main.airplane_format);
			}
				
			if (selectedRoute != false)
			{
				selectedRoute.hoverLine.alpha = 0;
				
				for (var slc:int = 0; slc < Main.parentRouteDict[selectedRoute.routeParent.parentRoute]["lines"].length; slc ++)
				{
					Main.parentRouteDict[selectedRoute.routeParent.parentRoute]["lines"][slc].lineDisplay.familyHoverLine.alpha = 0;
				}
			}
			
			this.hoverLine.alpha = 0.5;
			Main.country_board.visible = false;
			Main.player_board.visible = false;
			Main.route_board.visible = true;
			
			Main.route_text.text = this.startN + " - " + this.finishN;
			Main.route_text.setTextFormat(Main.modify_format);
			
			Main.numAirplanesText.text = String(Main.parentRouteDict[this.routeParent.parentRoute]["numPlanes"])
			Main.numAirplanesText.setTextFormat(Main.cash_format);			
			
			Main.Rfrequency_input.value = Route.frequency_inverse_dict[this.routeParent.flight_interval] + 1;
			
			if (Main.Rfrequency_input.value == 1)
			{
				Main.Rfrequency_show.text = "Low";
				Main.Rfrequency_show.setTextFormat(Main.lowFormat);
			}
			else if (Main.Rfrequency_input.value == 2)
			{
				Main.Rfrequency_show.text = "Medium";
				Main.Rfrequency_show.setTextFormat(Main.mediumFormat);
			}
			else if (Main.Rfrequency_input.value == 3)
			{
				Main.Rfrequency_show.text = "High";
				Main.Rfrequency_show.setTextFormat(Main.highFormat);
			}
			Main.Rprice_input.value = int(this.routeParent.ticket_price) - 99;
			trace("AA", this.routeParent.ticket_price);
			Main.Rprice_show.text = this.routeParent.ticket_price;
			
			if (int(this.routeParent.ticket_price) < 233)
			{
				Main.Rprice_show.setTextFormat(Main.lowFormat);
			}
			
			else if (int(this.routeParent.ticket_price) >= 233 && int(this.routeParent.ticket_price) < 370)
			{
				Main.Rprice_show.setTextFormat(Main.mediumFormat);
			}
			
			else
			{
				Main.Rprice_show.setTextFormat(Main.highFormat);
			}
			
			selectedRoute = this;
			
			for (var linI:int = 0; linI < Main.lineArray.length; linI ++)
			{
				if (Main.lineArray[linI] == this)
				{
					//trace("found match");
					cSelectedIndex = linI;
				}
				else if (Main.lineArray[linI].routeParent.parentRoute == this.routeParent.parentRoute)
				{
					Main.lineArray[linI].familyHoverLine.alpha = 0.3;
				}
			}
		}
		
		private function sendPlane(evt:MouseEvent):void
		{
			if (Line.selectedRoute != false && Line.selectedRoute != this)
			{
				var returnPlane = false;
				var breakLoop:Boolean = false;
				
				trace("Looking for planes");
				
				for each (var p in Main.collectedAirplaneArray)
				{
					if (p.free == true && p.waiting == false && p.movingOn == true && p.currentRoute == selectedRoute.routeParent.parentRoute)
					{
						returnPlane = p;
						breakLoop = true;
						break;
					}
				}
				
				if (Main.tutorial == true && Main.tutorialStep == 19 && Main.tutorialLine2 == this.routeParent.parentRoute)
				{
					Main.tutorialStep = 20;
					Main.hovertext.text = "Good. For each rightclick, another plane will be dedicated to the route clicked upon.";
					Main.TUTORIALTEXT =  "Good. For each rightclick, another plane will be dedicated to the route clicked upon.";
					Main.hovertext.setTextFormat(Main.hoverformat);
				}
					
				if (breakLoop == false)
				{
					for each (var p2 in Main.collectedAirplaneArray)
					{
						if (p2.movingOn == true && p2.currentRoute == selectedRoute.routeParent.parentRoute && p2.free == true && p2.waiting == true)
						{
							for (var c:int=0; c < Main.airportDict[p2.currentLocation]["flightQueue"].length; c++)
							{
								if (Main.airportDict[p2.currentLocation]["flightQueue"][c][0] == p2)
								{
									Main.airportDict[p2.currentLocation]["flightQueue"].splice(c, 1);
								}
							}
							trace("Found occupied plane on the ground");
							returnPlane = p2;
							breakLoop = true;
						}
					}
				}
				
				if (breakLoop == false)
				{
					for each (var p3 in Main.collectedAirplaneArray)
					{
						if (p3.movingOn == true && p3.currentRoute == selectedRoute.routeParent.parentRoute && p3.free == false && p3.nextPlan == false)
						{
							trace("Found plane in the air");
							breakLoop = true;
							
							Main.parentRouteDict[p3.currentRoute]["numPlanes"] -= 1;
							Main.numAirplanesText.text = String(Main.parentRouteDict[p3.currentRoute]["numPlanes"])
							Main.numAirplanesText.setTextFormat(Main.cash_format);
							
							p3.currentRoute = this.routeParent.parentRoute;
							Main.parentRouteDict[p3.currentRoute]["numPlanes"] += 1;
							p3.planFlight(this.routeParent.routePoints[0][0], this.routeParent.routePoints[0][1], this.routeParent.routePoints[0][2], true);
							break;
						}
					}
				}
				
				
					
				if (returnPlane != false)
				{
					trace("Doing flight now..");
					Main.airportDict[returnPlane.currentLocation]["flightQueue"][Main.airportDict[returnPlane.currentLocation]["flightQueue"].length] = [returnPlane, returnPlane.x,returnPlane.y, this.routeParent.routePoints[0][0],this.routeParent.routePoints[0][1], this.routeParent.routePoints[0][2], false, false, false, false, true];
					returnPlane.waiting = true;
					
					Main.parentRouteDict[returnPlane.currentRoute]["numPlanes"] -= 1;
					Main.numAirplanesText.text = String(Main.parentRouteDict[returnPlane.currentRoute]["numPlanes"])
					Main.numAirplanesText.setTextFormat(Main.cash_format);
					
					returnPlane.currentRoute = this.routeParent.parentRoute;
					Main.parentRouteDict[returnPlane.currentRoute]["numPlanes"] += 1;
					interFace2.play();
				}
				
				else
				{
					reject1.play();
				}
			}
		}
		public function stopAlpha():void
		{
			this.removeEventListener(Event.ENTER_FRAME, changeAlpha);
			this.alphaIng = false;
			this.alpha = 1;
		}
		
		public function highLight():void
		{
			this.alphaCounter = false;
			this.alphaIng = true;
			this.addEventListener(Event.ENTER_FRAME, changeAlpha);
		}
		
		private function changeAlpha(evt:Event):void
		{
			if (this.alphaCounter == false)
			{
				this.alpha -= 0.05;
				if (this.alpha < 0.4)
				{
					this.alphaCounter = true;
				}
			}
			else
			{
				this.alpha += 0.05;
				if (this.alpha >= 0.95)
				{
					this.alphaCounter = false;
				}
			}
		}
	}
}