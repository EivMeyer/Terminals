package  
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.geom.ColorTransform;
	import flash.display.Sprite;

	public class PopUpNewPlane extends TextField
	{		
		
		public function PopUpNewPlane() :void
		{
			this.visible = false;
			this.text = "+1";
			this.setTextFormat(Main.cash_format);
			this.mouseEnabled = false;
			this.embedFonts = true;
		}
		
		public function showText():void
		{
			this.alpha = 1.0;
			this.x = Main.airplane_field.x + Main.airplane_field.textWidth + 7;
			trace(this.x);
			this.visible = true;
			this.addEventListener(Event.ENTER_FRAME, reSize);
		}
				
		public function reSize(evt:Event):void
		{
			this.alpha -= 0.08;
					
			if (this.alpha < 0.1)
			{
				this.visible = false;
				this.removeEventListener(Event.ENTER_FRAME, reSize);
				return;
			}
		}

	}
	
}
