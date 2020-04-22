package  
{
	import StoreButton;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	public class ClosedMail extends StoreButton
	{
		public static var aCou:int = 0;
		public static var aTimer:Timer;
		public static var aSpeed:Number = 0.2;
		
		
		public function ClosedMail() 
		{
		}
		
		public function newMail():void
		{
			if (Main.tutorial == false)
			{
				aCou = 0;
				aTimer = new Timer(50, Math.PI / aSpeed);
				aTimer.addEventListener(TimerEvent.TIMER, changeAlpha);
				aTimer.start();
			}
		}
		
		public function changeAlpha(evt:TimerEvent):void
		{
			//this.alpha = Math.sin(aSpeed * aCou);
			this.scaleX = 1 + 0.4 * Math.sin(aSpeed * aCou);
			this.scaleY = 1 + 0.4 * Math.sin(aSpeed * aCou);
			aCou += 1;
		}
	}
	
}
