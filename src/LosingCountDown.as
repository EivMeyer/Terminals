package  {
	
	public class LosingCountDown 
	{
		public function LosingCountDown() 
		{
			Main.LOSING = true;
			Main.count_down_field.visible = true;
			Main.count_down_field.text = "100";
			Main.count_down_field.setTextFormat(Main.redDateFormat);
			Main.time_field.setTextFormat(Main.redDateFormat);
		}
	}
}
