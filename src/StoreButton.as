package  {
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	
	public class StoreButton extends Sprite
	{
		protected var hoverString:String;
		public var clicked:Boolean = false;
		public var completed:Boolean = true;
		public var price;
		public var alphaIng:Boolean = false;
		public var alphaCounter:Boolean = false;
		public static var storeArray:Array = new Array();
		
		private var confirm1:Sound = new Confirm1();
		
		public function StoreButton() 
		{
			storeArray[storeArray.length] = this;
			this.addEventListener(MouseEvent.MOUSE_OVER, hoverFunction);
		}
		
		private function hoverFunction(evt:MouseEvent):void
		{
			this.clicked = false;
			confirm1.play();
			
			this.addEventListener(MouseEvent.CLICK, clickFunction);
			
			if (Main.player.settled == true)
			{
				Main.hoverDict[Main.buymarketing][1] = Main.marketingPrice * Main.airportDict[Main.player.playerLocation]["GDP"] * Main.airportDict[Main.player.playerLocation]["reputation"];
				Main.hoverDict[Main.buymarketing][1] = int(Main.hoverDict[Main.buymarketing][1]);
			}
			
			if (Main.hoverDict[this][0] != "" && Main.tutorial == false)
			{
				Main.hovertext.text = Main.hoverDict[this][0];
				Main.hovertext.setTextFormat(Main.hoverformat);
			}
			
			if (Main.hoverDict[this][1] && Main.tutorial == false)
			{
				var textString:String = String(Main.hoverDict[this][1]);
				if (Main.currentLocation != false)
				{
					var pattern:RegExp = /%TERMINALPRICE/g;
					textString = textString.replace(pattern,String(Math.round(Main.terminalprice * Main.airportDict[Main.currentLocation]["GDP"])));
				}
				Main.hovertext.width = 150;
				Main.hoverprice.text = "$ " + textString;
				Main.hoverprice.setTextFormat(Main.hoverformat1);
				Main.hoverprice.visible = true;
			}
			
			else
			{
				if (Main.tutorial == false)
				{
					Main.hovertext.width = 204;
					Main.hoverprice.visible = false; 
				}
			}
			
			this.alpha += 0.2;
			this.addEventListener(MouseEvent.MOUSE_OUT, outFunction);
		}
		
		private function clickFunction(evt:MouseEvent):void
		{
			for (var countSR:int = 0; countSR < storeArray.length; countSR ++)
			{
				if (storeArray[countSR] != this)
				{
					storeArray[countSR].completed = true;
				}
			}
			
			this.clicked = true;
		}
		
		private function outFunction(evt:MouseEvent):void
		{
			if (Airport.ROUTING == false)
			{
				Main.hovertext.text = "";
				Main.hoverprice.text = "";
			}
			
			else
			{
				if (Airport.ROUTING == true && Main.tutorial == false)
				{
					Main.hovertext.text = Main.CREATENEWROUTEHOVERTEXT;
					Main.hovertext.setTextFormat(Main.hoverformat);
					Main.hoverprice.text = "";
				}
				
			}
			
			if (this.completed == true)
			{
				this.alpha -= 0.2;
			}
			
			if (Main.tutorial == true)
			{
				Main.hovertext.text = Main.TUTORIALTEXT;
				Main.hovertext.setTextFormat(Main.hoverformat);
			}
			
			this.removeEventListener(MouseEvent.MOUSE_OUT, outFunction);
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