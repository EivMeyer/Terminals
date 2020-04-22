package  
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.geom.ColorTransform;
	import flash.display.Sprite;

	public class PopUpNewSeat extends TextField
	{		
		
		public function PopUpNewSeat() :void
		{
			this.visible = false;
			this.text = "+30";
			this.setTextFormat(Main.airplane_format);
			this.mouseEnabled = false;
			this.embedFonts = true;
		}
		
		public function showText():void
		{
			this.alpha = 1.0;
			this.x = 120;
			this.visible = true;
			this.addEventListener(Event.ENTER_FRAME, reSize);
		}
				
		public function reSize(evt:Event):void
		{
			this.alpha -= 0.04;
					
			if (this.alpha < 0.1)
			{
				this.visible = false;
				this.removeEventListener(Event.ENTER_FRAME, reSize);
				return;
			}
		}

	}
	
}
