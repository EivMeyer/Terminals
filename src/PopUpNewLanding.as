package  
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.geom.ColorTransform;
	import flash.display.Sprite;

	public class PopUpNewLanding extends TextField
	{		
		
		public function PopUpNewLanding() :void
		{
			this.visible = false;
			this.text = "+1";
			this.setTextFormat(Main.airplane_format);
			this.mouseEnabled = false;
			this.embedFonts = true;
		}
		
		public function showText():void
		{
			trace("Showing popup");
			this.alpha = 1.0;
			this.x = Main.runwayField.x + Main.runwayField.textWidth + 7;
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
