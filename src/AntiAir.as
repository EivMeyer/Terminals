package  
{
	import flash.events.Event;
	import Airplane;
	import flash.display.Sprite;
	import Shot;
	public class AntiAir extends Sprite
	{
		//public var Location:String;
		public static var Range:int = 200;
		
		public var pMyParent;
		public var hunting:Boolean = false;
		public var Target = false;
		
		public var reload:int = 0;
		public static var reloadLim:int = 10;
		
		public var vector_x:Number;
		public var vector_y:Number;
		public var absvector:Number;
		public var vector:Array;
		public var stigningstall:Number;
		
		public function AntiAir(xPos:Number, yPos:Number, pMyParent) 
		{
			//this.Location = startLocation;
			this.pMyParent = pMyParent;
			
			this.x = xPos;
			this.y = yPos;
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			Main.collectedAntiAirArray[Main.collectedAntiAirArray.length] = this;
		}
		
		public function calculateTarget():void
		{
			if (this.Target == false)
			{
				for (var fsc:int = 0; fsc < Main.collectedFighterArray.length; fsc++)
				{
					var fightert = Main.collectedFighterArray[fsc];
					
					if (Math.sqrt(Math.pow((fightert.x - this.x),2) + Math.pow((this.y - fightert.y),2)) < AntiAir.Range)
					{
						this.Target = fightert;
						return;
					}
				}
			}
			
			else
			{
				if (Math.sqrt(Math.pow((this.Target.x - this.x),2) + Math.pow((this.y - this.Target.y),2)) > AntiAir.Range)
				{
					this.Target = false;
					return;
				}
				
				this.reload += 1;
				
				this.vector_x = this.x - this.Target.x;
				this.vector_y = this.y - this.Target.y;
			
				this.absvector = Math.sqrt(Math.pow((this.vector_x),2) + Math.pow((this.vector_y),2));
				this.vector = [this.vector_x / this.absvector,this.vector_y / this.absvector];
			
				//trace(1, this.vector[0], this.vector[1]);
				var xDif = Number(this.vector[0]);
				var yDif = Number(this.vector[1]);
				
				if (this.reload == AntiAir.reloadLim)
				{
					trace("FIRING");
					var shot = new Shot(this.x, this.y, xDif, yDif, Math.atan(this.vector_y/this.vector_x)/Math.PI*180 - 90 * (Math.abs(xDif)/xDif), this.Target, this);
					this.pMyParent.addChild(shot);
					this.reload = 0;
				}
			}
		}
	}
}

