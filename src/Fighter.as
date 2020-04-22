package  
{
	import flash.events.Event;
	import Airplane;
	import flash.display.Sprite;
	import Shot;
	public class Fighter extends Sprite
	{
		public var Location:String;
		public var pMyParent;
		public var hunting:Boolean = false;
		public var docking:Boolean = true;
		public var inAir:Boolean = true; // endre
		public var Target = false;
		
		public var maxSpeed:Number = 1;
		public var speed:Number = 1;
		public var reload:int = 0;
		public var huntingRange:int = 400;
		public var shotsFired:Boolean = false;
		
		public var vector_x:Number;
		public var vector_y:Number;
		public var absvector:Number;
		public var vector:Array;
		public var stigningstall:Number;
		
		public static var rotAks:Number = 0.02;
		public var degrees:Number;
		
		public function Fighter(startLocation:String, pMyParent) 
		{
			this.Location = startLocation;
			this.pMyParent = pMyParent;
			
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//trace(this.Location);
			//trace(this.x);
			this.scaleX = Main.flightScale;
			this.scaleY = Main.flightScale;
			this.x = Main.airportDict[this.Location]["x"];
			this.y = Main.airportDict[this.Location]["y"];
			
			Main.collectedFighterArray[Main.collectedFighterArray.length] = this;
		}
		
		public function calculateRoute(target):void
		{
			this.Target = target;
			
			if (this.Target.free == true || this.Target.destroyed == true)
			{
				this.hunting = false;
				this.docking = true;
				this.speed = this.maxSpeed;
			}
			
			this.vector_x = this.x - this.Target.x;
			this.vector_y = this.y - this.Target.y;
			
			this.absvector = Math.sqrt(Math.pow((this.vector_x),2) + Math.pow((this.vector_y),2));
			this.vector = [this.vector_x / this.absvector,this.vector_y / this.absvector];
			
			//trace(1, this.vector[0], this.vector[1]);
			var xDif = Number(this.vector[0]);
			var yDif = Number(this.vector[1]);
			this.x -= this.speed * xDif;
			this.y -= this.speed * yDif;
			
			if (this.absvector < 50)
			{
				this.speed = Airplane.SPEED;
			}
			
			else
			{
				this.speed = 1;
			}
			
			if (this.absvector < 60)
			{
				this.reload += 1;
				//trace("Reloading: ", this.reload);
				if (this.reload == 20)
				{
					//trace("FIRING");
					var shot = new Shot(this.x, this.y, xDif, yDif, this.rotation, this.Target, this);
					this.shotsFired = true;
					this.pMyParent.addChild(shot);
					this.reload = 0;
				}
			}
			
			this.rotation = Math.atan(this.vector_y/this.vector_x)/Math.PI*180 - 90 * (Math.abs(xDif)/xDif);
		}
		
		public function calculateReturn():void
		{
			//trace("Calculating Return");
			
			this.vector_x = this.x - Main.airportDict[this.Location]["x"];
			this.vector_y = this.y - Main.airportDict[this.Location]["y"];
			
			if (Math.sqrt(Math.pow(this.vector_x,2) + Math.pow(this.vector_y,2)) < 5)
			{
				this.docking = false;
				this.inAir = false;
				this.shotsFired = false;
				this.x = Main.airportDict[this.Location]["x"];
				this.y = Main.airportDict[this.Location]["y"];
				return;
			}
			
			if (this.vector_x != 0)
			{
				this.degrees = Math.atan(this.vector_y/this.vector_x)/Math.PI*180 - 90 * (Math.abs(this.vector_x)/this.vector_x);
			}
			else if (this.vector_y > 0)
			{
				this.degrees = 180;
			}
			else if (this.vector_y < 0)
			{
				this.degrees = 0;
			}
			
			//trace("vx: ", this.vector_x, "vy: ", this.vector_y, "Fighter rot: ", this.rotation, "Fighter degree target: ", this.degrees);
			if (this.rotation - this.degrees < 180)
			{
				this.rotation -= (this.rotation - this.degrees) * Fighter.rotAks;
			}
			else
			{
				this.rotation += (this.rotation - this.degrees) * Fighter.rotAks;
			}
			
			var xSpeed:Number = this.speed * Math.sin(this.rotation / 180 * Math.PI);
			var ySpeed:Number = this.speed * Math.cos(this.rotation  / 180 * Math.PI);
			
			//trace("Fighter speedx ", xSpeed, "Fighter speedy :", ySpeed);
			this.x += this.speed * Math.sin(this.rotation / 180 * Math.PI);
			this.y -= this.speed * Math.cos(this.rotation  / 180 * Math.PI);
		}
		
		public function crash():void
		{
			// Play animation
			var explosion = new Explosion(this.pMyParent);
			explosion.scaleX = Main.flightScale;
			explosion.scaleY = Main.flightScale;
			explosion.x = this.x + this.width * 0.5;
			explosion.y = this.y + this.height * 0.5;
			//trace(this.x, explosion.x, this.y, explosion.y);
			this.pMyParent.addChild(explosion);
			explosion.play();
			
			//trace("crash");
			this.visible = false;
			Main.collectedFighterArray.splice(Main.collectedFighterArray.indexOf(this), 1);
			
			this.pMyParent.removeChild(this);
			delete(this);
		}
		
		public function searchForTarget():void
		{
			var cc:int = 0;
			var flightCounterIndex:int = 1000;
			
			for (cc; cc < Main.collectedAirplaneArray.length; cc++)
			{
				var plane:Airplane = Main.collectedAirplaneArray[cc]
				if (plane.flightCounter < flightCounterIndex && plane.free == false && Math.sqrt(Math.pow((plane.x - this.x),2) + Math.pow((this.y - plane.y),2)) < this.huntingRange)
				{
					flightCounterIndex = plane.flightCounter;
					this.Target = plane;
				}
			}
			
			if (flightCounterIndex != 1000)
			{
				this.inAir = true;
				this.hunting = true;
				this.docking = false;
			}
		}
	}
}
