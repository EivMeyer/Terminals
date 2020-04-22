package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	final public class RedSignal extends Sprite
	{
		public function RedSignal(xCor, yCor)
		{
			this.x = xCor;
			this.y = yCor;
			addEventListener(Event.ADDED_TO_STAGE, init);
			this.alpha = 1;
			this.mouseEnabled = false;
			this.mouseChildren = false;
			
			this.scaleX = 0.01 * Main.flightScale;
			this.scaleY = 0.01 * Main.flightScale;
		}

		protected function init(evt:Event):void
		{
			stage.addEventListener(Event.ENTER_FRAME, transForm);
		}


		protected function transForm(evt:Event):void
		{
			if (this.alpha > 0)
			{
				this.scaleX += 0.01 * Main.flightScale;
				this.scaleY += 0.01 * Main.flightScale;
				this.alpha -= 0.002;
			}
			else
			{
				stage.removeEventListener(Event.ENTER_FRAME, transForm);
				this.parent.removeChild(this);
			}
		}
	}
}