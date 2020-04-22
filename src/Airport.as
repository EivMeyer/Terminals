	package 
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.SimpleButton;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import Line;
	import flashx.textLayout.formats.Float;
	import StoreButton;
	import flash.media.Sound;
	import flash.display.Shape;
	import flash.geom.Point;

	final public class Airport extends Sprite
	{
		public static var myShape:Shape;
		public static var hover:Array = new Array(0, 0);
		public static var DELETING:Boolean = false;
		public static var ROUTING:Boolean = false;
		
		public static var snapLength:Number = 7;
		public static var return_ROUTE:Array = new Array();
		public static var return_DELETE:Array = new Array();
		
		public static var tempLineArray:Array = new Array();
		
		public static var currentSelect = false;
		
		public static const SCALEFACTOR:uint = 3;
		
		public static var ROUTINGFROM = false;
		
		//-----------------------------------------------------------------------------

		// ----------------------------------------------------------------------------
		private var interface2:Sound = new InterFace2();
		private var interface1:Sound = new Interface1();
		private var reject1:Sound = new Reject1();
		
		public var country:String;
		public var bycountry:String;
		protected var pMyParent;
		public var globalPoint:Point;
		protected var greenDot;
		protected var yellowDot;
		public var blueAirport:Sprite;
		public var greenAirport:Sprite;
		public var airportS:Sprite;
		public var airportB:Sprite;
		public var blueAirportB:Sprite;
		public var greenAirportB:Sprite;
		private var airportHover:Sprite;
		
		public var alphaCounter:Boolean = false;

		// ----------------------------------------------------------------------------

		public function Airport(countryinput, bycountryinput, pMyParent)
		{
			this.buttonMode = true;
			
			this.bycountry = bycountryinput;
			this.country = countryinput;
			this.pMyParent = pMyParent;
			this.airportS = new AirportS();
			this.addChild(airportS);
			this.blueAirport = new BlueAirport();
			this.addChild(blueAirport);
			this.blueAirport.visible = false;
			this.greenAirport = new GreenAirport();
			this.addChild(greenAirport);
			this.greenAirport.visible = false;
			this.airportB = new AirportB();
			this.addChild(airportB);
			this.airportB.visible = false;
			this.blueAirportB = new BlueAirportL();
			this.addChild(blueAirportB);
			this.blueAirportB.visible = false;
			this.greenAirportB = new GreenAirportL();
			this.addChild(greenAirportB);
			this.greenAirportB.visible = false;
			
			this.airportHover = new AirportHover();
			this.addChild(airportHover);
			this.airportHover.x = this.width * 0.5 - this.airportHover.width * 0.5;
			this.airportHover.y = this.height * 0.5 - this.airportHover.width * 0.5;
			this.airportHover.scaleX = 0.8;
			this.airportHover.scaleY = 0.8;
			this.airportHover.alpha = 0;

			this.addEventListener(MouseEvent.CLICK, clickHandler);
			this.addEventListener(MouseEvent.MOUSE_OVER, hoverHandler);
			this.addEventListener(MouseEvent.RIGHT_CLICK, sendSingleFlight);
		}

		public function koordinater(xc, yc):void
		{
			this.x = (xc);
			this.y = (yc);
			
			this.globalPoint = this.pMyParent.bg_image.localToGlobal(new Point(this.x, this.y-60) );
		}
		
		public function sendSingleFlight(evt:MouseEvent):void
		{
			//Main.button1.visible = true;
			trace("Trying to send single flight");
			var bLoop:Boolean = false;
			
			if (ROUTINGFROM == false && Main.currentLocation != this.country)
			{
				for each (var airplaneInstance in Main.collectedAirplaneArray)
				{
					if (airplaneInstance.free == true && airplaneInstance.waiting == false && airplaneInstance.currentLocation == Main.currentLocation)
					{
						Main.airportDict[Main.currentLocation]["flightQueue"][Main.airportDict[Main.currentLocation]["flightQueue"].length] = [airplaneInstance, airplaneInstance.x,airplaneInstance.y, this.x,this.y,this.country, false, false, false, false, true];
						airplaneInstance.waiting = true;
						bLoop = true;
						
						break;
					}
				}
			}
			
			if (Arrow.Selected == true)
			{
				trace("MOVING PLAYER");
				Main.player.movePlayer(this.country);
				interface2.play();
				return;
			}
			
			if (bLoop == true)
			{
				interface2.play();
			}
			
			else
			{
				reject1.play();
			}
		}

		private function clickHandler(evt:MouseEvent):void
		{					
			// Testing
			trace(Main.airportDict[this.country]["relation"]);
			
			if (Line.selectedRoute != false)
			{
				Line.selectedRoute.hoverLine.alpha = 0;
				Line.selectedLines = new Array();
				
				for (var slc:int = 0; slc < Main.parentRouteDict[Line.selectedRoute.routeParent.parentRoute]["lines"].length; slc ++)
				{
					Main.parentRouteDict[Line.selectedRoute.routeParent.parentRoute]["lines"][slc].lineDisplay.familyHoverLine.alpha = 0;
				}
			}
			
			if (Main.tutorial == true && Main.tutorialStep == 8 && this.country == "Germany")
			{
				Main.tutorialStep = 9;
				Main.hovertext.text = "Create a route to France by clicking on the new route button.";
				Main.create_new_route.highLight();
				Main.TUTORIALTEXT = "Create a route to France by clicking on the new route button.";
				Main.hovertext.setTextFormat(Main.hoverformat);
			}		
			
			if (ROUTING == false)
			{
				/*var index:int = Main.collectedAirportArray.indexOf(this);

				var xPos:Number =  - Main.spImage.x + stage.stageWidth * 0.5 - (this.globalPoint.x + this.width * 0.5) * SCALEFACTOR; 
				var yPos:Number =  - Main.spImage.y + stage.stageHeight * 0.5 - (this.globalPoint.y + this.height * 0.5) * SCALEFACTOR;
				
				trace(this.x, this.globalPoint.x, Main.spImage.x, xPos);
				trace(this.y, this.globalPoint.y, Main.spImage.y, yPos);
				TweenNano.to(this.pMyParent.bg_image, 2, {x: xPos, y: yPos, scaleX: SCALEFACTOR, scaleY: SCALEFACTOR, ease:Sine.easeOut});
				
				Main.flightScale = 1/SCALEFACTOR;
				
				TweenLite.to(Main.player, 2, {scaleX: Main.flightScale, scaleY: Main.flightScale});
				
				for (var il:int = 0; il < Main.allCollectedArrays.length; il++)
				{
					var cArray:Array = Main.allCollectedArrays[il];
					
					for (var ii:int = 0; ii < cArray.length; ii ++)
					{
						var cInstance:Object = cArray[ii];
						cInstance.scaleX = Main.flightScale;
						cInstance.scaleY = Main.flightScale;
					}
				}
				
				Main.SCALED = true;*/
				
				interface1.play();
				if (currentSelect != false)
				{
					currentSelect.airportB.visible = false;
					currentSelect.airportS.visible = true;
					
					if (currentSelect.greenAirportB.visible == true)
					{
						currentSelect.greenAirport.visible = true;
						currentSelect.greenAirportB.visible = false;
					}
					
					if (currentSelect.blueAirportB.visible == true)
					{
						currentSelect.blueAirport.visible = true;
						currentSelect.blueAirportB.visible = false;
					}
				}
				
				currentSelect = this;
				this.airportS.visible = false;
				this.airportB.visible = true;
				
				if (this.greenAirport.visible == true)
				{
					this.greenAirport.visible = false;
					this.greenAirportB.visible = true;
				}
				
				if (this.blueAirport.visible == true)
				{
					this.blueAirport.visible = false;
					this.blueAirportB.visible = true;
				}
				Main.currentLocation = this.country;
				
				Main.buyAntiAir.visible = false;
				Main.buyAntiAirGrey.visible = false;
				Main.buymarketing.visible = false;
				Main.delete_button.visible = false;
				Main.route_board.visible = false;
				Main.modify_route.visible = false;
				Main.player_board.visible = false;
				
				Arrow.Selected = false;
				
				Line.selectedRoute = false;
				
				if (Main.airportDict[this.country]["terminal"] == true)
				{
					Main.buyTerminalButton.visible = false;
				
					Main.country_field.text = this.country;
					Main.country_field.setTextFormat(Main.importantRedFormatLeft);
					
					// Change of country popularity bars
					
					Main.influenceBar.x = Math.min(Main.airportDict[Main.country_field.text]["reputation"]*(Main.modify_new_route.width/2+30), Main.modify_new_route.width/2+30);
					Main.blueReputationBar.x = Math.min(Main.airportDict[Main.country_field.text]["bluereputation"]*(Main.modify_new_route.width/2+30), Main.modify_new_route.width/2+30);
					Main.status_info.text = Main.airportDict[Main.country_field.text]["status"];
					Main.status_info.setTextFormat(Main.statusFormat);
					
					Main.runwayField.text = String(Main.airportDict[this.country]["runways"]);
					Main.runwayField.setTextFormat(Main.cash_format);
					
					Main.country_board.visible = true;
					
					Main.buyplane.visible = true;
					Main.removeterminal.visible = true;
					Main.create_new_route.visible = true;
					Main.buylanding.visible = true;
					
					Main.numAirplanesTextR.text = String(Main.airportDict[this.country]["planesHere"])
					Main.numAirplanesTextR.setTextFormat(Main.cash_format);
					
					trace("Airplanes here: ", Main.airportDict[this.country]["planesHere"]);
				}
				
				else
				{
					Main.country_field.text = this.country;
					Main.country_field.setTextFormat(Main.importantRedFormatLeft);
					
					Main.buyTerminalButton.visible = true;
					Main.country_board.visible = false;
					
					Main.buyplane.visible = false;
					Main.removeterminal.visible = true;
					Main.create_new_route.visible = false;
					Main.buymarketing.visible = false;
					Main.buylanding.visible = false;
					Main.buyseat.visible = false;
					Main.buyengine.visible = false;
				}
			}
		
			
			
			

			else if (ROUTING == true)
			{
				if (Main.airportDict[this.country]["terminal"] == true)
				{
					if (return_ROUTE.length == 0)
					{
						myShape = new Shape();
						myShape.graphics.lineStyle(2, 0x33CC00, .35);
						myShape.graphics.moveTo(this.x,this.y);

						this.pMyParent.bg_image.addChildAt(myShape,1);
					}
				
					else
					{
						myShape.graphics.lineTo(this.x,this.y);
					}
					
					if (ROUTINGFROM == this.country)
					{
						reject1.play();
					}
					else
					{
						interface2.play();
					}
				
					ROUTINGFROM = this.country;
					Main.startX = this.x;
					Main.startY = this.y;
					return_ROUTE[return_ROUTE.length] = [this.x,this.y,this.country];
				}
				else
				{
					reject1.play();
				}
			}			
		}
		
		private function infoTexter(country):String
		{
			var populationString:String;
			var GDPString:String;
			var returnString:String;
			
			if (Main.airportDict[country]["population"] >= 150)
			{
				populationString = "very large";
				//trace("> 150");
			}
			
			else if (Main.airportDict[country]["population"] < 150 && Main.airportDict[country]["population"] >= 40)
			{
				populationString = "large";
				//trace("40-150");
			}
			
			else if (Main.airportDict[country]["population"] < 40 && Main.airportDict[country]["population"] >= 10)
			{
				populationString = "medium-sized";
				//trace("10-40");
			}
			
			else if (Main.airportDict[country]["population"] < 10 && Main.airportDict[country]["population"] >= 4)
			{
				populationString = "small";
				//trace("4-10");
			}
			
			else
			{
				populationString = "very small";
				//trace("< 4");
			}
			
			if (Main.airportDict[country]["GDP"] >= 50)
			{
				GDPString = "very rich";
			}
			
			else if (Main.airportDict[country]["GDP"] < 50 && Main.airportDict[country]["GDP"] >= 20)
			{
				GDPString = "rich";
			}
			
			else if (Main.airportDict[country]["GDP"] < 20 && Main.airportDict[country]["GDP"] >= 10)
			{
				GDPString = "fairly rich";
			}
			
			else if (Main.airportDict[country]["GDP"] < 10 && Main.airportDict[country]["GDP"] >= 5)
			{
				GDPString = "poor";
			}
			
			else
			{
				GDPString = "very poor";
			}
			
			returnString = "The population of " + country + " is " + GDPString + " and " + populationString + ".";
			
			return returnString;
		}

		private function hoverHandler(evt:MouseEvent):void
		{
			if (Arrow.Selected == false && Main.tutorial == false)
			{
				hover = [this.x, this.y];
				Main.hovertext.width = 204;
				if (Main.airportDict[this.country]["mission"] == false || ROUTING == true)
				{
					Main.hovertext.text = infoTexter(this.country);
					trace(infoTexter(this.country));
					Main.hovertext.setTextFormat(Main.hoverformat);
					Main.hovertext.setTextFormat(Main.hoverformat1, Main.hovertext.text.indexOf(this.country), Main.hovertext.text.indexOf(this.country) + this.country.length);
					Main.hoverprice.visible = false;
				}
				else
				{
					var pattern1:RegExp = /%ORIGIN/g;
					var pattern2:RegExp = /%COUNTRY/g;
					var pattern3:RegExp = /%ORIGINADJECTIVE/g;
					var pattern4:RegExp = /%COUNTRYADJECTIVE/g;
					if (Main.airportDict[this.country]["mission"][1] == "origin" && Main.airportDict[this.country]["mission"][0].origin == this.country)
					{
						trace(Main.airportDict[this.country]["mission"][0]);
						trace(Main.airportDict[this.country]["mission"][1]);
						trace(Main.airportDict[this.country]["mission"][0].origin);
						trace(Main.airportDict[Main.airportDict[this.country]["mission"][0].origin]["adjective"]);
						var originText:String = Main.airportDict[this.country]["mission"][0].originHover;
						trace(originText);
						originText = originText.replace(pattern3,Main.airportDict[Main.airportDict[this.country]["mission"][0].origin]["adjective"]);
						originText = originText.replace(pattern4,Main.airportDict[Main.airportDict[this.country]["mission"][0].country]["adjective"]);
						originText = originText.replace(pattern1,Main.airportDict[this.country]["mission"][0].origin);
						originText = originText.replace(pattern2,Main.airportDict[this.country]["mission"][0].country);
						
						Main.hovertext.text = originText;
					}
					else if (Main.airportDict[this.country]["mission"][1] == "country" && Main.airportDict[this.country]["mission"][0].country == this.country)
					{
						trace(Main.airportDict[this.country]["mission"][0]);
						trace(Main.airportDict[this.country]["mission"][1]);
						trace(Main.airportDict[this.country]["mission"][0].country);
						trace(Main.airportDict[Main.airportDict[this.country]["mission"][0].country]["adjective"]);
						var countryText:String = Main.airportDict[this.country]["mission"][0].countryHover;
						trace(countryText);
						if (Main.airportDict[this.country]["mission"][0].origin != false)
						{
							countryText = countryText.replace(pattern3,Main.airportDict[Main.airportDict[this.country]["mission"][0].origin]["adjective"]);
							countryText = countryText.replace(pattern1,Main.airportDict[this.country]["mission"][0].origin);
						}
						
						countryText = countryText.replace(pattern4,Main.airportDict[this.country]["adjective"]);
						countryText = countryText.replace(pattern2,this.country);
						Main.hovertext.text = countryText;
					}
					Main.hovertext.setTextFormat(Main.hoverformat);
					
					
				}
			}
			
			if (ROUTING == true)
			{
				this.airportS.visible = false;
				this.airportB.visible = true;
				
				if (this.blueAirport.visible == true)
				{
					this.blueAirport.visible = false;
					this.blueAirportB.visible = true;
				}
				if (this.greenAirport.visible == true)
				{
					this.greenAirport.visible = false;
					this.greenAirportB.visible = true;
				}
			}
			
			this.addEventListener(MouseEvent.MOUSE_OUT, awayHandler);
		}

		private function awayHandler(evt:MouseEvent):void
		{
			hover = [0, 0];
			
			if (ROUTING == true || DELETING == true )
			{
				/*trace(this.width);
				if (this.width / Main.flightScale > 15)
				{
					this.width = this.width * 0.5;
					this.height = this.height * 0.5;
				}*/
				if (Airport.currentSelect != this)
				{
					if (this.airportB.visible == true)
					{
						this.airportB.visible = false;
						this.airportS.visible = true;
					}
				
					if (this.greenAirportB.visible == true)
					{
						this.greenAirport.visible = true;
						this.greenAirportB.visible = false;
					}
				
					if (this.blueAirportB.visible == true)
					{
						this.blueAirport.visible = true;
						this.blueAirportB.visible = false;
					}
				}
				
				if (ROUTING == true)
				{
					Main.hovertext.text = Main.CREATENEWROUTEHOVERTEXT;
					Main.hovertext.setTextFormat(Main.hoverformat);
				}
			}
			
			else
			{
				Main.hovertext.text = "";
			}
			
			if (Main.tutorial == true)
			{
				Main.hovertext.text = Main.TUTORIALTEXT;
				Main.hovertext.setTextFormat(Main.hoverformat);
			}
			
			this.removeEventListener(MouseEvent.MOUSE_OUT, awayHandler);
		}
		
		public function highLight():void
		{
			this.alphaCounter = false;
			this.addEventListener(Event.ENTER_FRAME, changeAlpha);
		}
		
		public function stopAlpha():void
		{
			this.removeEventListener(Event.ENTER_FRAME, changeAlpha);
			this.alpha = 1;
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
				if (this.alpha == 1)
				{
					this.alphaCounter = false;
				}
			}
		}
	}
}