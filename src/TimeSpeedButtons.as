package  {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	final public class TimeSpeedButtons extends Sprite
	{

		public function TimeSpeedButtons() 
		{
			this.alpha = 0.8;
			this.addEventListener(MouseEvent.MOUSE_OVER, hoverFunction);
		}
		
		private function hoverFunction(evt:MouseEvent):void
		{
			this.alpha = 1.0;
			this.addEventListener(MouseEvent.MOUSE_OUT, outFunction);
		}
		
		private function outFunction(evt:MouseEvent):void
		{
			this.alpha = 0.8;
			this.removeEventListener(MouseEvent.MOUSE_OUT, outFunction);
		}

	}
	
}
