package  {
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.media.Sound;
	
	public class HoverButton extends Sprite
	{
		private var interFace2:Sound = new InterFace2()
		private var confirm1:Sound = new Confirm1();
		public var alphaCounter:Boolean = false;
		
		public function HoverButton() 
		{
			this.alpha = 0.8;
			this.addEventListener(MouseEvent.MOUSE_OVER, hoverFunction);
		}
		
		private function hoverFunction(evt:MouseEvent):void
		{
			confirm1.play();
			this.alpha += 0.2;
			this.addEventListener(MouseEvent.MOUSE_OUT, outFunction);
			this.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function clickHandler(evt:MouseEvent):void
		{
			interFace2.play();
		}
		
		private function outFunction(evt:MouseEvent):void
		{
			this.alpha -= 0.2;
			
			this.removeEventListener(MouseEvent.MOUSE_OUT, outFunction);
		}
		
		public function stopAlpha():void
		{
			this.removeEventListener(Event.ENTER_FRAME, changeAlpha);
			this.alpha = 1;
		}
		
		public function highLight():void
		{
			this.alphaCounter = false;
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
				if (this.alpha == 1)
				{
					this.alphaCounter = false;
				}
			}
		}
	}	
}