package 
{
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;

	public class SoundPlayer extends EventDispatcher
	{
		private var sound:Sound;
		private var channel:SoundChannel;
		private var position:Number;

		static const SOUND_VOLUME:Number = 0.75;
		static const EVENT_SOUND_COMPLETED:String = "SOUND_COMPLETED";

		public function SoundPlayer()
		{

			// init
			sound = new ThemeSong();
			position = 0;

			// listeners
			sound.addEventListener(IOErrorEvent.IO_ERROR, function(event:Event){trace(event)});

			//trace("SoundPlayer initialized...");
		}

		public function play():void
		{
			channel = sound.play(position);
			channel.soundTransform = new SoundTransform(SOUND_VOLUME);
			channel.addEventListener(Event.SOUND_COMPLETE, function(event:Event){dispatchEvent(new Event(EVENT_SOUND_COMPLETED));});
			//trace("SoundPlayer playing..");
		}

		public function pause():void
		{
			if (channel != null)
			{
				channel.stop();
				position = channel.position;
			}
			//trace("SoundPlayer paused..");
		}

		public function setPosition(pos:Number):void
		{
			position = pos;
		}

		public function getPosition():Number
		{
			if (channel == null)
			{
				return 0;
			}
			else
			{
				return channel.position;
			}
		}
	}
}