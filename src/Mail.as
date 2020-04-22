package  
{	
	import flash.utils.Dictionary;
	import flash.media.Sound;
	
	public class Mail 
	{
		public var from:String;
		public var subject:String;
		public var dDate:String;
		public var Content:String;
		public var Type:String;
		public var Expires;
		public var expiresIn;
		//public var id:int;
		
		public var mail1:Sound = new Mail1();
		
		public var pMyParent;
		
		public static var expiringMails:Dictionary = new Dictionary();
		
		public function Mail(from:String, subject:String, Content:String, Type:String, Expires, pMyParent = false) 
		{
			this.pMyParent = pMyParent;
			
			this.from = from;
			this.subject = subject;
			this.Content = Content;
			this.Type = Type;
			this.Expires = Expires;
			
			this.dDate = Main.time_field.text;
			
			//this.id = Main.maildp.length - 1;
			
			Main.mailText.text = String(int(Main.mailText.text) + 1);
			Main.mailText.setTextFormat(Main.importantRedFormatLeft);
			
			if (this.Expires != false)
			{
				expiringMails[this] = this.Expires;
				this.expiresIn = this.Expires;
			}
			
			else
			{
				this.expiresIn = "";
			}
			
			Main.maildp.addItemAt({"From": this.from, "Subject": this.subject, "Date": this.dDate, "Content": this.Content, "Type": this.Type, "Expires": this.Expires, "mailID": this, "Expires in": this.expiresIn}, 0);
			this.mail1.play();
			Main.mCo += 1;
			if (Main.maildg.selectedIndex != -1)
			{
				Main.maildg.selectedIndex += 1;
			}
			
			if (int(Main.mailText.text) > 0)
			{
				Main.mailIcon.alpha = 0.8;
			}
			
			Main.mailIcon.newMail();
		}

	}
	
}
