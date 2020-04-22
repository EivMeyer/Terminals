package  
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.geom.ColorTransform;
	import flash.display.Sprite;
	import Airplane;

	public class PopUpProfit extends TextField
	{
		protected var profit:String;
		protected var passengers:String;
		protected var level:int;
		protected var airplane:Airplane;
		protected var locationString:String;
		
		public function PopUpProfit() :void
		{
			Main.popUpArray[Main.popUpArray.length] = this;
			this.mouseEnabled = false;
			this.mouseWheelEnabled = false;
			this.cacheAsBitmap = true;
			this.wordWrap = false;
		}
		
		public function updateAirplane(airplane:Airplane):void
		{
			this.airplane = airplane;
			this.locationString = airplane.currentLocation;
		}
		
		public function updateText(profit:String, passengers:String):void
		{
			this.alpha = 1.0;
			this.profit = profit;
			this.passengers = passengers;
			
			if (Main.tutorial == false)
			{
				this.text = this.passengers + " / " + String(int(this.profit));
			}
			else
			{
				this.text = "Passengers: " + this.passengers + " / " + "Income: " + String(int(this.profit));
			}
			
			if (Number(this.profit) < 0)
			{
				this.setTextFormat(Main.popUpFormatRed);
			}
			
			else
			{
				this.setTextFormat(Main.popUpFormatGreen);
			}
			
			if (Main.tutorial == false)
			{
				this.setTextFormat(Main.popUpFormatBlue, 0, passengers.length);
				this.setTextFormat(Main.popUpFormatBlack, passengers.length+2, passengers.length+3);
			}
			
			else
			{
				this.setTextFormat(Main.popUpFormatBlue, 0, this.text.indexOf("/")-1);
				this.setTextFormat(Main.popUpFormatBlack, this.text.indexOf("/"), this.text.indexOf("/")+1);
			}
			
			/*this.scaleX = Main.flightScale*Math.min(Math.abs(Number(this.profit))*0.0001, 1);
			this.scaleY = Main.flightScale*Math.min(Math.abs(Number(this.profit))*0.0001, 1);
			this.scaleX = Main.flightScale*Math.max(Math.abs(Number(this.profit))*0.0001, 0.7);
			this.scaleY = Main.flightScale*Math.max(Math.abs(Number(this.profit))*0.0001, 0.7);*/
			
			this.scaleX = Main.flightScale;
			this.scaleY = Main.flightScale;
			
			this.autoSize = "center";
			
			this.width = this.textWidth + 4; 
			
			this.addEventListener(Event.ENTER_FRAME, reSize);
		}
		
		public function updateLevel(level:int):void
		{
			this.level = level;
		}
				
		public function reSize(evt:Event):void
		{
			this.alpha -= 0.008;
					
			if (this.alpha < 0.1)
			{
				this.visible = false;
				this.alpha = 1.0;
				Main.airportDict[this.locationString]["currentPopUps"][this.level] = false;
				this.removeEventListener(Event.ENTER_FRAME, reSize);
				return;
			}
		}

	}
	
}
