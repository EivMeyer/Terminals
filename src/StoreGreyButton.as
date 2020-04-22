package  
{
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.display.MovieClip
	import flash.events.Event;
	import flash.media.Sound;
	
	public class StoreGreyButton extends MovieClip
	{
		protected var hoverString:String;
		public var price:Number;
		public static var storeArray:Array = new Array();
		
		private var confirm1:Sound = new Confirm1();
		
		public function StoreGreyButton() 
		{
			storeArray[storeArray.length] = this;
			this.addEventListener(MouseEvent.MOUSE_OVER, hoverFunction);
		}
		
		private function hoverFunction(evt:MouseEvent):void
		{
			confirm1.play();
			
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
			
			if (Main.tutorial == false)
			{
				Main.hovertext.width = 150;
				Main.hoverprice.text = "$ " + String(this.price);
				Main.hoverprice.setTextFormat(Main.hoverformat2);
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
			if (Main.hoverprice.visible == true)
			{
				if (Number(Main.cash_field.text) > Number(Main.hoverprice.text))
				{
					this.addEventListener(MouseEvent.MOUSE_OUT, outFunction);
				}
			}
			else
			{
				this.addEventListener(MouseEvent.MOUSE_OUT, outFunction);
			}
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
				
			
			if (Main.tutorial == true)
			{
				Main.hovertext.text = Main.TUTORIALTEXT;
				Main.hovertext.setTextFormat(Main.hoverformat);
			}
			
			this.removeEventListener(MouseEvent.MOUSE_OUT, outFunction);
		}
	}	
}