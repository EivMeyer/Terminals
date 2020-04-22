package 
{
	import flash.events.Event;
	import flash.display.Sprite;

	final public class Greenspot extends Sprite
	{
		
		public function Greenspot(airport)
		{
			this.scaleY = 0.1 * Main.flightScale;
			this.scaleX = 0.1 * Main.flightScale;
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.cacheAsBitmap = true;

			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(evt:Event):void
		{
			stage.addEventListener(Event.ENTER_FRAME, enterFrameFunction);
		}

		private function enterFrameFunction(evt:Event):void
		{
			if (this.alpha > 0)
			{
				this.alpha -=  0.003;
				this.scaleX +=  0.01 * Main.flightScale;
				this.scaleY +=  0.01 * Main.flightScale;
			}
			else
			{
				stage.removeEventListener(Event.ENTER_FRAME, enterFrameFunction);
				this.parent.removeChild(this);
			}
		}
	}

}