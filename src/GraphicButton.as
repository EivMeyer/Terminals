package 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	final public class GraphicButton extends Sprite
	{
		protected var buttonText:TextField;
		protected var importantFormat;
		protected var buttonString;
		public function GraphicButton(string, hoverValue)
		{
			this.alpha = 1.0;
			this.buttonString = string;

			if (this.buttonString != false)
			{

				importantFormat = new TextFormat();
				importantFormat.color = "black";
				importantFormat.size = 30;
				importantFormat.font = "Arial Rounded MT Bold";
				importantFormat.align = "center";
				importantFormat.leftMargin = 5;
				importantFormat.rightMargin = 5;

				this.buttonText = new TextField  ;
				buttonText.text = this.buttonString;
				buttonText.width = 240;
				buttonText.y = 0.5 * this.height - importantFormat.size / 2;
				buttonText.alpha = 0.6;

				buttonText.mouseEnabled = false;
				buttonText.setTextFormat(importantFormat);

				this.addChild(buttonText);

			}

			if (hoverValue != false)
			{

				this.addEventListener(MouseEvent.MOUSE_OVER, hoverHandler);
			}
		}

		private function hoverHandler(evt:MouseEvent):void
		{
			this.alpha = 0.8;
			this.addEventListener(MouseEvent.MOUSE_OUT, dehoverHandler);
			if (this.buttonString != false)
			{

				buttonText.alpha = 0.8;
			}
		}

		private function dehoverHandler(evt:MouseEvent):void
		{
			this.alpha = 1.0;
		}

	}

}