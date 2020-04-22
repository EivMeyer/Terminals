package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Sprite;
	
	public class Explosion extends MovieClip
	{
		private var pMyParent:Sprite;


		public function Explosion(pMyParent) 
		{
			this.pMyParent = pMyParent;
			addEventListener(Event.ADDED_TO_STAGE, init)
		}
		
		private function init(evt:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(Event.ENTER_FRAME, time);
		}
		
		private function time(evt:Event):void
		{
			if (this.currentFrame == this.totalFrames)
			{
				this.stop();
				stage.removeEventListener(Event.ENTER_FRAME, time);
				pMyParent.removeChild(this);
			}
		}

	}
	
}
