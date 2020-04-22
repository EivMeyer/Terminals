package  {
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import Airplane;
	import flash.events.Event;
	import flash.display.SimpleButton;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.media.Sound;
	import flash.text.TextFormat;
	import Line;
	import flashx.textLayout.formats.Float;
	import StoreButton;
	import flash.display.Shape;
	
	public class Arrow extends Sprite
	{
		public static var mSpeed:Number = 0.5;
		public var xspeed:Number=0;
		public var yspeed:Number=0;
		
		public var inAir:Boolean = false;
		public var playerLocation:String;
		public var transport:Airplane;
		public var alphaCounter:Boolean = false;
		public var pMyParent;
		public static var Selected:Boolean = false;
		
		public var settled:Boolean = false;
		//totutorial)
		public var alphaIng:Boolean = false;
		public var alphaCounteR:Boolean = false;
		
		public static var alphaRetning:Boolean = false;
		
		private var interFace2:Sound = new InterFace2();
		
		public function Arrow(pMyParent) 
		{
			this.pMyParent = pMyParent;
			this.x = 427;
			this.y = 222;
			this.playerLocation = "";
			this.buttonMode = true;
			
			var new_airPlane:Airplane = new Airplane(this.pMyParent, Main.airportDict["France"]["x"], Main.airportDict["France"]["y"], true,false, false, 0, 0, false, 0, "France", true);
			this.pMyParent.addChild(new_airPlane);
			this.transport = new_airPlane;
			
			this.addEventListener(MouseEvent.CLICK, selectPlayer);
		}
		
		public function movePlayer(toWhere:String):void
		{
			this.transport.Flight(this.x,this.y,Main.airportDict[toWhere]["x"],Main.airportDict[toWhere]["y"], toWhere, false, false, false, true, false);
			Main.buymarketing.visible = false;
		}
		
		public function selectPlayer(evt:MouseEvent):void
		{
			Selected = true;
			interFace2.play();
			
			Main.country_board.visible = false;
			Main.player_board.visible = true;
			Main.buyTerminalButton.visible = false;
			Main.buyTerminalGreyButton.visible = false;
			
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
			
			if (Line.selectedRoute != false)
			{
				Line.selectedRoute.hoverLine.alpha = 0;
				Line.selectedLines = new Array();
				for (var slc:int = 0; slc < Main.parentRouteDict[Line.selectedRoute.routeParent.parentRoute]["lines"].length; slc ++)
				{
					Main.parentRouteDict[Line.selectedRoute.routeParent.parentRoute]["lines"][slc].lineDisplay.familyHoverLine.alpha = 0;
				}
			}
			
			this.addEventListener(Event.ENTER_FRAME, changeAlpha);
			Main.currentLocation = false;
			if (this.settled == false)
			{
				Main.buyAntiAir.visible = true;
				if (Main.antiAirPrice >= Number(Main.cash_field.text))
				{
					Main.buyAntiAirGrey.visible = true;
				}
			}
			else
			{
				Main.buyAntiAir.visible = false;
				Main.buyAntiAirGrey.visible = false;
			}
			
			Main.buymarketing.visible = true;
			Main.buyengine.visible = true;
			Main.buyseat.visible = true;
			
			Main.buyplane.visible = false;
			Main.removeterminal.visible = false;
			Main.create_new_route.visible = false;
			Main.buylanding.visible = false;
			Main.delete_button.visible = false;
			Main.modify_route.visible = false;
			Main.country_board.visible = false;
			Main.store_board.visible = true;
			
			if (Main.tutorial == true && Main.tutorialStep == 3)
			{
				Main.tutorialStep = 4;
				this.stopAlpha();
				Main.collectedAirportDict["Egypt"].highLight();
				Main.hovertext.text = "Well done. Now use your keys to move your player to Egypt.";
				Main.TUTORIALTEXT = "Well done. Now use your keys to move your player to Egypt.";
				Main.hovertext.setTextFormat(Main.hoverformat);
			}
			
			if (Main.tutorial == true && Main.tutorialStep == 12)
			{
				Main.tutorialStep = 13;
				Main.hovertext.text = "Good. Click the advertising button multiple times to increase the popularity of your airline in Germany.";
				Main.player.stopAlpha();
				Main.buymarketing.highLight();
				Main.TUTORIALTEXT = "Good. Click the advertising button multiple times to increase the popularity of your airline in Germany.";
				Main.hovertext.setTextFormat(Main.hoverformat);
			}

			var xPos:Number =  - Main.spImage.x + stage.stageWidth * 0.5 - (this.x + this.width * 0.5) * Airport.SCALEFACTOR; 
			var yPos:Number =  - Main.spImage.y + stage.stageHeight * 0.5 - (this.y + this.height * 0.5) * Airport.SCALEFACTOR;
			
			TweenNano.to(this.pMyParent, 2, {x: xPos, y: yPos, scaleX: Airport.SCALEFACTOR, scaleY: Airport.SCALEFACTOR, ease:Sine.easeOut});
			
			Main.flightScale = 1/Airport.SCALEFACTOR;
			
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
			
			for (var li:int = 0; li < Main.collectedAirportArray.length; li ++)
			{
				Main.collectedAirportArray[li].visible = true;
			}
				
			Main.SCALED = true;
			Line.selectedLines = new Array();
		}
		
		public function stopAlpha():void
		{
			this.removeEventListener(Event.ENTER_FRAME, changeAlpha);
			this.alphaIng = false;
			this.alpha = 1;
		}
		
		public function highLight():void
		{
			this.alphaCounteR = false;
			this.alphaIng = true;
			this.addEventListener(Event.ENTER_FRAME, changeAlpha);
		}
		
		private function changeAlpha(evt:Event):void
		{
			if (this.alphaCounteR == false)
			{
				this.alpha -= 0.05;
				if (this.alpha < 0.4)
				{
					this.alphaCounteR = true;
				}
			}
			else
			{
				this.alpha += 0.05;
				if (this.alpha >= 0.95)
				{
					this.alphaCounteR = false;
				}
			}
		}
	}	
}
