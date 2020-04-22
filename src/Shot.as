package  
{
	import flash.events.Event;
	import flash.display.Sprite;
	import Airplane;
	import Fighter;
	public class Shot extends Sprite
	{
		public static var speed:Number = 5;
		
		public var xDif:Number;
		public var yDif:Number;
		public var parentPlane;
		public var Target;
		public function Shot(xStart:Number, yStart:Number, xDif:Number, yDif:Number, rot:Number, Target, pPlane) 
		{
			this.x = xStart;
			this.y = yStart;
			this.scaleX = Main.flightScale;
			this.scaleY = Main.flightScale;
			this.xDif = xDif;
			this.yDif = yDif;
			this.rotation = rot;
			this.Target = Target;
			this.parentPlane = pPlane;
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			Main.collectedShotArray[Main.collectedShotArray.length] = this;
		}
	}
	
}
