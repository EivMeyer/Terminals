package 
{
	// Importing STUFF
	import com.greensock.*;
	import com.greensock.easing.*;
	import ClosedMail;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import com.freeactionscript.CollisionTest;
	import fl.motion.AdjustColor;
	import fl.controls.DataGrid;
	import fl.data.DataProvider;
	import fl.events.ListEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.text.TextField;
	import flash.text.AntiAliasType;
	import flash.text.TextFormat;
	import fl.controls.Button;
	//import flash.system.Capabilities.screenResolutionY;
	//import flash.system.Capabilities.screenResolutionX;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import fl.controls.List;
	import flash.net.SharedObject;
	import flash.utils.Timer;
	import flash.text.Font;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	import fl.controls.Slider;
	import fl.events.SliderEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	import flash.utils.getQualifiedClassName;

	import flash.display.Shape;
	import fl.transitions.Fly;
	import fl.motion.MatrixTransformer;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import GraphicButton;
	import Route;
	import Mail;
	import Arrow;
	import Airport;
	import StoreButton;
	import PopUpNewLanding;
	import flashx.textLayout.accessibility.TextAccImpl;
	import flash.display.SimpleButton;

	final public class Main extends Sprite
	{
		
		public static var tutorial:Boolean;
		public static var TUTORIALTEXT:String;
		public static var tutorialStep:int = 0;
		public static var tutorialPlaneCounter:int = 0;
		public static var tutorialLine:int;
		public static var tutorialLine2:int;
		// Gameplay Variables
		public static var player:Arrow;
		public static var moveLeft:Boolean = false;
		public static var moveRight:Boolean = false;
		public static var moveUp:Boolean = false;
		public static var moveDown:Boolean = false;
		public static var readyToMove:Boolean = true;
		
		public static var pattern1:RegExp = /%ORIGIN/g;
		public static var pattern2:RegExp = /%COUNTRY/g;
		
		private var _collisionTest:CollisionTest;
		
		public static var routeIndex:int = 0;
		
		public static var LOSING:Boolean = false;
		public static var startBank:Number = 2000000;
		public static var numPlanes:int = -1;
		public static var numActivePlanes:uint = 0;
		public static var planeCapacity:uint = 150;
		public static var routeArray:Array = new Array();
		public static var parentRouteDict:Dictionary = new Dictionary();
		public static const start_airplanePrice:Number = 15000;
		public static const start_marketingPrice:Number = 20000;
		public static const start_landingPrice:Number = 40000;
		public static const start_seatPrice:Number = 40000;
		public static const start_enginePrice:Number = 40000;
		public static const start_terminalprice:Number = 20000;
		public static const start_antiAirPrice:Number = 4000000;
		public static var airplanePrice:Number = start_airplanePrice;
		public static var marketingPrice:Number = start_marketingPrice;
		public static var landingPrice:Number = start_landingPrice;
		public static var seatPrice:Number = start_seatPrice;
		public static var enginePrice:Number = start_enginePrice;
		public static var terminalprice:Number = start_terminalprice;
		public static var antiAirPrice:Number = start_antiAirPrice;
		public static const priceMultiplier:Number = 1.5;
		public static var fuel_cosinus:Number = 0;
		public static var fuel_constant:Number = 100;
		public static var LASTNEWS;
		private var timeTimer:Timer;
		public static var storageArray:Array;
		public static var currentNewsPlace = "";
		private var popUpCounter:int = 0;
		public static var arrayOfStrings:Array = new Array();
		public static var arrayOfSeatStrings:Array = new Array();
		public static var arrayOfEngineStrings:Array = new Array();
		public static var landingPopUp:PopUpNewLanding;
		public static var return_DELETE:Array;
		public var cont:String;
		public static var currentMailFrom:String;
		private var airplane;
		public static var mCo:int = 0;
		private var airportElement;
		public var so:SharedObject;
		public static var currentMail:Mail;
		public static var currentMailIndex:int;
		public static var myData:Array;
		public static var popUpArray:Array = new Array();
		public static const CREATENEWROUTEHOVERTEXT:String = "Add waypoints to your new route by left-clicking on airports on the map. Then click the check icon.";
		public static const bandNames:Array = ["'Thor Deichmann'", "'Elektro'", "'Power Base'", "'Kalcow'", "'A Giraffe Named Alan'", "'Electric Soap'", "'PolyVolt'", "'Shattered Mind'", "'Dead Life'", "'Black Religion'", "'Think!'", "'Rainbowl'", "'Sunrise'", "'thinkt@nk'", "'1nfect1ious'", "'realitise'", "'MC Shwizzle'", "'Mr Lonka Lanka'", "'Weedsterman'", "'Tired Arms'", "'Wild Armies'", "'Ambivolence'", ];
		public static const cometArray:Array = ["Comet Halley", "Comet Encke", "Comet Biela", "Comet Faye", "Comet Brorsen", "Comet Swift–Tuttle", "Comet Tempel 1", "Comet Tempel 2", "Comet Olbers", "Comet Wolf", "Comet Finlay", "Comet Brooks", "Comet Holmes"];
		public static const gangArray:Array = ["The Black Fist", "Warriors of Heaven", "Jade Lotus", "Indigo Brotherhood", "I Coltelli", "Naše Věc", "The Grimaldi Family", "Divine Path", "Sons of Heaven", "Crimson Dawn", "Fishers of Men", "Aurora Nova"];
		public static const partyArray:Array = [];
		public static var currentLocation = false;
		
		public static var dragLeft:Boolean = false;
		public static var dragRight:Boolean = false;
		public static var dragUp:Boolean = false;
		public static var dragDown:Boolean = false;
		
		public static var currentMissions:Array = new Array();
		public static var isMission:Boolean = false;
		
		// Sound Variables
		/*public static var CoindropInstance:Sound =  new Coindrop();
		public static var RiseGradualInstance:Sound =  new RiseGradual();*/
		
		/*private var MovieSound:Sound;
		private var MovieSoundChannel:SoundChannel;
		private var MovieSoundUrl:URLRequest;
		
		public static const songArray:Array = new Array("SketchWithComedy game.mp3", "Sandwich Melon Beat.mp3", "Contextor - Cockpit 2014 (Master v2).mp3", "Contextor - Left Handed.mp3", "Contextor - Shamocrat.mp3", "K4MMERER_-_Dare_my_light.mp3", "NICOCO_-_Leslie.mp3", "NICOCO_-_Tankoko.mp3", "Rise Gradual.mp3", "Sentinel_-_raptly.mp3", "The Helix Dunno Edition.mp3", "Tryad_-_lovely.mp3", "Xcyril_-_Sois_comme_l_eau_-_Disco_Kambat.mp3", "Coindrop (Ja, Das Ist Richtig).mp3");    
		public static var songCounter:uint = 0;*/

		// Enter Frame / Time Variables
		public static var dayValue:int = 60;
		public static var daySpeed:int = 2;
		public static var customEventValue:int = 10;
		public static var dayCount:int = 0;
		protected var randomTall:int;
		public static var event_field_speed:int = 2;

		// Zooming
		public static var spImage:Sprite;
		public var mat:Matrix;
		//public var mcIn:Sprite;
		//public var mcOut:Sprite;

		public var board:Sprite;
		public static const boardWidth:int = 980;
		public static const boardHeight:int = 561;
		public var bounds:Rectangle = new Rectangle(0, 70, 0, 0);
		public var boardMask:Shape;

		public var externalCenter:Point;
		public var internalCenter:Point;

		public static const scaleFactor:Number = 0.90;
		public static var SCALED:Boolean = false;
		public var minScale:Number = 1;
		public var maxScale:Number = 4;
		
		private var zoomPlus:StoreButton;
		private var zoomMinus:StoreButton;

		public static var hoverVis:Boolean = true;
		protected var tile;
		protected var nile;
		protected var mile;
		public static var flightScale:Number = 1;
		
		// Sound
		private var interFace2:Sound = new InterFace2();
		private var reject1:Sound = new Reject1();

		// Background Graphics
		/*public static var button1:Sprite = new Button1();
		public static var button2:Sprite = new Button2();
		public static var button3:Sprite = new Button3();*/
		public static var tempMovingLine:Shape = new Shape();
		public static var startX;
		public static var startY;
		public var bg_data:BitmapData;
		public var bm_image:Bitmap;
		public var bg_image:Sprite;
		public var mapMask:Sprite;
		public var mapbd:BitmapData;
		
		public var airport:Sprite;
		public static var mailYes:HoverButton;
		private var mailNo:Sprite;
		public static var hoverbox:Sprite;
		public static var finishTut:Sprite;
		private var finishTutText:TextField;
		private var finishTutCheck:HoverButton;
		public var restartbox:Sprite;
		public var restarttext:TextField;
		public var yesConfirm:Sprite;
		public var noDeny:Sprite;
		private var allRightsReserved:TextField;
		public static var hovertext:TextField;
		public static var hoverprice:TextField;
		public static var hoverformat:TextFormat;
		public static var hoverformatB:TextFormat;
		public static var hoverformat1:TextFormat;
		public static var hoverformat2:TextFormat;
		public static var popUpFormatGreen:TextFormat;
		public static var popUpFormatBlue:TextFormat;
		public static var popUpFormatBlack:TextFormat;
		public static var popUpFormatRed:TextFormat;
		//public static var verdanaFont:Font = new verdanaFont();
		public static var verdanaFont:Font = new VerdanaFont();
		
		public static var buyTerminalButton:StoreButton;
		public static var buyTerminalGreyButton:StoreGreyButton;
		public static var terminalText:TextField;
		public static var terminalCountry:TextField;
		public static var terminalPrice:TextField;
		//public static var tutorialRoute;

		// Route
		public static var modify_new_route:Sprite;
		public static var empty2but:Sprite;
		
		public static var modify_route:Sprite;
		public var dollar_field_2:TextField;
		public var dollar_format_2:TextFormat;
		public var averageIncomeHover:Sprite;
		public static var average_income:TextField;
		public var averagePassengersHover:Sprite;
		public static var averagePassengersText:TextField;
		private var averagePassengersIcon:Sprite;
		
		public static var empty_left:Sprite;
		public static var modify_format:TextFormat;
		public var price_text:TextField;
		public var price_show:TextField;
		public var price_input:Slider;
		public var frequency_text:TextField;
		public var frequency_show:TextField;
		public var frequency_input:Slider;
		public static var lowFormat:TextFormat;
		public static var mediumFormat:TextFormat;
		public static var highFormat:TextFormat;
		public var yesCheck:HoverButton;
		public var noCheck:HoverButton;

		// Store
		public static var store_board:Sprite;
		public static var storeArray:Array = new Array();
		public static var storeDict:Dictionary = new Dictionary();
		public static var buyplane:StoreButton;
		public static var buyPlaneGrey:StoreGreyButton;
		public static var buylanding:StoreButton;
		public static var buyLandingGrey:StoreGreyButton;		
		public static var buyAntiAir:StoreButton;
		public static var buyAntiAirGrey:StoreGreyButton;
		public static var buymarketing:StoreButton;
		public static var buyMarketingGrey:StoreGreyButton;
		public static var buyseat:StoreButton;
		public static var buySeatGrey:StoreGreyButton;
		public static var buyengine:StoreButton;
		public static var buyEngineGrey:StoreGreyButton;
		
		public static var delete_button:StoreButton;
		public static var removeterminal:StoreButton;
		public static var create_new_route:StoreButton;
		
		// Oil & Seats
		private var oil_board:Sprite;
		private var fuelSubLinesMC:MovieClip;
		private var fuelPriceTextMC:MovieClip;
		private var oljeFatMC:MovieClip;
		private var oilHover:Sprite;
		private var fuelPriceText:TextField;
		private var fuel_format:TextFormat;

		// Economy
		public var eco_board:Sprite;
		public static var cash_format:TextFormat;
		public static var cash_formatS:TextFormat;
		public static var cash_field:TextField;
		private var cashHover:Sprite;
		public var dollar_field:TextField;
		public var dollar_format:TextFormat;
		public static var airplane_field:TextField;
		private var airplaneHover:Sprite;
		public static var airplane_format:TextFormat;
		public static var airplane_formatS:TextFormat;
		public var airplane_icon:Sprite;
		
		// Information on seleced route
		public static var route_board:Sprite;
		public static var route_text:TextField;
		public static var Rprice_text:TextField;
		public static var Rprice_show:TextField;
		public static var Rprice_input:Slider;
		public static var Rfrequency_text:TextField;
		public static var Rfrequency_show:TextField;
		public static var Rfrequency_input:Slider;
		public var s_airplane_icon:Sprite;
		public static var numAirplanesText:TextField;
		//private var addPlane:StoreButton;
		
		// Information on player
		public static var player_board:Sprite;
		private var engineHover:Sprite;
		public static var engineText:TextField;
		private var engineIcon:Sprite;
		private var maxPassengersHover:Sprite;
		public static var maxPassengersText:TextField;
		private var maxPassengersIcon:Sprite;
		

		// Information on selected country
		private var emptyBigButton:Sprite;
		public static var country_board:Sprite;
		
		public static var runwayField:TextField;
		public static var runwayHover:Sprite;
		public static var runwayFormat:TextFormat;
		public static var country_field:TextField;
		public static var influenceBar:Sprite;
		public static var blueReputationBar:Sprite;
		public static var influenceBorder:Sprite;
		public static var influenceBackground:Sprite;
		public static var shaderBar:Sprite;
		public static var shaderMask:Sprite;
		public static var megaphone:Sprite;
		public static var status_info:TextField;
		public static var statusFormat:TextFormat;
		public static var countryHover:Sprite;
		public static var runwaysIcon:Sprite;
		private var sm_airplane_icon:Sprite;
		public static var nextRoute:Sprite;
		public static var numAirplanesTextR:TextField;

		// News
		private var newsBackground:Sprite;
		private var mailBG:Sprite;
		public static var mailText:TextField;
		public static var mailIcon:ClosedMail;
		public static var bigMailBox:Sprite;
		public static var mailContent:TextField;
		//public static var mailExpiresIn:TextField;
		public static var maildg:DataGrid;
		public static var maildp:DataProvider;
		private var countryBG:Sprite;
		public static var newsQueue:Array = new Array();
		public static var newsWaitingQueue:Array = new Array();
		public static var event_field:TextField;
		public static var bmd:BitmapData;
		public static var bm:Bitmap;
		public static var event_country:TextField;
		public static var eventMask:Shape;

		// Date
		protected var clock_bg:Sprite;
		public static var time_field;
		public static var count_down_field;
		public static var dateNow:Date;
		public static var dateFormat:TextFormat;
		public static var redDateFormat:TextFormat;
		public static var bigRedDateFormat:TextFormat;
		public static var importantFormat:TextFormat;
		public static var importantRedFormat:TextFormat;
		public static var importantRedFormatLeft:TextFormat;
		public static var stop_button:Sprite;
		public static var play_button:Sprite;
		public static var play_fast_button:Sprite;
		public static var restart_button:Sprite;

		public static var DELETING:Boolean = false;

		// Creating Airport Dictionaries
		public var S_Algeria:Dictionary = new Dictionary();
		public var S_America:Dictionary = new Dictionary();
		public var S_Argentina:Dictionary = new Dictionary();
		public var S_Australia:Dictionary = new Dictionary();
		public var S_Brazil:Dictionary = new Dictionary();
		public var S_Canada:Dictionary = new Dictionary();
		public var S_Congo:Dictionary = new Dictionary();
		public var S_China:Dictionary = new Dictionary();
		public var S_Denmark:Dictionary = new Dictionary();
		public var S_Egypt:Dictionary = new Dictionary();
		public var S_England:Dictionary = new Dictionary();
		public var S_France:Dictionary = new Dictionary();
		public var S_Germany:Dictionary = new Dictionary();
		public var S_Greece:Dictionary = new Dictionary();
		public var S_Greenland:Dictionary = new Dictionary();
		public var S_Kenya:Dictionary = new Dictionary();
		public var S_Iceland:Dictionary = new Dictionary();
		public var S_India:Dictionary = new Dictionary();
		public var S_Indonesia:Dictionary = new Dictionary();
		public var S_Iran:Dictionary = new Dictionary();
		public var S_Italy:Dictionary = new Dictionary();
		public var S_Japan:Dictionary = new Dictionary();
		public var S_Libya:Dictionary = new Dictionary();
		public var S_Mexico:Dictionary = new Dictionary();
		public var S_Madagascar:Dictionary = new Dictionary();
		public var S_Mongolia:Dictionary = new Dictionary();
		public var S_Nigeria:Dictionary = new Dictionary();
		public var S_Norway:Dictionary = new Dictionary();
		public var S_Poland:Dictionary = new Dictionary();
		public var S_Portugal:Dictionary = new Dictionary();
		public var S_Russia:Dictionary = new Dictionary();
		public var S_Saudi_Arabia:Dictionary = new Dictionary();
		public var S_Somalia:Dictionary = new Dictionary();
		public var S_South_Africa:Dictionary = new Dictionary();
		public var S_Spain:Dictionary = new Dictionary();
		public var S_Sweden:Dictionary = new Dictionary();
		public var S_Turkey:Dictionary = new Dictionary();
		public var S_Ukraine:Dictionary = new Dictionary();
		

		// Event Country Arrays
		public static var dataDict:Dictionary;
		
		public static var notYetAdded:Array;
		public static var notMissionArray:Array;
		public static var Airport_array:Array;
		public static var Neutral_array:Array;
		public static var Friendly_array:Array;
		public static var War_array:Array;
		public static var Blockade_array:Array;
		public static var Tornado_array:Array;
		public static var Tsunami_array:Array;
		public static var HasOil_array:Array;
		public static var Volcano_array:Array;
		public static var Nuclear_array:Array;
		public static var Rich_array:Array;
		public static var Power_array:Array;
		public static var Terrorist_array:Array;
		public static var Pirate_array:Array;
		public static var Malaria_array:Array;
		public static var Dictatorship_array:Array;
		public static var Europe_array:Array;
		public static var Poor_array:Array;
		public static var Active_array:Array;
		
		// Mission dictionary
		//public static var organizationsArray:Array = new Array("Red Cross");
		public static var organizations:Dictionary = new Dictionary();														

		// Creating Event Dictionaries
		public var E_weatherPenalty:Dictionary = new Dictionary();
		public var E_winterOlympics:Dictionary = new Dictionary();
		public var E_summerOlympics:Dictionary = new Dictionary();
		public var E_worldCup:Dictionary = new Dictionary();
		public var E_VolcanicEruption:Dictionary = new Dictionary();
		public var E_fatalVolcanicEruption:Dictionary = new Dictionary();
		public var E_terroristAttack:Dictionary = new Dictionary();
		public var E_tornados:Dictionary = new Dictionary();
		public var E_nuclearDisaster:Dictionary = new Dictionary();
		public var E_meteorStrike:Dictionary = new Dictionary();
		public var E_earthquake:Dictionary = new Dictionary();
		public var E_plague:Dictionary = new Dictionary();
		public var E_alienAttack:Dictionary = new Dictionary();
		public var E_climateChange:Dictionary = new Dictionary();
		public var E_foundOil:Dictionary = new Dictionary();
		public var E_foundOil2:Dictionary = new Dictionary();
		public var E_runOutOfOil:Dictionary = new Dictionary();
		public var E_crimeSpree:Dictionary = new Dictionary();
		public var E_MilitaryCoup:Dictionary = new Dictionary();
		public var E_CivilWar:Dictionary = new Dictionary();
		public var E_BandSuccess:Dictionary = new Dictionary();
		public var E_BandSuccess2:Dictionary = new Dictionary();
		public var E_Pirates:Dictionary = new Dictionary();
		public var E_Malaria:Dictionary = new Dictionary();
		public var E_FreakyWeather:Dictionary = new Dictionary();
		public var E_CometVisible:Dictionary = new Dictionary();
		public var E_newCountryAppearance:Dictionary = new Dictionary();
		public static var E_RacistVideo:Dictionary = new Dictionary();

		// ------------------------------------------------------

		// Very important dictionaries and arrays
		public static var airportDict:Dictionary = new Dictionary();
		public static var eventDict:Dictionary = new Dictionary();
		public static var randomEventArray:Array = new Array();
		public static var scheduledEventArray:Array = new Array();
		public static var collectedAirportArray:Array = new Array();
		public static var collectedRouteArray:Array = new Array();
		public static var collectedAirportDict:Dictionary = new Dictionary();
		public static var collectedAirplaneArray:Array = new Array();
		public static var collectedFighterArray:Array = new Array();
		public static var collectedShotArray:Array = new Array();
		public static var collectedAntiAirArray:Array = new Array();
		public static var allCollectedArrays:Array = new Array(collectedAirportArray, collectedFighterArray, collectedShotArray, collectedAntiAirArray, popUpArray);
		public static var lineArray:Array = new Array();
		public static var checkpointToLineDict:Dictionary = new Dictionary();
		public static var lineHelpArray:Array = new Array();
		public static var hoverDict:Dictionary = new Dictionary();

		public function Main($stageRef, cont, tutorial)
		{			
			$stageRef.addEventListener(KeyboardEvent.KEY_DOWN, keyHandlerDown);
			$stageRef.addEventListener(KeyboardEvent.KEY_UP, keyHandlerUp);
			
			this.cont = cont;
			Main.tutorial = tutorial;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// test
			
			
			// Sound
			
			/*MovieSound = new Sound();
			MovieSoundChannel = new SoundChannel();
			MovieSoundUrl = new URLRequest(songArray[songCounter]);
			MovieSound.load(MovieSoundUrl);  
			MovieSoundChannel = MovieSound.play();
			MovieSoundChannel.addEventListener(Event.SOUND_COMPLETE, SoundLoop)*/
			
			/*CoindropInstance.play();*/
			
			// Formats
			importantFormat = new TextFormat();
			importantFormat.color = 0xFF3300;

			importantRedFormat = new TextFormat();
			importantRedFormat.color = 0xFF3300;
			importantRedFormat.size = 20;
			importantRedFormat.align = "center";
			importantRedFormat.bold = true;
			importantRedFormat.font = verdanaFont.fontName;
			
			importantRedFormatLeft = new TextFormat();
			importantRedFormatLeft.color = 0xFF3300;
			importantRedFormatLeft.size = 20;
			importantRedFormatLeft.align = "left";
			importantRedFormatLeft.bold = true;
			importantRedFormatLeft.font = verdanaFont.fontName;
			
			runwayFormat = new TextFormat();
			runwayFormat.size = 20;
			runwayFormat.align = "center";
			runwayFormat.bold = true;
			runwayFormat.font = verdanaFont.fontName;
			
			popUpFormatGreen = new TextFormat();
			popUpFormatGreen.font = verdanaFont.fontName;
			popUpFormatGreen.color = 0x00CC00;
			popUpFormatGreen.size = 20;
			popUpFormatGreen.align = "center";
			
			popUpFormatBlue = new TextFormat();
			popUpFormatBlue.font = verdanaFont.fontName;
			popUpFormatBlue.color = 0x0000CC;
			popUpFormatBlue.size = 20;
			popUpFormatBlue.align = "center";
			
			popUpFormatBlack = new TextFormat();
			popUpFormatBlack.font = verdanaFont.fontName;
			popUpFormatBlack.size = 20;
			popUpFormatBlack.align = "center";
			
			popUpFormatRed = new TextFormat();
			popUpFormatRed.font = verdanaFont.fontName;
			popUpFormatRed.color = 0xFF0000;
			popUpFormatRed.size = 20;
			popUpFormatRed.align = "center";
			
			dateFormat = new TextFormat();
			dateFormat.color = 0xFFFFFF;
			dateFormat.size = 17;
			dateFormat.align = "center";
			dateFormat.font = verdanaFont.fontName;;
			
			redDateFormat = new TextFormat();
			redDateFormat.color = 0xFF0000;
			redDateFormat.size = 17;
			redDateFormat.align = "center";
			redDateFormat.font = verdanaFont.fontName;;
			
			bigRedDateFormat = new TextFormat();
			bigRedDateFormat.color = 0xFF0000;
			bigRedDateFormat.size = 50;
			bigRedDateFormat.align = "center";
			bigRedDateFormat.font = verdanaFont.fontName;;
			
			hoverformat = new TextFormat();
			hoverformat.font = verdanaFont.fontName;;
			hoverformat.size = 10;
			hoverformat.leading = 5;
			
			hoverformatB = new TextFormat();
			hoverformatB.font = verdanaFont.fontName;;
			hoverformatB.size = 17;
			hoverformatB.leading = 5;
			
			hoverformat1 = new TextFormat();
			hoverformat1.font = verdanaFont.fontName;;
			hoverformat1.size = 12;
			hoverformat1.align = "left";
			hoverformat1.color = "0x00CC00";
			
			hoverformat2 = new TextFormat();
			hoverformat2.font = verdanaFont.fontName;;
			hoverformat2.size = 12;
			hoverformat2.align = "left";
			hoverformat2.color = "0xFF3300";
			
			statusFormat = new TextFormat();
			statusFormat.font = verdanaFont.fontName;;
			statusFormat.size = 11;
			statusFormat.align = "left";
			
			cash_format = new TextFormat();
			cash_format.size = 25;
			cash_format.font = verdanaFont.fontName;
			cash_format.bold = true;
			cash_format.align = "left";
			cash_format.color = "0x00CC00";
			
			cash_formatS = new TextFormat();
			cash_formatS.size = 20;
			cash_formatS.font = verdanaFont.fontName;
			cash_formatS.bold = true;
			cash_formatS.align = "left";
			cash_formatS.color = "0x00CC00";

			dollar_format = new TextFormat();
			dollar_format.size = 35;
			dollar_format.font = verdanaFont.fontName;
			dollar_format.align = "left";
			dollar_format.bold = true;
			
			fuel_format = new TextFormat();
			fuel_format.size = 35;
			fuel_format.font = verdanaFont.fontName;
			fuel_format.align = "left";
			fuel_format.bold = true;

			airplane_format = new TextFormat();
			airplane_format.size = 25;
			airplane_format.font = verdanaFont.fontName;
			airplane_format.align = "left";
			airplane_format.color = "0x0033CC";
			airplane_format.bold = true;
			
			airplane_formatS = new TextFormat();
			airplane_formatS.size = 20;
			airplane_formatS.font = verdanaFont.fontName;
			airplane_formatS.align = "left";
			airplane_formatS.color = "0x0033CC";
			airplane_formatS.bold = true;
			
			modify_format = new TextFormat();
			modify_format.size = 13;
			modify_format.font = verdanaFont.fontName;
			modify_format.align = "center";
			modify_format.bold = false;

			lowFormat = new TextFormat();
			lowFormat.size = 13;
			lowFormat.font = verdanaFont.fontName;
			lowFormat.align = "center";
			lowFormat.color = "0x00CC00";
			mediumFormat = new TextFormat();
			mediumFormat.size = 13;
			mediumFormat.font = verdanaFont.fontName;
			mediumFormat.align = "center";
			mediumFormat.color = "0xFFCC00";
			highFormat = new TextFormat();
			highFormat.size = 13;
			highFormat.font = verdanaFont.fontName;
			highFormat.align = "center";
			highFormat.color = "0xFF0000";

			// News & Events

			mailBG = new ClockS();
			mailBG.x = 0;
			mailBG.y = 0;
			this.addChild(mailBG);
			
			mailIcon = new ClosedMail();
			mailIcon.x = 40;
			mailIcon.y = mailBG.height * 0.5;
			mailIcon.alpha = 0.5;
			mailIcon.buttonMode = true;
			hoverDict[mailIcon] = ["Read your mails."];
			this.addChild(mailIcon);
			mailIcon.addEventListener(MouseEvent.CLICK, showMails);
			
			mailText = new TextField();
			mailText.text = "0";
			//mailText.visible = false;
			mailText.y = mailBG.height * 0.5 - 10;
			mailText.x = 75;
			mailText.width = 40;
			mailText.setTextFormat(importantRedFormatLeft);
			mailText.embedFonts = true;
			mailText.mouseEnabled = false;
			mailBG.addChild(mailText);
			
			bigMailBox = new BigMailBox();
			bigMailBox.x = 670;
			bigMailBox.y = boardHeight - 150;
			bigMailBox.visible = false;
			stage.addChild(bigMailBox);
			
			mailContent = new TextField();
			mailContent.text = "";
			//mailContent.visible = false;
			mailContent.y = -70;
			mailContent.x = -140;
			mailContent.width = 280;
			mailContent.height = 380;
			mailContent.wordWrap = true;
			mailContent.setTextFormat(hoverformat);
			mailContent.embedFonts = true;
			mailContent.mouseEnabled = false;
			bigMailBox.addChild(mailContent);
			
			/*mailExpiresIn = new TextField();
			mailExpiresIn.text = "";
			//mailExpiresIn.visible = false;
			mailExpiresIn.y = 20;
			mailExpiresIn.x = -70;
			mailExpiresIn.visible = false;
			mailExpiresIn.width = 280;
			mailExpiresIn.setTextFormat(importantRedFormat);
			mailExpiresIn.embedFonts = true;
			mailExpiresIn.mouseEnabled = false;
			bigMailBox.addChild(mailExpiresIn);*/
			
			mailYes = new YesConfirm();
			bigMailBox.addChild(mailYes);
			mailYes.x = 0;
			mailYes.y = 60;
			mailYes.buttonMode = true;
			mailYes.addEventListener(MouseEvent.CLICK, acceptMail);
			hoverDict[mailYes] = [""];
			
			mailNo = new NoDeny();
			bigMailBox.addChild(mailNo);
			mailNo.x = 120;
			mailNo.y = -80;
			mailNo.buttonMode = true;
			hoverDict[mailNo] = [""];
			mailNo.addEventListener(MouseEvent.CLICK, rejectMail);
			
			countryBG = new Clock();
			countryBG.x = mailBG.width;
			countryBG.y = 0;
			this.addChild(countryBG);

			newsBackground = new NewsBackGround();
			newsBackground.x = mailBG.width + countryBG.width;
			newsBackground.y = 0;
			this.addChild(newsBackground);

			clock_bg = new Clock();
			clock_bg.x = mailBG.width + countryBG.width + newsBackground.width;
			clock_bg.y = 0;
			this.addChild(clock_bg);

			event_field = new TextField();
			event_field.y = 20;
			event_field.x = 800;
			event_field.height = 40;
			event_field.mouseEnabled = false;
			event_field.visible = false;
			event_field.text = "";
			event_field.antiAliasType = AntiAliasType.ADVANCED;
			event_field.defaultTextFormat = dateFormat;
			event_field.embedFonts = true;
		
			timeTimer = new Timer(30);
			timeTimer.addEventListener(TimerEvent.TIMER, time);
			timeTimer.start();
			
			bmd = new BitmapData (event_field.width, event_field.height, true, 0);
			bmd.draw (event_field);
			
			bm = new Bitmap (bmd);
			bm.x = event_field.x;
			bm.y = event_field.y;
			bm.smoothing = true;
			this.addChild(bm);

			event_country = new TextField();
			event_country.y = 20;
			event_country.x = 0;
			event_country.width = countryBG.width;
			event_country.height = 40;
			event_country.mouseEnabled = false;
			event_country.embedFonts = true;
			event_country.text = "";
			event_country.setTextFormat(importantRedFormat);
			countryBG.addChild(event_country);
			
			eventMask = new Shape();
			eventMask.graphics.beginFill(0x9900CC);
			eventMask.graphics.drawRect(0,0,570,clock_bg.height);
			eventMask.graphics.endFill();
			eventMask.x = mailBG.width + countryBG.width + 5;
			eventMask.y = 0;
			this.addChild(eventMask);
			bm.mask = eventMask;

			// Economy
			eco_board = new GraphicButton(false,false);
			eco_board.y = 561;
			eco_board.x = 0;
			this.addChild(eco_board);
			
			cashHover = new BigHoverbox();
			cashHover.x = 10;
			cashHover.y = 5;
			hoverDict[cashHover] = ["Bank account"];
			eco_board.addChild(cashHover);

			cash_field = new TextField();
			cash_field.x = 60;
			cash_field.y = 10;
			cash_field.mouseEnabled = false;
			cash_field.embedFonts = true;
			if (tutorial == true)
			{
				cash_field.text = String(0);
			}
			else
			{
				cash_field.text = String(startBank);
			}
			cash_field.width = eco_board.width;
			cash_field.setTextFormat(cash_format);
			eco_board.addChild(cash_field);

			dollar_field = new TextField();
			dollar_field.x = 20;
			dollar_field.y = 6;
			dollar_field.embedFonts = true;
			dollar_field.mouseEnabled = false;
			dollar_field.text = "$";
			dollar_field.setTextFormat(dollar_format);
			eco_board.addChild(dollar_field);
		
			airplane_field = new TextField();
			airplane_field.x = 60;
			airplane_field.y = 60;
			airplane_field.mouseEnabled = false;
			airplane_field.embedFonts = true;
			airplane_field.text = String(numActivePlanes) + " / " + String(numPlanes);
			airplane_field.setTextFormat(airplane_format);
			airplane_field.width = 150;
			eco_board.addChild(airplane_field);
			
			airplaneHover = new BigHoverbox();
			airplaneHover.x = 10;
			airplaneHover.y = 60;
			hoverDict[airplaneHover] = ["Airborne planes out of total"];
			eco_board.addChild(airplaneHover);

			airplane_icon = new FlightIcon();
			airplane_icon.x = 10;
			airplane_icon.y = 60;
			airplane_icon.mouseChildren = false;
			airplane_icon.mouseEnabled = false;
			eco_board.addChild(airplane_icon);

			// Create new route

			// Modify new route;
			
			empty_left = new GraphicButton(false,false);
			empty_left.x = 0;
			empty_left.y = 561;
			this.addChildAt(empty_left, this.numChildren-1);
			
			empty2but = new GraphicButton(false,false);
			empty2but.x = empty2but.width;
			empty2but.y = 561;
			this.addChildAt(empty2but, this.numChildren-1);
			
			modify_new_route = new GraphicButton(false,false);
			modify_new_route.x = modify_new_route.width;
			modify_new_route.y = 561;
			modify_new_route.visible = false;
			this.addChildAt(modify_new_route, this.numChildren-1);
			
			modify_route = new GraphicButton(false,false);
			modify_route.x = modify_new_route.width;
			modify_route.y = 561;
			modify_route.visible = false;
			this.addChildAt(modify_route, this.numChildren-1);
			
			dollar_field_2 = new TextField();
			dollar_field_2.x = 20;
			dollar_field_2.y = 6;
			dollar_field_2.embedFonts = true;
			dollar_field_2.mouseEnabled = false;
			dollar_field_2.text = "$";
			dollar_field_2.setTextFormat(dollar_format);
			modify_route.addChild(dollar_field_2);
			
			average_income = new TextField();
			average_income.x = 60;
			average_income.y = 10;
			average_income.embedFonts = true;
			average_income.mouseEnabled = false;
			average_income.text = "$";
			average_income.setTextFormat(cash_format);
			modify_route.addChild(average_income);
			
			averageIncomeHover = new BigHoverbox();
			averageIncomeHover.x = dollar_field_2.x - 5;
			averageIncomeHover.y = average_income.y - 5;
			hoverDict[averageIncomeHover] = ["This route's average income over the last 10 flights."];
			modify_route.addChild(averageIncomeHover);
			
			averagePassengersText = new TextField();
			averagePassengersText.y = 60;
			averagePassengersText.x = 60;
			averagePassengersText.text = String(planeCapacity);
			averagePassengersText.setTextFormat(airplane_format);
			averagePassengersText.mouseEnabled = false;
			averagePassengersText.embedFonts = true;
			modify_route.addChild(averagePassengersText);
			
			averagePassengersIcon = new PassengersIcon();
			averagePassengersIcon.y = 60;
			averagePassengersIcon.x = 20;
			averagePassengersIcon.mouseEnabled = false;
			modify_route.addChild(averagePassengersIcon);
			
			averagePassengersHover = new BigHoverbox();
			averagePassengersHover.x = averagePassengersIcon.x - 5;
			averagePassengersHover.y = averagePassengersText.y - 5;
			hoverDict[averagePassengersHover] = ["This route's average passenger count for the last 10 flights."];
			modify_route.addChild(averagePassengersHover);

			price_text = new TextField();
			price_text.text = "Ticket prices";
			price_text.y = 10;
			price_text.x = 5;
			price_text.embedFonts = true;
			price_text.width = modify_new_route.width / 2;
			price_text.setTextFormat(modify_format);
			price_text.mouseEnabled = false;
			modify_new_route.addChild(price_text);
			price_show = new TextField();
			price_show.text = "100";
			price_show.y = 55;
			price_show.x = 5;
			price_show.embedFonts = true;
			price_show.width = modify_new_route.width / 2;
			price_show.setTextFormat(lowFormat);
			price_show.mouseEnabled = false;
			modify_new_route.addChild(price_show);
			price_input = new Slider();
			price_input.maximum = 401;
			price_input.minimum = 1;
			price_input.liveDragging = true;
			price_input.enabled = true;
			price_input.x = 30;
			price_input.y = 40;
			price_input.addEventListener(SliderEvent.CHANGE, changePriceShow);
			modify_new_route.addChild(price_input);

			frequency_text = new TextField();
			frequency_text.y = 10;
			frequency_text.x = modify_new_route.width / 2 + 5;
			frequency_text.width = modify_new_route.width / 2 - 10;
			frequency_text.text = "Flight frequency";
			frequency_text.embedFonts = true;
			frequency_text.setTextFormat(modify_format);
			frequency_text.mouseEnabled = false;
			modify_new_route.addChild(frequency_text);
			frequency_show = new TextField();
			frequency_show.y = 55;
			frequency_show.x = modify_new_route.width / 2 + 5;
			frequency_show.width = modify_new_route.width / 2 - 10;
			frequency_show.text = "Low";
			frequency_show.embedFonts = true;
			frequency_show.setTextFormat(lowFormat);
			frequency_show.mouseEnabled = false;
			modify_new_route.addChild(frequency_show);
			frequency_input = new Slider();
			frequency_input.maximum = 3;
			frequency_input.minimum = 1;
			frequency_input.liveDragging = true;
			frequency_input.enabled = true;
			frequency_input.x = frequency_text.x + 15;
			frequency_input.y = 40;
			frequency_input.addEventListener(SliderEvent.CHANGE, changeFrequencyShow);
			modify_new_route.addChild(frequency_input);

			yesCheck = new YesCheck();
			yesCheck.x = modify_new_route.width / 2;
			yesCheck.y = 75;
			yesCheck.alpha = 0.8;
			yesCheck.buttonMode = true;
			yesCheck.addEventListener(MouseEvent.CLICK, confirm_route);
			hoverDict[yesCheck] = [""];
			modify_new_route.addChild(yesCheck);
			
			noCheck = new NoCheck();
			noCheck.x = modify_new_route.width - 20 ;
			noCheck.y = 85;
			noCheck.alpha = 0.8;
			noCheck.buttonMode = true;
			hoverDict[yesCheck] = [""];
			noCheck.addEventListener(MouseEvent.CLICK, cancel_route);
			modify_new_route.addChild(noCheck);
			
			// Country Info;
			
			emptyBigButton = new GraphicButton(false,false);;
			emptyBigButton.y = boardHeight;
			emptyBigButton.x = 2 * modify_new_route.width;
			this.addChild(emptyBigButton);
			
			maildg = new DataGrid();
			this.addChild(maildg);
			maildg.editable = false;
			maildg.sortableColumns = false;
			maildg.setSize(340, 500); 
			maildg.x = 2 * modify_new_route.width + 10;
			maildg.y = boardHeight + 10;
			maildg.rowCount = 3;
			maildg.visible = false;
			maildg.columns = ["From", "Subject", "Date", "Expires in"];
			maildg.columns[0].width = 100;
			maildg.columns[1].width = 110;
			maildg.columns[2].width = 70;
			maildg.columns[3].width = 60;
			maildg.resizableColumns = false;
			maildg.alpha = 0.8;
			maildg.addEventListener(ListEvent.ITEM_CLICK, selectMail);
			maildp = new DataProvider();
			
			maildg.dataProvider  = maildp;
			route_board = new GraphicButton(false,false);
			route_board.y = boardHeight;
			route_board.visible = false;
			route_board.x = emptyBigButton.x;
			this.addChild(route_board);
			
			nextRoute = new NextRoute();
			route_board.addChild(nextRoute);
			nextRoute.x = route_board.width - 25;
			nextRoute.y = 20;
			nextRoute.visible = false;
			nextRoute.buttonMode = true;
			nextRoute.addEventListener(MouseEvent.CLICK, showNextRoute);
			hoverDict[nextRoute] = ["Multiple routes are overlapping. Show the next one."];
			
			route_text = new TextField();
			route_text.text = "";
			route_text.y = 5;
			route_text.x = 0;
			route_text.embedFonts = true;
			route_text.width = route_board.width;
			route_text.setTextFormat(modify_format);
			route_text.mouseEnabled = false;
			route_board.addChild(route_text);
			
			Rprice_text = new TextField();
			Rprice_text.text = "Ticket prices";
			Rprice_text.y = 25;
			Rprice_text.x = 5;
			Rprice_text.embedFonts = true;
			Rprice_text.width = modify_new_route.width / 2;
			Rprice_text.setTextFormat(modify_format);
			Rprice_text.mouseEnabled = false;
			route_board.addChild(Rprice_text);
			Rprice_show = new TextField();
			Rprice_show.text = "100";
			Rprice_show.y = 55;
			Rprice_show.x = 5;
			Rprice_show.embedFonts = true;
			Rprice_show.width = route_board.width / 2;
			Rprice_show.setTextFormat(lowFormat);
			Rprice_show.mouseEnabled = false;
			route_board.addChild(Rprice_show);
			Rprice_input = new Slider();
			Rprice_input.maximum = 401;
			Rprice_input.minimum = 1;
			Rprice_input.liveDragging = true;
			Rprice_input.enabled = true;
			Rprice_input.x = 30;
			Rprice_input.y = 45;
			Rprice_input.addEventListener(SliderEvent.CHANGE, RchangePriceShow);
			route_board.addChild(Rprice_input);

			Rfrequency_text = new TextField();
			Rfrequency_text.y = 25;
			Rfrequency_text.x = route_board.width / 2 + 5;
			Rfrequency_text.width = route_board.width / 2 - 10;
			Rfrequency_text.text = "Flight frequency";
			Rfrequency_text.embedFonts = true;
			Rfrequency_text.setTextFormat(modify_format);
			Rfrequency_text.mouseEnabled = false;
			route_board.addChild(Rfrequency_text);
			Rfrequency_show = new TextField();
			Rfrequency_show.y = 55;
			Rfrequency_show.x = route_board.width / 2 + 5;
			Rfrequency_show.width = route_board.width / 2 - 10;
			Rfrequency_show.text = "Low";
			Rfrequency_show.embedFonts = true;
			Rfrequency_show.setTextFormat(lowFormat);
			Rfrequency_show.mouseEnabled = false;
			route_board.addChild(Rfrequency_show);
			Rfrequency_input = new Slider();
			Rfrequency_input.maximum = 3;
			Rfrequency_input.minimum = 1;
			Rfrequency_input.liveDragging = true;
			Rfrequency_input.enabled = true;
			Rfrequency_input.x = Rfrequency_text.x + 15;
			Rfrequency_input.y = 45;
			Rfrequency_input.addEventListener(SliderEvent.CHANGE, RchangeFrequencyShow);
			route_board.addChild(Rfrequency_input);
			
			s_airplane_icon = new FlightIconSmall();
			s_airplane_icon.x = 100;
			s_airplane_icon.y = 77;
			s_airplane_icon.mouseChildren = false;
			s_airplane_icon.mouseEnabled = false;
			route_board.addChild(s_airplane_icon);
			
			numAirplanesText = new TextField();
			numAirplanesText.text = "";
			//numAirplanesText.visible = false;
			numAirplanesText.y = 60;
			numAirplanesText.x = 120;
			numAirplanesText.width = 60;
			numAirplanesText.setTextFormat(runwayFormat);
			numAirplanesText.embedFonts = true;
			numAirplanesText.mouseEnabled = false;
			route_board.addChild(numAirplanesText);
			
			// PLAYER BOARD
			player_board = new GraphicButton(false,false);
			player_board.y = boardHeight;
			player_board.visible = false;
			player_board.x = emptyBigButton.x;
			this.addChild(player_board);
			
			maxPassengersText = new TextField();
			maxPassengersText.y = 10;
			maxPassengersText.x = 60;
			maxPassengersText.text = String(planeCapacity);
			maxPassengersText.setTextFormat(cash_format);
			maxPassengersText.mouseEnabled = false;
			maxPassengersText.embedFonts = true;
			player_board.addChild(maxPassengersText);
			
			maxPassengersIcon = new MaxPassengersIcon();
			maxPassengersIcon.y = 15;
			maxPassengersIcon.x = 20;
			maxPassengersIcon.mouseEnabled = false;
			player_board.addChild(maxPassengersIcon);
			
			maxPassengersHover = new HoverRectangle();
			maxPassengersHover.x = maxPassengersText.x - 5;
			maxPassengersHover.y = maxPassengersText.y - 50;
			hoverDict[maxPassengersHover] = ["Your airplanes' current passenger capacity."];
			player_board.addChild(maxPassengersHover);
			
			engineText = new TextField();
			engineText.y = 64;
			engineText.x = 60;
			engineText.text = String(Airplane.SPEED);
			engineText.setTextFormat(airplane_format);
			engineText.mouseEnabled = false;
			engineText.embedFonts = true;
			player_board.addChild(engineText);
			
			engineHover = new HoverRectangle();
			engineHover.x = engineText.x - 5;
			engineHover.y = engineText.x - 50;
			hoverDict[engineHover] = ["Your airplanes' current speed."];
			player_board.addChild(engineHover);
			
			engineIcon = new EngineIcon();
			engineIcon.y = engineText.y + 10;
			engineIcon.x = 16;
			engineIcon.mouseEnabled = false;
			player_board.addChild(engineIcon);
			
			country_board = new GraphicButton(false,false);
			country_board.y = boardHeight;
			country_board.visible = false;
			country_board.x = emptyBigButton.x;			
			this.addChild(country_board);

			country_field = new TextField();
			country_field.text = "";
			//country_field.visible = false;
			country_field.y = 10;
			country_field.x = 20;
			country_field.width = modify_new_route.width;
			country_field.setTextFormat(importantRedFormatLeft);
			country_field.embedFonts = true;
			country_field.mouseEnabled = false;
			country_board.addChild(country_field);
			
			runwayField = new TextField();
			//runwayField.visible = false;
			runwayField.text = "0";
			runwayField.y = 10;
			runwayField.x = 150;
			runwayField.width = 30;
			runwayField.embedFonts = true;
			runwayField.setTextFormat(runwayFormat);
			runwayField.mouseEnabled = false;
			country_board.addChild(runwayField);
			
			runwayHover = new HoverRectangle();
			//runwayHover.visible = false;
			runwayHover.x = 155;
			runwayHover.y = 5;
			hoverDict[runwayHover] = ["Current available runways at selected airport."];
			country_board.addChild(runwayHover);
			
			runwaysIcon = new Runways();
			//runwaysIcon.visible = false;
			runwaysIcon.y = 10;
			runwaysIcon.x = 125;
			runwaysIcon.mouseEnabled = false;
			runwaysIcon.mouseChildren = false;
			country_board.addChild(runwaysIcon);
			
			countryHover = new HoverBiggerRectangle();
			//countryHover.visible = false;
			countryHover.x = 10;
			countryHover.y = 50;
			hoverDict[countryHover] = ["Your influence in the selected country. The red bar represents advertising. The blue bar represents outgoing routes."];
			country_board.addChild(countryHover);

			influenceBackground = new InfluenceBackground();
			influenceBackground.y = 80;
			//influenceBackground.visible = false;
			influenceBackground.alpha = 0.2;
			influenceBackground.x = modify_new_route.width / 2 + 30;
			influenceBackground.mouseEnabled = false;
			influenceBackground.mouseChildren = false;
			country_board.addChild(influenceBackground);

			influenceBar = new InfluenceBar();
			influenceBar.y = 80;
			//influenceBar.visible = false;
			influenceBar.alpha = 0.5;
			influenceBar.x = 0;
			influenceBar.mouseEnabled = false;
			influenceBar.mouseChildren = false;
			country_board.addChild(influenceBar);
			
			blueReputationBar = new BlueReputationBar();
			blueReputationBar.y = 80;
			//blueReputationBar.visible = false;
			blueReputationBar.alpha = 0.5;
			blueReputationBar.x = 0;
			blueReputationBar.mouseEnabled = false;
			blueReputationBar.mouseChildren = false;
			country_board.addChild(blueReputationBar);

			influenceBorder = new InfluenceBorder();
			influenceBorder.y = 80;
			//influenceBorder.visible = false;
			influenceBorder.alpha = 0.8;
			influenceBorder.x = modify_new_route.width / 2 + 30;
			influenceBorder.mouseEnabled = false;
			influenceBorder.mouseChildren = false;
			country_board.addChild(influenceBorder);

			shaderMask = new ShaderMask();
			//shaderMask.visible = false;
			shaderMask.y = 80;
			shaderMask.alpha = 0;
			shaderMask.x = modify_new_route.width / 2 + 30;
			shaderMask.mouseEnabled = false;
			shaderMask.mouseChildren = false;
			country_board.addChild(shaderMask);

			shaderBar = new ShaderBar();
			shaderBar.y = 80;
			//shaderBar.visible = false;
			shaderBar.alpha = 0.5;
			shaderBar.x = modify_new_route.width / 2 + 30;
			shaderBar.mouseEnabled = false;
			shaderBar.mouseChildren = false;
			country_board.addChild(shaderBar);

			influenceBar.mask = shaderBar;
			blueReputationBar.mask = shaderMask;

			megaphone = new Megaphone();
			megaphone.y = 80;
			megaphone.x = 40;
			megaphone.mouseEnabled = false;
			megaphone.mouseChildren = false;
			country_board.addChild(megaphone);
						
			status_info = new TextField();
			status_info.text = "";
			status_info.y = 40;
			status_info.x = 40;
			status_info.embedFonts = true;
			status_info.mouseEnabled = false;
			status_info.width = 200;
			country_board.addChild(status_info);
			
			
			
			sm_airplane_icon = new FlightIconSmall();
			sm_airplane_icon.x = 185;
			sm_airplane_icon.y = 28;
			/*runwaysIcon.y = 10;
			runwaysIcon.x = 135;*/
			sm_airplane_icon.mouseChildren = false;
			sm_airplane_icon.mouseEnabled = false;
			country_board.addChild(sm_airplane_icon);
			
			numAirplanesTextR = new TextField();
			numAirplanesTextR.text = "0";
			//numAirplanesText.visible = false;
			numAirplanesTextR.y = 10;
			numAirplanesTextR.x = 205;
			numAirplanesTextR.width = 40;
			numAirplanesTextR.setTextFormat(Main.cash_format);
			numAirplanesTextR.embedFonts = true;
			numAirplanesTextR.mouseEnabled = false;
			country_board.addChild(numAirplanesTextR);
			
			
			
						
			// Store
			
			store_board = new SmallGraphicButton();
			store_board.y = boardHeight;
			store_board.x = 3*modify_new_route.width;
			this.addChild(store_board);
			
			buyplane = new Buyplane();
			buyplane.x = 4;
			buyplane.visible = false;
			buyplane.opaqueBackground = 1;
			buyplane.y = 5;
			buyplane.alpha = 0.8;
			buyplane.buttonMode = true;
			hoverDict[buyplane] = ["Buy an aircraft.", airplanePrice];
			buyplane.price = airplanePrice;
			storeArray[storeArray.length] = buyplane;
			store_board.addChild(buyplane);
			buyplane.addEventListener(MouseEvent.CLICK, buyplaneFunction);
			
			buyPlaneGrey = new BuyPlaneGrey();
			buyPlaneGrey.x = 4;
			buyPlaneGrey.visible = false;
			buyPlaneGrey.opaqueBackground = 1;
			buyPlaneGrey.y = 5;
			buyPlaneGrey.buttonMode = true;
			hoverDict[buyPlaneGrey] = ["Buy an aircraft.", airplanePrice];
			buyPlaneGrey.price = airplanePrice;
			store_board.addChild(buyPlaneGrey);
			storeDict[buyplane] = buyPlaneGrey;
			
			buylanding = new Buylanding();
			buylanding.x = 4;
			buylanding.visible = false;
			buylanding.opaqueBackground = 1;
			buylanding.buttonMode = true;
			buylanding.y = store_board.height/2-3;
			buylanding.alpha = 0.8;
			buylanding.price = landingPrice;
			storeArray[storeArray.length] = buylanding;
			hoverDict[buylanding] = ["Get access to an additional runway at this airport.", landingPrice];
			store_board.addChild(buylanding);
			buylanding.addEventListener(MouseEvent.CLICK, buylandingFunction);
			buyLandingGrey = new BuyLandingGrey();
			buyLandingGrey.x = 4;
			buyLandingGrey.visible = false;
			buyLandingGrey.opaqueBackground = 1;
			buyLandingGrey.buttonMode = true;
			buyLandingGrey.y = store_board.height/2-3;
			buyLandingGrey.price = landingPrice;
			hoverDict[buyLandingGrey] = ["Get access to an additional runway at this airport.", landingPrice];
			store_board.addChild(buyLandingGrey);
			storeDict[buylanding] = buyLandingGrey;
			
			buymarketing = new Buymarketing();
			buymarketing.x = 4;
			buymarketing.opaqueBackground = 1;
			buymarketing.y = 5;
			buymarketing.alpha = 0.8;
			buymarketing.visible = false;
			buymarketing.buttonMode = true;
			buymarketing.price = marketingPrice;
			storeArray[storeArray.length] = buymarketing;
			hoverDict[buymarketing] = ["Promote your airline in this country.", marketingPrice];
			store_board.addChild(buymarketing);
			buymarketing.addEventListener(MouseEvent.CLICK, buymarketingFunction);
			buyMarketingGrey = new BuyMarketingGrey();
			buyMarketingGrey.x = 4;
			buyMarketingGrey.opaqueBackground = 1;
			buyMarketingGrey.y = 5;
			buyMarketingGrey.visible = false;
			buyMarketingGrey.buttonMode = true;
			buyMarketingGrey.price = marketingPrice;
			hoverDict[buyMarketingGrey] = ["Promote your airline in this country.", marketingPrice];
			store_board.addChild(buyMarketingGrey);
			storeDict[buymarketing] = buyMarketingGrey;
			
			buyengine = new BuyEngine();
			buyengine.x = 4;
			buyengine.opaqueBackground = 1;
			buyengine.buttonMode = true;
			buyengine.visible = false;
			buyengine.y = 5 + buymarketing.height;
			buyengine.alpha = 0.8;
			buyengine.price = enginePrice;
			storeArray[storeArray.length] = buyengine;
			hoverDict[buyengine] = ["Upgrade the speed of your planes by 0.1.", enginePrice];
			store_board.addChild(buyengine);
			buyengine.addEventListener(MouseEvent.CLICK, buyengineFunction);
			buyEngineGrey = new BuyEngineGrey();
			buyEngineGrey.x = 4;
			buyEngineGrey.opaqueBackground = 1;
			buyEngineGrey.buttonMode = true;
			buyEngineGrey.y = 5 + buymarketing.height;
			buyEngineGrey.price = enginePrice;
			hoverDict[buyEngineGrey] = ["Upgrade the speed of your planes by 0.1.", enginePrice];
			store_board.addChild(buyEngineGrey);
			storeDict[buyengine] = buyEngineGrey;
			
			buyseat = new Buyseat();
			buyseat.x = 4+buyengine.width;
			buyseat.opaqueBackground = 1;
			buyseat.visible = false;
			buyseat.y = 5 + buymarketing.height;
			buyseat.alpha = 0.8;
			buyseat.buttonMode = true;
			buyseat.price = seatPrice;
			storeArray[storeArray.length] = buyseat;
			hoverDict[buyseat] = ["Expand your seating capacity by 30 seats.", seatPrice];
			store_board.addChild(buyseat);
			buyseat.addEventListener(MouseEvent.CLICK, buyseatFunction);
			buySeatGrey = new BuySeatGrey();
			buySeatGrey.x = 4+buyengine.width;
			buySeatGrey.opaqueBackground = 1;
			buySeatGrey.y = 5 + buymarketing.height;
			buySeatGrey.buttonMode = true;
			buySeatGrey.price = seatPrice;
			hoverDict[buySeatGrey] = ["Expand your seating capacity by 30 seats.", seatPrice];
			store_board.addChild(buySeatGrey);
			storeDict[buyseat] = buySeatGrey;
			
			removeterminal = new RemoveTerminal();
			removeterminal.x = 4+removeterminal.width;
			removeterminal.opaqueBackground = 1;
			removeterminal.y = store_board.height/2-3;
			removeterminal.alpha = 0.8;
			removeterminal.visible = false;
			removeterminal.buttonMode = true;
			removeterminal.price = false;
			hoverDict[removeterminal] = ["Remove your terminal here. You will get your money refunded."];
			store_board.addChild(removeterminal);
			removeterminal.addEventListener(MouseEvent.CLICK, removeTerminalFunction);
			
			create_new_route = new BigCreateButton();
			create_new_route.x = 4 + buyplane.width;
			create_new_route.y = 5;
			create_new_route.alpha = 0.8;
			create_new_route.visible = false;
			create_new_route.opaqueBackground = 1;
			create_new_route.buttonMode = true;
			create_new_route.price = false;
			hoverDict[create_new_route] = ["Create a new route"];
			store_board.addChild(create_new_route);
			create_new_route.addEventListener(MouseEvent.CLICK, new_route);
			
			delete_button = new DeleteButton();
			delete_button.x = 4;
			delete_button.opaqueBackground = 1;
			delete_button.buttonMode = true;
			delete_button.visible = false;
			delete_button.alpha = 0.8;
			delete_button.y = 5;
			delete_button.price = false;
			delete_button.clicked = true;
			hoverDict[delete_button] = ["Delete this route."];
			store_board.addChild(delete_button);
			delete_button.addEventListener(MouseEvent.CLICK, deleteFunction);
			
			buyTerminalButton = new BuyTerminalButton();
			buyTerminalButton.x = 4;
			buyTerminalButton.y = 5;
			buyTerminalButton.visible = false;
			buyTerminalButton.buttonMode = true;
			buyTerminalButton.alpha = 1;
			hoverDict[buyTerminalButton] = ["Buy a terminal here. Gives you commercial access to this airport.", "%TERMINALPRICE"];
			store_board.addChild(buyTerminalButton);
			buyTerminalButton.addEventListener(MouseEvent.CLICK, buyTerminal);
			
			buyTerminalGreyButton = new BuyTerminalButtonGrey();
			buyTerminalGreyButton.x = 4;
			buyTerminalGreyButton.y = 5;
			buyTerminalGreyButton.visible = false;
			buyTerminalGreyButton.buttonMode = true;
			buyTerminalGreyButton.alpha = 1;
			hoverDict[buyTerminalGreyButton] = ["Buy a terminal here. Gives you commercial access to this airport.", "%TERMINALPRICE"];
			store_board.addChild(buyTerminalGreyButton);
			
			
			buyAntiAir = new BuyAntiAir();
			buyAntiAir.x = 4;
			buyAntiAir.visible = false;
			buyAntiAir.opaqueBackground = 1;
			buyAntiAir.buttonMode = true;
			buyAntiAir.alpha = 0.8;
			buyAntiAir.y = 6;
			buyAntiAir.price = antiAirPrice;
			storeArray[storeArray.length] = buyAntiAir;
			hoverDict[buyAntiAir] = ["Put down an anti aircraft gun here.", antiAirPrice];
			store_board.addChild(buyAntiAir);
			buyAntiAir.addEventListener(MouseEvent.CLICK, buyAntiAirFunction);
			buyAntiAirGrey = new BuyAntiAirGrey();
			buyAntiAirGrey.x = 4;
			buyAntiAirGrey.visible = false;
			buyAntiAirGrey.opaqueBackground = 1;
			buyAntiAirGrey.buttonMode = true;
			buyAntiAirGrey.y = 6;
			buyAntiAirGrey.price = antiAirPrice;
			hoverDict[buyAntiAirGrey] = ["Put down an anti aircraft gun here.", antiAirPrice];
			store_board.addChild(buyAntiAirGrey);
			storeDict[buyAntiAir] = buyAntiAirGrey;
			
			// Oil and Seats
			
			oil_board = new MediumGraphicButton();
			oil_board.y = boardHeight;
			oil_board.x = 3*modify_new_route.width+store_board.width;
			this.addChild(oil_board);
			
			oljeFatMC = new OljeFat();
			oljeFatMC.x = 10;
			oljeFatMC.y = 40;
			oil_board.addChild(oljeFatMC);
			
			oilHover = new HoverRectangle();
			oilHover.x = 10;
			oilHover.y = 40;
			hoverDict[oilHover] = ["Current fuel price"];
			oil_board.addChild(oilHover);
			
			fuelPriceText = new TextField();
			fuelPriceText.y = 40;
			fuelPriceText.x = 53;
			fuelPriceText.text =  "$ " + String(fuel_constant+fuel_cosinus);
			fuelPriceText.setTextFormat(airplane_format);
			fuelPriceText.mouseEnabled = false;
			fuelPriceText.embedFonts = true;
			oil_board.addChild(fuelPriceText);
			

			// Date

			play_button = new PlayButton();
			play_button.x = 70;
			play_button.y = 45;
			play_button.buttonMode = true;
			play_button.visible = false;
			clock_bg.addChild(play_button);
			play_button.addEventListener(MouseEvent.CLICK, start_function);
			hoverDict[play_button] = ["Return to normal speed."];
			
			stop_button = new StopButton();
			stop_button.x = 40;
			stop_button.y = 45;
			stop_button.buttonMode = true;
			clock_bg.addChild(stop_button);
			stop_button.addEventListener(MouseEvent.CLICK, stop_function);
			hoverDict[stop_button] = ["Pause your game."];
			
			play_fast_button = new QuickPlay();
			play_fast_button.x = 70;
			play_fast_button.y = 45;
			play_fast_button.buttonMode = true;
			clock_bg.addChild(play_fast_button);
			play_fast_button.addEventListener(MouseEvent.CLICK, play_fast_function);
			hoverDict[play_fast_button] = ["Increase the speed of everything."];
			
			restart_button = new RestartButtonSmall();
			restart_button.x = 100;
			restart_button.y = 45;
			restart_button.buttonMode = true;
			clock_bg.addChild(restart_button);
			hoverDict[restart_button] = ["Restart your game."];
			restart_button.addEventListener(MouseEvent.CLICK, restart_function);

			dateNow = new Date();
			time_field = new TextField();
			time_field.x = 0;
			time_field.y = 5;
			time_field.width = clock_bg.width;
			time_field.text = "";
			time_field.mouseEnabled = false;
			time_field.embedFonts = true;
			time_field.setTextFormat(dateFormat);
			clock_bg.addChild(time_field);			

			this.addChild(event_field);

			// Zooming script (ZOOM CONTROLS: CTRL (ZOOM IN), SHIFT (ZOOM OUT) + MOUSECLICK)
			this.graphics.beginFill(0xB6DCF4);
			this.graphics.drawRect(0,0,boardWidth,boardHeight);
			this.graphics.endFill();
			spImage = new Sprite();
			spImage.cacheAsBitmap = true;
			this.addChild(spImage);
			boardMask = new Shape();
			boardMask.graphics.beginFill(0xDDDDDD);
			boardMask.graphics.drawRect(0,0,boardWidth,boardHeight-60);
			boardMask.graphics.endFill();
			boardMask.x = 0;
			boardMask.y = 60;
			this.addChild(boardMask);
			spImage.mask = boardMask;
			
			bg_image = new Image();
			bg_image.cacheAsBitmap = true;
			//mapbd = new BitmapData (mapMask.width, mapMask.height, true, 0);
			_collisionTest = new CollisionTest();
			
			mapMask = new MapMask();
			spImage.addChild(mapMask);
			mapMask.alpha = 0;
			
			//mapMask.attachBitmap(mapbd, this.getNextHighestDepth());
			
			//mapbd.draw (mapMask);
			
			spImage.addChild(bg_image);
			spImage.y = 70;
			minScale = boardWidth / bg_image.width;
			//mcIn = new InCursorClip();
			//mcOut = new OutCursorClip();
			//bg_image.addChild(mcIn);
			//bg_image.addChild(mcOut);
			bg_image.scaleX = minScale;
			bg_image.scaleY = minScale;
			bg_image.addChild(tempMovingLine);
			count_down_field = new TextField();
			count_down_field.width = 100;
			count_down_field.x = boardWidth * 0.5 - count_down_field.width * 0.5;
			count_down_field.y = 490;
			count_down_field.text = "100";
			count_down_field.visible = false;
			count_down_field.mouseEnabled = false;
			count_down_field.embedFonts = true;
			count_down_field.setTextFormat(bigRedDateFormat);
			addChild(count_down_field);
			
			zoomPlus = new ZoomPlus();
			zoomPlus.x = Main.boardWidth - 30;
			zoomPlus.y = 350;
			zoomPlus.alpha = 0.6;
			zoomPlus.buttonMode = true;
			hoverDict[zoomPlus] = ["Zoom in."];
			this.addChild(zoomPlus);
			zoomPlus.addEventListener(MouseEvent.CLICK, zoomInFunction);
			
			zoomMinus = new ZoomMinus();
			zoomMinus.x = Main.boardWidth - 30;
			zoomMinus.y = 450;
			zoomMinus.alpha = 0.6;
			zoomMinus.buttonMode = true;
			hoverDict[zoomMinus] = ["Zoom out."];
			this.addChild(zoomMinus);
			zoomMinus.addEventListener(MouseEvent.CLICK, zoomOutFunction);
			
			restartbox = new Hoverbox();
			restartbox.y = 350;
			restartbox.x = boardWidth * 0.5;
			restartbox.visible = false;
			stage.addChild(restartbox);
			
			restarttext = new TextField();
			restarttext.mouseEnabled = false;
			restarttext.embedFonts = true;
			restarttext.height = 70;
			restarttext.width = restartbox.width;
			restarttext.wordWrap = true;
			restarttext.text = "Are you sure you want to restart the game?";
			restarttext.setTextFormat(hoverformat);
			restartbox.addChild(restarttext);
			restarttext.x = - 115;
			restarttext.y = - 25;
			
			yesConfirm = new YesConfirm();
			restartbox.addChild(yesConfirm);
			yesConfirm.x = -40;
			yesConfirm.y = 10;
			yesConfirm.buttonMode = true;
			hoverDict[yesConfirm] = [""];
			
			noDeny = new NoDeny();
			restartbox.addChild(noDeny);
			noDeny.x = 40;
			noDeny.y = 10;
			noDeny.buttonMode = true;
			hoverDict[noDeny] = [""];
			
			finishTut = new Hoverbox();
			finishTut.visible = false;
			finishTut.x = boardWidth * 0.5;
			finishTut.y = 100;
			stage.addChild(finishTut);
			
			finishTutCheck = new YesConfirm();
			finishTut.addChild(finishTutCheck);
			finishTutCheck.y = 15;
			finishTutCheck.buttonMode = true;
			hoverDict[finishTutCheck] = [""];
			finishTutCheck.addEventListener(MouseEvent.CLICK, finishTutorial);
			
			finishTutText = new TextField();
			finishTutText.mouseEnabled = false;
			finishTutText.embedFonts = true;
			finishTutText.height = 70;
			finishTutText.width = finishTut.width;
			finishTutText.wordWrap = true;
			finishTutText.text = "Finish the tutorial.";
			finishTutText.setTextFormat(Main.hoverformatB);
			finishTutText.x = - finishTut.width * 0.5 + 40;
			finishTutText.y = - 30;
			finishTut.addChild(finishTutText);
			
			hoverbox = new Hoverbox();
			hoverbox.visible = false;
			if (tutorial == true)
			{
				hoverbox.x = boardWidth * 0.5;
			}
			
			else
			{
				hoverbox.x = 121;
			}
			hoverbox.y = 525;
			stage.addChild(hoverbox);
			
			hovertext = new TextField();
			hovertext.mouseEnabled = false;
			hovertext.embedFonts = true;
			hovertext.height = 70;
			hovertext.width = 204;
			hovertext.wordWrap = true;
			hovertext.text = "";
			hovertext.setTextFormat(hoverformat);
			hoverbox.addChild(hovertext);
			hovertext.x = -115;
			hovertext.y = -45;
			
			hoverprice = new TextField();
			hoverprice.mouseEnabled = false;
			hoverprice.embedFonts = true;
			hoverprice.height = 20;
			hoverprice.width = 200;
			hoverprice.wordWrap = true;
			hoverprice.text = "";
			hoverprice.setTextFormat(hoverformat1);
			hoverbox.addChildAt(hoverprice, 1);
			hoverprice.x = 40;
			hoverprice.y = -10;

			// Zooming event listeners
			spImage.addEventListener(MouseEvent.MOUSE_DOWN, startDragging);
			spImage.addEventListener(MouseEvent.CLICK, testfunction);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, testfunction1);
			stage.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
			//stage.addEventListener(Event.ENTER_FRAME, time);
			
			stage.addEventListener(MouseEvent.CLICK, mouseCoordinates);
			stage.addEventListener(MouseEvent.RIGHT_CLICK, passFunction);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveFunction);
			
			so = SharedObject.getLocal("progress", "/");			
						
			if (this.cont == "new")
			{
				clearProgress();
			}
			
			player = new Arrow(bg_image);
			bg_image.addChild(player);
			
			new Mail("Carter DuPont", "There you are", "Hi again. I hope you had a nice trip. Your next task is to create a route to France.", "Spam", false);
			
			moneyChange();
			
			/*trace(so.data.saved);
			if (so.data.saved == true)
			{
				trace("Initiating loading");
				trace(so.data.airportDict);
				loadProgress();
			}
			
			else
			{
				airportDict = new Dictionary();
				resetAirportDict();
				resetMissions();
			}*/
			
			// replaceD BY
			
			// Adding new airplane popups
			for (var ler:int = 0; ler < 5; ler ++)
			{
				var newPopUp = new PopUpNewPlane();
				eco_board.addChild(newPopUp);
				newPopUp.y = airplane_field.y;
				arrayOfStrings[arrayOfStrings.length] = newPopUp;
			}
			
			
			// Adding new seat popups
			for (var ver:int = 0; ver < 3; ver ++)
			{
				var newSeatPopUp = new PopUpNewSeat();
				player_board.addChild(newSeatPopUp);
				newSeatPopUp.y = maxPassengersText.y;
				arrayOfSeatStrings[arrayOfSeatStrings.length] = newSeatPopUp;
				//trace(arrayOfSeatStrings.length);
			}
			
			// Adding increased engine speed popups
			for (var ber:int = 0; ber < 3; ber ++)
			{
				var newEnginePopUp = new PopUpNewEngine();
				player_board.addChild(newEnginePopUp);
				newEnginePopUp.y = engineText.y;
				arrayOfEngineStrings[arrayOfEngineStrings.length] = newEnginePopUp;
				//trace(arrayOfSeatStrings.length);
			}
			
			// Adding new landing popup
			landingPopUp = new PopUpNewLanding();
			country_board.addChild(landingPopUp);
			landingPopUp.y = runwayField.y + 20;
			landingPopUp.x = runwayField.x - 10;
			
			// Adding airports through for-loop
			for (var k:Object in airportDict)
			{
				var value = airportDict[k];
				var key = k;
				if (airportDict[key]["appeared"] == true)
				{
					//startList.addItem({label:key, data:key});
					//sluttList.addItem({label:key, data:key});
					var airport:Airport = new Airport(key,airportDict[key]["cityname"],this);
					airport.koordinater(airportDict[key]["x"], airportDict[key]["y"]);
					collectedAirportArray[collectedAirportArray.length] = airport;
					collectedAirportDict[key] = airport;
					//airport.scaleY = minScale;
					//airport.scaleX = minScale;
					bg_image.addChild(airport);
					
					if (airportDict[key]["priority"] > 1 && airport.airportB.visible == false && airport.greenAirport.visible == false && airport.greenAirportB.visible == false && airport.blueAirport.visible == false && airport.blueAirportB.visible == false)
					{
						airport.visible = false;
					}
				}
			}
			
			//T ESTING			
			
			if (Main.tutorial == true)
			{
				var nMail = new Mail("Carter DuPont", "Welcome", "Hi. Nice to finally meet you. I'm your assistant, and would like to welcome you as our new manager. Remember to check your mail; I'll notify you when something is up, and others may try to reach you there aswell. Right now I need you to meet me in Germany. See you.", "Spam", false);
				hovertext.text = "Check your mail by clicking the mail icon in the upper left corner.";
				Main.TUTORIALTEXT = "Check your mail by clicking the mail icon in the upper left corner.";
				hovertext.setTextFormat(Main.hoverformat);
				mailIcon.highLight();
			}
			
			/*var newMission:Mission = new Mission();				
			newMission.declareVariables("Terrorist Cell", "random", "random", Main.airplanePrice * 1000, Main.organizations["Terrorist Cell"]["expires"], Main.organizations["Terrorist Cell"]["type"], Main.organizations["Terrorist Cell"]["relation"]);
			newMission.doMission();*/

			
		}
		// ---------------------------------------
		// Functions for GUI and zooming
		private function startDragging(mev:MouseEvent):void
		{
			spImage.startDrag(false);
		}

		private function stopDragging(mev:MouseEvent):void
		{
			spImage.stopDrag();
		}

		private function testfunction(evt:MouseEvent):void
		{
			if ((!evt.shiftKey)&&(!evt.ctrlKey))
			{
				return;
			}
			if ((evt.shiftKey)&&(evt.ctrlKey))
			{
				return;
			}
			
			var ieloop:Boolean = false;
			
			//(flightScale);

			externalCenter = new Point(spImage.mouseX,spImage.mouseY);
			internalCenter = new Point(bg_image.mouseX,bg_image.mouseY);

			if (evt.shiftKey)
			{
				ieloop = true;
				if (bg_image.scaleX > minScale)
				{
					bg_image.scaleX = scaleFactor * bg_image.scaleX;
					bg_image.scaleY = scaleFactor * bg_image.scaleY;
					
					flightScale = 1 / scaleFactor * flightScale;
					
					for (var ij:int = 0; ij < allCollectedArrays.length; ij++)
					{
						var cArray:Array = allCollectedArrays[ij];
						
						for (var ik:int = 0; ik < cArray.length; ik ++)
						{
							var cInstance:Object = cArray[ik];
							cInstance.scaleX = flightScale;
							cInstance.scaleY = flightScale;
						}
					}
				}
			}
			if (evt.ctrlKey)
			{
				ieloop = true;
				if (bg_image.scaleX * 1 / scaleFactor < maxScale)
				{
					bg_image.scaleX = Math.min(1/scaleFactor*bg_image.scaleX, maxScale);
					bg_image.scaleY = Math.min(1/scaleFactor*bg_image.scaleY, maxScale);
					
					flightScale = scaleFactor * flightScale;
				}
				
				for (var ijj:int = 0; ijj < allCollectedArrays.length; ijj++)
				{
					var cArrayc:Array = allCollectedArrays[ijj];
						
					for (var ikk:int = 0; ikk < cArrayc.length; ikk ++)
					{
						var cdInstance:Object = cArrayc[ikk];
						cdInstance.scaleX = flightScale;
						cdInstance.scaleY = flightScale;
					}
				}
			}
			
			if (ieloop == true)
			{
				player.scaleX = flightScale;
				player.scaleY = flightScale;

				mat = bg_image.transform.matrix.clone();
	
				MatrixTransformer.matchInternalPointWithExternal(mat,internalCenter,externalCenter);
	
				bg_image.transform.matrix = mat;
				
				bounds.width = spImage.width;
				bounds.height = spImage.height;
				bounds.x = 0;
				bounds.y = 70;
				
				for (var poo:int = 0; poo < collectedAirplaneArray.length; poo++)
				{
					collectedAirplaneArray[poo].scaleX = flightScale;
					collectedAirplaneArray[poo].scaleY = flightScale;
				}
				
				if (flightScale > 0.5)
				{
					for each(var airportItem in collectedAirportArray)
					{
						if (airportDict[airportItem.country]["priority"] > 1 && airportItem.airportB.visible == false && airportItem.greenAirport.visible == false && airportItem.greenAirportB.visible == false && airportItem.blueAirport.visible == false && airportItem.blueAirportB.visible == false)
						{
							airportItem.visible = false;
						}
					}
				}
				
				else
				{
					for each(var airport2Item in collectedAirportArray)
					{
						airport2Item.visible = true;
					}
				}
				
				//trace("----------------------");
				
				if (Number(flightScale.toFixed(1)) == 1)
				{
					//trace("Changing positions");
					bounds.x = 0;
					bounds.y = 60;
					bounds.height = 0;
					spImage.x = 0;
					spImage.y = 60;
					bg_image.x = 0;
					bg_image.y = 0;
				}
				
				/*trace("Bg_image: ", bg_image.x, bg_image.y);
				trace("Sp_image: ", spImage.x, spImage.y);
				trace("Bounds:", "x: ", bounds.x, "y: ",  bounds.y, "width: ", bounds.width, "height: ", bounds.height);
				trace("Flightscale: ", flightScale);*/
				
				for each (var lineI in lineArray)
				{
					lineI.zoomFunction();
				}
			}
		}
		
		private function zoomInFunction(evt:MouseEvent):void
		{
			/*externalCenter = new Point(spImage.mouseX,spImage.mouseY);
			internalCenter = new Point(bg_image.mouseX,bg_image.mouseY);*/
			
			var mPoint = new Point(Main.boardWidth * 0.5, Main.boardHeight * 0.5);
			
			externalCenter = spImage.globalToLocal(mPoint);
			internalCenter = bg_image.globalToLocal(mPoint);

			if (bg_image.scaleX * 1 / scaleFactor < maxScale)
			{
				bg_image.scaleX = Math.min(1/scaleFactor*bg_image.scaleX, maxScale);
				bg_image.scaleY = Math.min(1/scaleFactor*bg_image.scaleY, maxScale);
				
				flightScale = scaleFactor * flightScale;
				
				for (var il:int = 0; il < allCollectedArrays.length; il++)
				{
					var cArray:Array = allCollectedArrays[il];
					
					for (var ii:int = 0; ii < cArray.length; ii ++)
					{
						var cInstance:Object = cArray[ii];
						cInstance.scaleX = flightScale;
						cInstance.scaleY = flightScale;
					}
				}
				
				for (var polo:int = 0; polo < collectedAirplaneArray.length; polo++)
				{
					collectedAirplaneArray[polo].scaleX = flightScale;
					collectedAirplaneArray[polo].scaleY = flightScale;
				}
				
				player.scaleX = flightScale;
				player.scaleY = flightScale;
				
				mat = bg_image.transform.matrix.clone();

				MatrixTransformer.matchInternalPointWithExternal(mat,internalCenter,externalCenter);
		
				bg_image.transform.matrix = mat;
					
				bounds.width = bg_image.width - boardWidth;
				bounds.height = 70 + bg_image.height - boardHeight;
				bounds.x = - bounds.width * 0.5;
				bounds.y = 70 - bounds.height * 0.5;
					
				if (flightScale > 0.5)
				{
					for each(var airportItem in collectedAirportArray)
					{
						if (airportDict[airportItem.country]["priority"] > 1 && airportItem.airportB.visible == false && airportItem.greenAirport.visible == false && airportItem.greenAirportB.visible == false && airportItem.blueAirport.visible == false && airportItem.blueAirportB.visible == false)
						{
							airportItem.visible = false;
						}
					}
				}
					
				else
				{
					for each(var airport2Item in collectedAirportArray)
					{
						airport2Item.visible = true;
					}
				}
					
				//trace("----------------------");
				
				for each (var lineI in lineArray)
				{
					lineI.zoomFunction();
				}
			}
		}
		
		private function zoomOutFunction(evt:MouseEvent):void
		{
			var mPoint = new Point(Main.boardWidth * 0.5, Main.boardHeight * 0.5);
			
			externalCenter = spImage.globalToLocal(mPoint);
			internalCenter = bg_image.globalToLocal(mPoint);
			
			if (bg_image.scaleX > minScale)
			{
				bg_image.scaleX = scaleFactor * bg_image.scaleX;
				bg_image.scaleY = scaleFactor * bg_image.scaleY;
				
				flightScale = 1 / scaleFactor * flightScale;
				
				for (var pis:int = 0; pis < allCollectedArrays.length; pis++)
				{
					var cArray:Array = allCollectedArrays[pis];
					
					for (var sip:int = 0; sip < cArray.length; sip ++)
					{
						var cInstance:Object = cArray[sip];
						cInstance.scaleX = flightScale;
						cInstance.scaleY = flightScale;
					}
				}
				
				for (var popo:int = 0; popo < collectedAirplaneArray.length; popo++)
				{
					collectedAirplaneArray[popo].scaleX = flightScale;
					collectedAirplaneArray[popo].scaleY = flightScale;
				}
				
				player.scaleX = flightScale;
				player.scaleY = flightScale;
				
				mat = bg_image.transform.matrix.clone();
	
				MatrixTransformer.matchInternalPointWithExternal(mat,internalCenter,externalCenter);
	
				bg_image.transform.matrix = mat;
				
				bounds.width = bg_image.width - boardWidth;
				bounds.height = 70 + bg_image.height - boardHeight;
				bounds.x = - bounds.width * 0.5;
				bounds.y = 70 - bounds.height * 0.5;
				
				if (flightScale > 0.5)
				{
					for each(var airportItem in collectedAirportArray)
					{
						if (airportDict[airportItem.country]["priority"] > 1 && airportItem.airportB.visible == false && airportItem.greenAirport.visible == false && airportItem.greenAirportB.visible == false && airportItem.blueAirport.visible == false && airportItem.blueAirportB.visible == false)
						{
							airportItem.visible = false;
						}
					}
				}
				
				else
				{
					for each(var airport2Item in collectedAirportArray)
					{
						airport2Item.visible = true;
					}
				}
				
				//trace("----------------------");
				
				if (Number(flightScale.toFixed(1)) == 1)
				{
					//trace("Changing positions");
					bounds.x = 0;
					bounds.y = 60;
					bounds.height = 0;
					spImage.x = 0;
					spImage.y = 60;
					bg_image.x = 0;
					bg_image.y = 0;
				}
				
				/*trace("Bg_image: ", bg_image.x, bg_image.y);
				trace("Sp_image: ", spImage.x, spImage.y);
				trace("Bounds:", "x: ", bounds.x, "y: ",  bounds.y, "width: ", bounds.width, "height: ", bounds.height);
				trace("Flightscale: ", flightScale);*/
				
				for each (var LineI in lineArray)
				{
					LineI.zoomFunction();
				}
			}				
		}
		
		private function testfunction1(evt:MouseEvent):void
		{
			//trace(flightScale);

			externalCenter = new Point(spImage.mouseX,spImage.mouseY);
			internalCenter = new Point(bg_image.mouseX,bg_image.mouseY);
			
			var ilooP:Boolean = false;

			if (evt.delta < 0)
			{
				if (bg_image.scaleX > minScale)
				{
					ilooP = true;
					bg_image.scaleX = scaleFactor * bg_image.scaleX;
					bg_image.scaleY = scaleFactor * bg_image.scaleY;

					flightScale = 1 / scaleFactor * flightScale;
				}
			}
			else
			{
				if (bg_image.scaleX * 1 / scaleFactor < maxScale)
				{
					ilooP = true;
					bg_image.scaleX = Math.min(1/scaleFactor*bg_image.scaleX, maxScale);
					bg_image.scaleY = Math.min(1/scaleFactor*bg_image.scaleY, maxScale);
					
					flightScale = scaleFactor * flightScale;
				}
			}
			
			if (ilooP == true)
			{
				for (var fis:int = 0; fis < allCollectedArrays.length; fis++)
				{
					var cArray:Array = allCollectedArrays[fis];
					
					for (var sif:int = 0; sif < cArray.length; sif ++)
					{
						var cInstance:Object = cArray[sif];
						cInstance.scaleX = flightScale;
						cInstance.scaleY = flightScale;
					}
				}
				
				for (var olo:int = 0; olo < collectedAirplaneArray.length; olo++)
				{
					collectedAirplaneArray[olo].scaleX = flightScale;
					collectedAirplaneArray[olo].scaleY = flightScale;
				}
				
				player.scaleX = flightScale;
				player.scaleY = flightScale;
	
				mat = bg_image.transform.matrix.clone();
	
				MatrixTransformer.matchInternalPointWithExternal(mat,internalCenter,externalCenter);
	
				bg_image.transform.matrix = mat;
				
				
							
				bounds.width = bg_image.width - boardWidth;
				bounds.height = 70 + bg_image.height - boardHeight;
				bounds.x = - bounds.width * 0.5;
				bounds.y = 70 - bounds.height * 0.5;
				
				//trace("----------------------");
				
				if (Number(flightScale.toFixed(1)) == 1)
				{
					//trace("Changing positions");
					bounds.x = 0;
					bounds.y = 60;
					bounds.height = 0;
					spImage.x = 0;
					spImage.y = 60;
					bg_image.x = 0;
					bg_image.y = 0;
				}
				
				/*trace("Bg_image: ", bg_image.x, bg_image.y);
				trace("Sp_image: ", spImage.x, spImage.y);
				trace("Bounds:", "x: ", bounds.x, "y: ",  bounds.y, "width: ", bounds.width, "height: ", bounds.height);
				trace("Flightscale: ", flightScale);*/
				
				if (flightScale > 0.5)
				{
					for each(var airport3Item in collectedAirportArray)
					{
						if (airportDict[airport3Item.country]["priority"] > 1 && airport3Item.airportB.visible == false && airport3Item.greenAirport.visible == false && airport3Item.greenAirportB.visible == false && airport3Item.blueAirport.visible == false && airport3Item.blueAirportB.visible == false)
						{
							airport3Item.visible = false;
						}
					}
				}
				
				else
				{
					for each(var airport4Item in collectedAirportArray)
					{
						airport4Item.visible = true;
					}
				}
				
				for each (var lineI in lineArray)
				{
					lineI.zoomFunction();
				}
			}
		}


		private function keyHandlerUp(ke:KeyboardEvent):void
		{
			if (Arrow.Selected == true)
			{
				if (ke.keyCode == Keyboard.LEFT)
				{
					moveLeft = false;
					if (player.settled == true)
					{
						Main.readyToMove = true;
					}
				} 
				
				if (ke.keyCode == Keyboard.RIGHT)
				{
					moveRight = false;
					if (player.settled == true)
					{
						Main.readyToMove = true;
					}
				} 
				
				if (ke.keyCode == Keyboard.UP)
				{
					moveUp = false;
					if (player.settled == true)
					{
						Main.readyToMove = true;
					}
				} 
				
				if (ke.keyCode == Keyboard.DOWN)
				{
					moveDown = false;
					if (player.settled == true)
					{
						Main.readyToMove = true;
					}
				}
			}
		}
		
		private function keyHandlerDown(ke:KeyboardEvent):void
		{
			if (Arrow.Selected == true && Main.readyToMove == true)
			{
				if (ke.keyCode == Keyboard.LEFT)
				{
					moveLeft = true;
					moveRight = false;
				} 
				
				if (ke.keyCode == Keyboard.RIGHT)
				{
					moveRight = true;
					moveLeft = false;
				} 
				
				if (ke.keyCode == Keyboard.UP)
				{
					moveUp = true;
					moveDown = false;
				} 
				
				if (ke.keyCode == Keyboard.DOWN)
				{
					moveDown = true;
					moveUp = false;
				}
			}
		}

		// Function for creating new Route
		private function new_route(evt:MouseEvent):void
		{
			if (Main.tutorial == true && Main.tutorialStep == 9 && Airport.currentSelect.country == "Germany")
			{
				Main.tutorialStep = 10;
				Main.hovertext.text = Main.CREATENEWROUTEHOVERTEXT;
				yesCheck.highLight()
				Main.collectedAirportDict["France"].highLight();
				Main.TUTORIALTEXT = Main.CREATENEWROUTEHOVERTEXT;
				Main.hovertext.setTextFormat(Main.hoverformat);
			}
			
			hoverbox.x = boardWidth * 0.5;
			hoverbox.visible = true;
			hovertext.visible = true;
			hovertext.text = CREATENEWROUTEHOVERTEXT;
			hovertext.setTextFormat(hoverformat);
			delete_button.visible = false;
			modify_new_route.visible = true;
			Airport.ROUTING = true;
			Airport.DELETING = false;
			
			Airport.return_ROUTE = new Array();
			
			Airport.ROUTINGFROM = currentLocation;
			startX = airportDict[currentLocation]["x"];
			startY = airportDict[currentLocation]["y"];
			Airport.return_ROUTE[Airport.return_ROUTE.length] = [airportDict[currentLocation]["x"],airportDict[currentLocation]["y"],currentLocation];
			
			if (airportDict[currentLocation]["terminal"] == true)
			{
				Airport.myShape = new Shape();
				Airport.myShape.graphics.lineStyle(2, 0x33CC00, .35);
				Airport.myShape.graphics.moveTo(airportDict[currentLocation]["x"],airportDict[currentLocation]["y"]);
				bg_image.addChildAt(Airport.myShape,1);
			}
		}

		// Function for confirming the route
		public function confirm_route(evt:MouseEvent):void
		{
			Airport.ROUTING = false;
			Airport.ROUTINGFROM = false;
			create_new_route.visible = true;
			modify_new_route.visible = false;
			
			function checkRoute(route):Array
			{
				var a:Array = new Array();
				
				for (var ii:int = 0; ii < route.length; ii++)
				{
					a[a.length] = route[ii][2];
				}
				
				a.sort();
				var i:int = 0;
				while(i < a.length) 
				{
					while(i < a.length+1 && a[i] == a[i+1]) 
					{
						a.splice(i, 1);
					}
					i++;
				}
				//trace(a);
				if(a.length > 1)
				{
					for (var CountR:int = 0; CountR < Main.lineArray.length; CountR ++)
					{
						for (var CountS:int = 0; CountS < a.length - 1; CountS++)
						{
							if (Main.lineArray[CountR].startN ==  a[CountS] && Main.lineArray[CountR].finishN ==  a[CountS+1])
							{
								a.splice(CountS, 1);
							}
						}
					}
				}
				
				return a
			}

			if(checkRoute(Airport.return_ROUTE).length > 1)
			{
				Main.routeIndex += 1;
				if (Main.tutorial == true && Main.tutorialStep == 10)
				{
					yesCheck.stopAlpha();
					buyplane.highLight();
					Main.collectedAirportDict["France"].stopAlpha();
					Main.collectedAirportDict["Germany"].stopAlpha();
					Main.tutorialStep = 11;
					Main.tutorialLine = Main.routeIndex;
					Main.hovertext.text = "Well done. Now buy five planes in Germany to operate on the new route.";
					Main.create_new_route.stopAlpha();
					Main.TUTORIALTEXT = "Well done. Now buy five planes in Germany to operate on the new route.";
					Main.hovertext.setTextFormat(Main.hoverformat);
				}
				
				else if (Main.tutorial == true && Main.tutorialStep == 17 && checkRoute(Airport.return_ROUTE).length == 3)
				{
					if (checkRoute(Airport.return_ROUTE)[0] == "Denmark" && checkRoute(Airport.return_ROUTE)[1] == "Poland" && checkRoute(Airport.return_ROUTE)[2] == "Ukraine")
					{
						Main.tutorialStep = 18;
						Main.create_new_route.stopAlpha();
						Main.tutorialLine2 = Main.routeIndex;
						Main.hovertext.text = "Well done. You will have to transfer some of the planes you bought for the first route to this one. Click on that route.";
						Main.TUTORIALTEXT = "Well done. You will have to transfer some of the planes you bought for the first route to this one. Click on that route.";
						Main.hovertext.setTextFormat(Main.hoverformat);
					}
				}
				
				trace(2463, "main");
				trace(checkRoute(Airport.return_ROUTE).length);
				trace(checkRoute(Airport.return_ROUTE));
				
				if (Airport.return_ROUTE.length == 2)
				{
					var route:Route = new Route(Airport.return_ROUTE,this,price_show.text,frequency_show.text, Main.routeIndex);
					Main.parentRouteDict[Main.routeIndex] = {"lines": new Array(route), "numPlanes": 0, "deficit": 1};
					trace(2384, Main.parentRouteDict[Main.routeIndex]["lines"], Main.parentRouteDict[Main.routeIndex]["lines"].length);
				}
				
				else
				{
					Main.parentRouteDict[Main.routeIndex] = {"lines": new Array(), "numPlanes": 0, "deficit": 1};
					for (var i:int = 0; i < Airport.return_ROUTE.length - 1; i++)
					{
						var route2:Route = new Route(Airport.return_ROUTE.slice(i, i+2),this,price_show.text,frequency_show.text, Main.routeIndex);
						Main.parentRouteDict[Main.routeIndex]["lines"][Main.parentRouteDict[Main.routeIndex]["lines"].length] = route2;
					}
					trace(2395, Main.parentRouteDict[Main.routeIndex]["lines"], Main.parentRouteDict[Main.routeIndex]["lines"]);
				}
				
				Airport.myShape.graphics.clear();
				tempMovingLine.graphics.clear();
			}
			
			Airport.return_ROUTE = new Array();
		}
		
		// Function for canceling the route
		public function cancel_route(evt:MouseEvent):void
		{
			modify_new_route.visible = false;
			Airport.return_ROUTE = new Array();
			Airport.ROUTING = false;
			Airport.ROUTINGFROM = false;
			
			if (Airport.return_ROUTE.length > 0)
			{
				Airport.myShape.graphics.clear();
			}
			tempMovingLine.graphics.clear();
		}

		// Slider Event Functions (Modify New Route)
		private function changeFrequencyShow(evt:SliderEvent):void
		{
			if (evt.target.value == 1)
			{
				frequency_show.text = "Low";
				frequency_show.setTextFormat(lowFormat);
			}
			else if (evt.target.value == 2)
			{
				frequency_show.text = "Medium";
				frequency_show.setTextFormat(mediumFormat);
			}
			else if (evt.target.value == 3)
			{
				frequency_show.text = "High";
				frequency_show.setTextFormat(highFormat);
			}
		}
		private function changePriceShow(evt:SliderEvent):void
		{
			trace("Main, 2432");
			trace(price_show.text);
			trace(evt.target.value);
			price_show.text = String(evt.target.value+99);
			
			if (evt.target.value+99 < 233)
			{
				price_show.setTextFormat(lowFormat);
			}
			
			else if (evt.target.value+99 >= 233 && evt.target.value+99 < 370)
			{
				price_show.setTextFormat(mediumFormat);
			}
			
			else
			{
				price_show.setTextFormat(highFormat);
			}
		}
		
		// R change sliders..
		
		private function RchangeFrequencyShow(evt:SliderEvent):void
		{
			if (evt.target.value == 1)
			{
				Rfrequency_show.text = "Low";
				Rfrequency_show.setTextFormat(lowFormat);
			}
			else if (evt.target.value == 2)
			{
				Rfrequency_show.text = "Medium";
				Rfrequency_show.setTextFormat(mediumFormat);
			}
			else if (evt.target.value == 3)
			{
				Rfrequency_show.text = "High";
				Rfrequency_show.setTextFormat(highFormat);
			}
			
			Line.selectedRoute.routeParent.flight_interval = Route.frequency_dict[Rfrequency_show.text][0];
			Line.selectedRoute.routeParent.routeTimer.delay = Line.selectedRoute.routeParent.flight_interval;
			
			trace(Line.selectedRoute.routeParent.flight_interval);
			
			//Route.frequency_dict[Rfrequency_show.text];
		}
		private function RchangePriceShow(evt:SliderEvent):void
		{		
			Rprice_show.text = String(evt.target.value+99);
			
			if (evt.target.value+99 < 233)
			{
				Rprice_show.setTextFormat(lowFormat);
			}
			
			else if (evt.target.value+99 >= 233 && evt.target.value+99 < 370)
			{
				Rprice_show.setTextFormat(mediumFormat);
			}
			
			else
			{
				Rprice_show.setTextFormat(highFormat);
			}
			
			
			Line.selectedRoute.routeParent.ticket_price = Number(Rprice_show.text);
		}

		// !! Dette kan fjernes etterhvert !!
		private function confirmHover(evt:MouseEvent):void
		{
			evt.target.alpha = 1.0;
			evt.target.addEventListener(MouseEvent.MOUSE_OUT, confirmOut);
		}

		private function confirmOut(evt:MouseEvent):void
		{
			evt.target.alpha = 0.8;
		}
		// !!!!!!!

		// Function for getting coordinates from mouseclick
		
		private function passFunction(event:MouseEvent):void
		{
			
		}
		
		private function showNextRoute(evt:MouseEvent):void
		{
			trace("Showing next route. Current line", Line.selectedRouteIndex);
			
			var lLength:int = Line.selectedLines.length;
			
			if (Line.selectedRouteIndex < lLength - 1)
			{
				trace("Jumping to next");
				Line.selectedRouteIndex += 1;
				Line.selectedLines[Line.selectedRouteIndex].showInfo();
			}
			else
			{
				trace("Restarting");
				Line.selectedRouteIndex = 0;
				Line.selectedLines[0].showInfo();
			}
		}
		
		private function mouseCoordinates(event: MouseEvent):void
		{
			stage.focus=stage;
			var tLoop:Boolean = false;
			var _point:Point = localToGlobal(new Point(mouseX,mouseY));
			
			var reAdd:Array = new Array();
			
			//trace(event.target);
			if (event.target == "[object Sprite]")
			{
				if (Main.tutorial == true && Main.tutorialStep == 14)
				{
					//Main.finishTut.visible = true;
					Main.tutorialStep = 15;
					var mMail = new Mail("Carter DuPont", "Well done.", "We have decided to expand our airline company by setting up a route from Denmark to Ukraine through Poland. You will be responsible for this.", "Spam", false);
					Main.hovertext.text = "Good job. By changing the slider values, you can change the prices and frequencies dynamically. You have recieved a mail from Carter DuPont. Go read it.";
					Main.TUTORIALTEXT = "Good job. By changing the slider values, you can change the prices and frequencies dynamically. You have recieved a mail from Carter DuPont. Go read it.";;
					Main.hovertext.setTextFormat(Main.hoverformat);
					mailIcon.highLight();
					//Main.tutorial = false;
				}
				
				/*else if (Main.tutorial == true && Main.tutorialStep == 16)
				{
					//Main.finishTut.visible = true;
					Main.tutorialStep = 17;
					Main.hovertext.text = "";
					Main.TUTORIALTEXT = "Good. You have recieved a mail from Carter DuPont. Go read it";
					Main.hovertext.setTextFormat(Main.hoverformat);
					mailIcon.highLight();
					//Main.tutorial = false;
				}*/
				
				for each (var lined in lineArray)
				{
					trace("countingline");
					if(lined.hitTestPoint(_point.x,_point.y,true))
					{
						trace("found line");
						//Line.selectedLines[Line.selectedLines.length] = sublined[2];
						reAdd[reAdd.length] = lined;
						tLoop = true;
					}
				}
				
				if (tLoop == true)
				{
					Line.selectedLines = reAdd;
				}
				
				if (Line.selectedLines.length > 0)
				{
					if (Line.selectedLines.length > 1)
					{
						nextRoute.visible = true;
					}
					else
					{
						nextRoute.visible = false;
					}
					Line.selectedLines[0].showInfo();
				}
			}
			
			
			
			//trace("Lengde på linjevalgt: ",  Line.selectedLines.length);

			if (event.target == "[object Image]")
			{
				/*if (SCALED == true)
				{
					TweenNano.to(bg_image, 1, {scaleX: 1, scaleY: 1, x:0, y:0});
7					
					for each(var airportInstace in collectedAirportArray)
					{
						TweenLite.to(airportInstace, 1, {scaleX: 1, scaleY: 1});
					}
				}*/
				
				/*TweenNano.to(bg_image, 2, {scaleX: 1, scaleY: 1, x:0, y:0});
				Main.flightScale = 1;
				
				Main.player.scaleX = Main.flightScale;
				Main.player.scaleY = Main.flightScale;
				
				
				for each (var instance3:Object in Main.collectedAirportArray)
				{
					instance3.width = 15;
					instance3.height = 15;
					TweenLite.to(instance3, 2, {scaleX: 1, scaleY: 1});
					
					if (airportDict[instance3.country]["priority"] > 1 && airport.airportB.visible == false && airport.greenAirport.visible == false && airport.greenAirportB.visible == false && airport.blueAirport.visible == false && airport.blueAirportB.visible == false)
					{
						instance3.visible = false;
					}
					
					//instance3.visible = true;
				}
				*/
				
				// these are the x and y relative to the object
				var localMouseX:Number = bg_image.mouseX;
				var localMouseY:Number = bg_image.mouseY;
				trace("Local coordinates: ", localMouseX, localMouseY);
	
				// these are the x and y relative to the whole stage
				var stageMouseX:Number = event.stageX;
				var stageMouseY:Number = event.stageY;
				trace("Global coordinates: ", stageMouseX, stageMouseY);
			}			
			
			if (event.target != "[object Arrow]")
			{
				player.stopAlpha();
			}
		}
		
		private function mouseMoveFunction(evt:MouseEvent):void
		{
			if (evt.stageX < 100 && evt.stageY < Main.boardHeight && evt.stageY > 60 && Airport.ROUTINGFROM != false)
			{
				Main.dragRight = true;
			}
			else
			{
				Main.dragRight = false;
			}
			if (evt.stageX > boardWidth - 100 && evt.stageY < Main.boardHeight && evt.stageY > 60 && Airport.ROUTINGFROM != false)
			{
				Main.dragLeft = true;
			}
			else
			{
				Main.dragLeft = false;
			}
			if (evt.stageY < 160 && evt.stageY > 60 && Airport.ROUTINGFROM != false)
			{
				Main.dragDown = true;
			}
			else
			{
				Main.dragDown = false;
			}
			if (evt.stageY > Main.boardHeight - 113 && evt.stageY < Main.boardHeight && Airport.ROUTINGFROM != false)
			{
				Main.dragUp = true;
			}
			else
			{
				Main.dragUp = false;
			}
			
			if (evt.stageX > 121 && evt.stageX < boardWidth - 121 && Airport.ROUTING == false && Main.tutorial == false)
			{
				hoverbox.x = evt.stageX;
			}
			
			if (Main.hoverVis == true && (evt.stageY > boardHeight || (Airport.hover[0] != 0 && Airport.hover[1] != 0) || Airport.ROUTING == true || Main.tutorial == true))
			{
				//trace("Gjør synlig");
				hoverbox.visible = true;
			}
			else
			{
				//trace("Gjør usynlig");
				hoverbox.visible = false;
			}
			
			if (Airport.ROUTING == true && Airport.ROUTINGFROM != false)
			{
				tempMovingLine.graphics.clear();
				tempMovingLine.graphics.lineStyle(2,0x33CC00);
        		tempMovingLine.graphics.moveTo(airportDict[Airport.ROUTINGFROM]["x"],airportDict[Airport.ROUTINGFROM]["y"]);
				
				if (Airport.hover[0] == 0 && Airport.hover[1] == 0)
				{
					if (evt.stageY < boardHeight && evt.stageY > 60)
					{
						tempMovingLine.graphics.lineTo(bg_image.mouseX,bg_image.mouseY);
					}
				}
				
				else
				{
					tempMovingLine.graphics.lineTo(Airport.hover[0],Airport.hover[1]);
				}
			}
			
			evt.updateAfterEvent();
		}
		
		private function buyplaneFunction(evt:MouseEvent):void
		{	
			if (Main.tutorial == true && Main.tutorialStep == 11)
			{
				Main.tutorialPlaneCounter += 1;
				
				if (Main.tutorialPlaneCounter <= 5)
				{
					interFace2.play();
					
					var new_airPlanee = new Airplane(bg_image, airportDict[currentLocation]["x"], airportDict[currentLocation]["y"], true,false, false, 0, 0, false, 0, currentLocation);
					bg_image.addChild(new_airPlanee);
					collectedAirplaneArray[Main.collectedAirplaneArray.length] = new_airPlanee;
					
					arrayOfStrings[0].showText();
					arrayOfStrings.push(arrayOfStrings.shift());
				}
				else
				{
					Main.tutorialStep = 12;
					Main.collectedAirportDict["Germany"].stopAlpha();
					Main.buyplane.stopAlpha();
					Main.hovertext.text = "Your route is losing money. You'll have to advertise for it. Select your player.";
					player.highLight();
					Main.TUTORIALTEXT = "Your route is losing money. You'll have to advertise for it. Select your player.";
					Main.hovertext.setTextFormat(Main.hoverformat);
				}
			}
		
			if (Number(cash_field.text) >= airplanePrice)
			{
				interFace2.play();
				cash_field.text = String(Math.round(Number(cash_field.text) - airplanePrice));
				cash_field.setTextFormat(cash_format);
				airplanePrice = Math.round(airplanePrice * priceMultiplier);
				hoverDict[buyplane][1] = airplanePrice;
				buyplane.price = airplanePrice;
				buyPlaneGrey.price = airplanePrice;
				
				hoverprice.text = "$ " + String(hoverDict[buyplane][1]);
				hoverprice.setTextFormat(hoverformat1);
				hoverprice.visible = true;
				
				var new_airPlane = new Airplane(bg_image, airportDict[currentLocation]["x"], airportDict[currentLocation]["y"], true,false, false, 0, 0, false, 0, currentLocation);
				bg_image.addChild(new_airPlane);
				collectedAirplaneArray[Main.collectedAirplaneArray.length] = new_airPlane;
				
				arrayOfStrings[0].showText();
				arrayOfStrings.push(arrayOfStrings.shift());
				
				moneyChange();
			}
			
			else
			{
				reject1.play();
			}
			buyplane.completed = true;
			
			Airport.ROUTING = false;
			Airport.DELETING = false;
			Airport.return_ROUTE = new Array();
		
			modify_new_route.visible = false;
		}
		
		private function buymarketingFunction(evt:MouseEvent):void
		{
			if (Main.tutorial == true && airportDict[player.playerLocation]["reputation"] < 0.9)
			{
				interFace2.play();
				Main.tutorialStep = 14;
				Main.hovertext.text = "Good. You could also try to experiment with the prices and flight frequency in order to increase your earnings. Click on the route you created.";
				Main.buymarketing.stopAlpha();
				Main.TUTORIALTEXT = "Good. You could also try to experiment with the prices and flight frequency in order to increase your earnings. Click on the route you created.";
				Main.hovertext.setTextFormat(Main.hoverformat);
				var greenDot = new Greenspot(player.playerLocation);
				airportDict[player.playerLocation]["reputation"] += 0.1;
				greenDot.x = airportDict[player.playerLocation]["x"];
				greenDot.y = airportDict[player.playerLocation]["y"];
				bg_image.addChildAt(greenDot, 1);
				influenceBar.x = Math.min(airportDict[player.playerLocation]["reputation"]*(modify_new_route.width/2+30), modify_new_route.width/2+30);
				return;
			}
			
			if (Number(cash_field.text) >= marketingPrice * airportDict[player.playerLocation]["GDP"] * airportDict[player.playerLocation]["reputation"] && airportDict[player.playerLocation]["reputation"] < 0.9)
			{
				interFace2.play();
				buymarketing.completed = true;
				cash_field.text = String(Math.round(Number(cash_field.text) - (marketingPrice * airportDict[player.playerLocation]["GDP"] * airportDict[player.playerLocation]["reputation"])));
				cash_field.setTextFormat(cash_format);
				var greenDot2 = new Greenspot(player.playerLocation);
				airportDict[player.playerLocation]["reputation"] += 0.1;
				Main.hoverDict[Main.buymarketing][1] = Main.marketingPrice * Main.airportDict[Main.player.playerLocation]["GDP"] * Main.airportDict[Main.player.playerLocation]["reputation"];
				Main.hoverDict[Main.buymarketing][1] = int(Main.hoverDict[Main.buymarketing][1]);
				buymarketing.price = Main.hoverDict[Main.buymarketing][1];
				buyMarketingGrey.price = buymarketing.price;
				hoverprice.text = "$ " + String(hoverDict[buymarketing][1]);
				hoverprice.setTextFormat(hoverformat1);
				hoverprice.visible = true;
				greenDot2.x = airportDict[player.playerLocation]["x"];
				greenDot2.y = airportDict[player.playerLocation]["y"];
				bg_image.addChildAt(greenDot2, 1);
				influenceBar.x = Math.min(airportDict[player.playerLocation]["reputation"]*(modify_new_route.width/2+30), modify_new_route.width/2+30);
				moneyChange();
			}
			
			else
			{
				reject1.play();
			}
			
			Airport.ROUTING = false;
			Airport.DELETING = false;
			Airport.return_ROUTE = new Array();
				
			modify_new_route.visible = false;
		}
		
		private function buylandingFunction(evt:MouseEvent):void
		{			
			if (Number(cash_field.text) >= landingPrice)
			{
				interFace2.play();
				buylanding.completed = true;
				cash_field.text = String(Math.round(Number(cash_field.text) - landingPrice));
				cash_field.setTextFormat(cash_format);
				landingPrice = Math.round(landingPrice * priceMultiplier);
				hoverDict[buylanding][1] = landingPrice;
				buylanding.price = landingPrice;
				buyLandingGrey.price = buylanding.price;
				airportDict[currentLocation]["runways"] += 1;
				var yellowDot = new Yellowspot(currentLocation);
				yellowDot.x = airportDict[currentLocation]["x"];
				yellowDot.y = airportDict[currentLocation]["y"];
				bg_image.addChildAt(yellowDot, 1);
				
				if (airportDict[currentLocation]["runways"] > airportDict[currentLocation]["landingApproachQueue"].length && airportDict[currentLocation]["landingQueue"].length > 0)
				{
					airportDict[currentLocation]["landingQueue"][0].Flight(airportDict[currentLocation]["landingQueue"][0].x, airportDict[currentLocation]["landingQueue"][0].y, airportDict[currentLocation]["landingQueue"][0].destination_x, airportDict[currentLocation]["landingQueue"][0].destination_y, airportDict[currentLocation]["landingQueue"][0].currentLocation, airportDict[currentLocation]["landingQueue"][0].budget, airportDict[currentLocation]["landingQueue"][0].passengers, true, airportDict[currentLocation]["landingQueue"][0].carryPlayer);
					airportDict[currentLocation]["landingQueue"][0].circleMovement = false;
					airportDict[currentLocation]["landingQueue"][0].landingQueue = false;
					airportDict[currentLocation]["landingApproachQueue"][airportDict[currentLocation]["landingApproachQueue"].length] = airportDict[currentLocation]["landingQueue"][0];
					airportDict[currentLocation]["landingQueue"][0].landingApproachQueue = true;
					airportDict[currentLocation]["landingQueue"].splice(0, 1);
				}
				landingPopUp.showText();
				moneyChange();
			}
			
			else
			{
				reject1.play();
			}
			
			Airport.ROUTING = false;
			Airport.DELETING = false;
			Airport.return_ROUTE = new Array();
	
			runwayField.text = String(Main.airportDict[currentLocation]["runways"]);
			runwayField.setTextFormat(Main.cash_format);
				
			modify_new_route.visible = false;
		}
		
		private function buyseatFunction(evt:MouseEvent):void
		{
			
			if (Number(cash_field.text) >= seatPrice)
			{
				interFace2.play();
				cash_field.text = String(Math.round(Number(cash_field.text)-seatPrice));
				cash_field.setTextFormat(cash_format);
				planeCapacity += 30;
				maxPassengersText.text = String(planeCapacity);
				maxPassengersText.setTextFormat(cash_format);
				seatPrice = Math.round(seatPrice * priceMultiplier);
				hoverDict[buyseat][1] = seatPrice;
				hoverprice.text = "$ " + String(hoverDict[buyseat][1]);
				hoverprice.setTextFormat(hoverformat1);
				hoverprice.visible = true;
				buyseat.price = seatPrice;
				buySeatGrey.price = seatPrice;
				
				arrayOfSeatStrings[0].showText();
				arrayOfSeatStrings.push(arrayOfSeatStrings.shift());
				moneyChange();
			}
			
			else
			{
				reject1.play();
			}
			buyseat.completed = true;
			
			Airport.ROUTING = false;
			Airport.DELETING = false;
			Airport.return_ROUTE = new Array();
				
			modify_new_route.visible = false;
		}
		
		private function removeTerminalFunction(evt:MouseEvent):void
		{
			if (airportDict[currentLocation]["terminal"] == true)
			{
				interFace2.play();
				cash_field.text = String(Math.round(Number(cash_field.text) + terminalprice * Main.airportDict[Main.currentLocation]["GDP"]));
				cash_field.setTextFormat(cash_format);
				
				airportDict[currentLocation]["terminal"] = false;
				
				Airport.ROUTING = false;
				Airport.return_ROUTE = new Array();
					
				modify_new_route.visible = false;
				
				for each (var airportEks in collectedAirportArray)
				{
					if (airportEks.country == currentLocation)
					{
						airportEks.blueAirportB.visible = false;
						airportEks.blueAirport.visible = false;
						airportEks.airportB.visible = true;
					}
				}
				
				buyTerminalButton.visible = false;
				
				store_board.visible = true;
				country_board.visible = true;
				route_board.visible = false;
				modify_route.visible = false;
				player_board.visible = false;
				
				buyplane.visible = true;
				removeterminal.visible = true;
				//buymarketing.visible = true;
				buylanding.visible = true;
				//buyseat.visible = true;
				create_new_route.visible = true;
				
				buyAntiAir.visible = false;
				
				for each (var airportEksd in collectedAirportArray)
				{
					if (airportEksd.country == currentLocation)
					{
						airportEksd.blueAirport.visible = false;
					}
				}
				
				buyTerminalButton.visible = true;
				
				store_board.visible = false;
				country_board.visible = false;
				route_board.visible = false;
				modify_route.visible = false;
				player_board.visible = false;
				
				airportDict[currentLocation]["reputation"] = 0.1;
				airportDict[currentLocation]["bluereputation"] = 0.1;
				
				for (var sr:int = 0; sr < Main.collectedRouteArray.length; sr++)
				{
					var r = Main.collectedRouteArray[sr];
					if (r.routePoints[0][2] == currentLocation || r.routePoints[1][2] == currentLocation)
					{
						return_DELETE = [r.routePoints[0][2], r.routePoints[1][2]];
						
						Main.collectedRouteArray.splice(Main.collectedRouteArray.indexOf(r), 1)
						Main.parentRouteDict[r.parentRoute]["lines"].splice(Main.parentRouteDict[r.parentRoute]["lines"].indexOf(r), 1);
						
						Main.airportDict[r.routePoints[0][2]]["bluereputation"] = Math.max(0.1, Main.airportDict[r.routePoints[0][2]] -  0.1);
						r.routeTimer.stop();
						if (Main.parentRouteDict[r.parentRoute]["lines"].length == 0)
						{
							for each (var a in collectedAirplaneArray)
							{
								if (a.currentRoute == r.parentRoute)
								{
									a.currentRoute = false;
								}
							}
						}
						Main.airportDict[r.routePoints[0][2]]["routes"] -= 1;
						if (Main.airportDict[r.routePoints[0][2]]["routes"] == 0)
						{
							Main.Active_array.splice(Main.Active_array.indexOf(r.routePoints[0][2]), 1);
							Main.airportDict[r.routePoints[0][2]]["active"] = false;
							if (Main.airportDict[r.routePoints[0][2]]["incomingroutes"] == 0)
							{
								Main.airportDict[r.routePoints[0][2]]["priority"] = Main.airportDict[r.routePoints[0][2]]["startpriority"];
							}
						}
						Main.airportDict[r.routePoints[0][2]]["deficit"] = 1;
						bg_image.removeChild(r.lineDisplay);
						
						if (Main.lineArray.length == 0)
						{
							Main.randomEventArray.splice(Main.randomEventArray.indexOf(Main.E_RacistVideo), 1);
						}
								
						Main.airportDict[return_DELETE[1]]["incomingroutes"] -= 1;
						if (Main.airportDict[return_DELETE[1]]["incomingroutes"] == 0 && Main.airportDict[return_DELETE[1]]["routes"] == 0)
						{
							Main.airportDict[return_DELETE[1]]["priority"] = Main.airportDict[return_DELETE[1]]["startpriority"];
						}
								
								
						return_DELETE = new Array();
						DELETING = false;
					}
				}
			}
		}
		
		private function buyAntiAirFunction(evt:MouseEvent):void
		{
			if (Number(cash_field.text) >= antiAirPrice)
			{
				interFace2.play();
				cash_field.text = String(Math.round(Number(cash_field.text) - antiAirPrice));
				cash_field.setTextFormat(cash_format);
				antiAirPrice = Math.round(antiAirPrice * priceMultiplier);
				hoverDict[buyAntiAir][1] = antiAirPrice;
				hoverprice.text = "$ " + String(hoverDict[buyAntiAir][1]);
				hoverprice.setTextFormat(hoverformat1);
				hoverprice.visible = true;
				buyAntiAir.price = antiAirPrice;
				buyAntiAirGrey.price = antiAirPrice;
				
				
				var nAntiAir = new AntiAir(player.x, player.y, bg_image);
				bg_image.addChild(nAntiAir);
				nAntiAir.scaleX = flightScale;
				nAntiAir.scaleY = flightScale;
				
				Arrow.Selected = true;
				
				moneyChange();
			}
			
			else
			{
				reject1.play();
			}
		}
		
		private function buyengineFunction(evt:MouseEvent):void
		{
			if (Number(cash_field.text) >= enginePrice)
			{
				interFace2.play();
				cash_field.text = String(Math.round(Number(cash_field.text) - enginePrice));
				cash_field.setTextFormat(cash_format);
				enginePrice = Math.round(enginePrice * priceMultiplier);
				hoverDict[buyengine][1] = enginePrice;
				buyengine.price = enginePrice;
				buyEngineGrey.price = enginePrice;
				
				buyengine.completed = true;
					
				Airport.ROUTING = false;
				Airport.DELETING = false;
				Airport.return_ROUTE = new Array();
						
				modify_new_route.visible = false;
				
				Airplane.SPEED += 0.1;
				Airplane.SPEED = int(Airplane.SPEED*10);
				Airplane.SPEED = Number(Airplane.SPEED*0.1);
				engineText.text = String(Airplane.SPEED).substring(0, 3);
				engineText.setTextFormat(airplane_format);
				moneyChange();
				
				arrayOfEngineStrings[0].showText();
				arrayOfEngineStrings.push(arrayOfEngineStrings.shift());
			}
			
			else
			{
				reject1.play();
			}
		}
		
		private function buyTerminal(evt:MouseEvent):void
		{
			if (Main.tutorial == true && Main.tutorialStep == 6 && Airport.currentSelect.country == "Germany")
			{
				interFace2.play();
				Main.tutorialStep = 7;
				Main.hovertext.text = "Well done. Now do the same in France.";
				Main.collectedAirportDict["Germany"].stopAlpha();
				Main.collectedAirportDict["France"].highLight();
				Main.TUTORIALTEXT = "Well done. Now do the same in France.";
				Main.hovertext.setTextFormat(Main.hoverformat);
				
				airportDict[currentLocation]["terminal"] = true;
				
				for each (var airportEks in collectedAirportArray)
				{
					if (airportEks.country == currentLocation)
					{
						airportEks.airportB.visible = false;
						airportEks.blueAirportB.visible = true;
					}
				}
				
				buyTerminalButton.visible = false;
				
				store_board.visible = true;
				country_board.visible = true;
				route_board.visible = false;
				modify_route.visible = false;
				player_board.visible = false;
				
				buyplane.visible = true;
				removeterminal.visible = true;
				//buymarketing.visible = true;
				buylanding.visible = true;
				//buyseat.visible = true;
				modify_new_route.visible = false;
				create_new_route.visible = true;
				
				buyAntiAir.visible = false;
				
				influenceBar.x = Math.min(airportDict[currentLocation]["reputation"]*(modify_new_route.width/2+30), modify_new_route.width/2+30);
				blueReputationBar.x = Math.min(airportDict[currentLocation]["bluereputation"]*(modify_new_route.width/2+30), modify_new_route.width/2+30);
				status_info.text = airportDict[currentLocation]["status"];
				status_info.setTextFormat(statusFormat);
				
				Main.numAirplanesTextR.text = String(Main.airportDict[currentLocation]["planesHere"]);
				Main.numAirplanesTextR.setTextFormat(Main.cash_format);
				
				runwayField.text = String(airportDict[currentLocation]["runways"]);
				runwayField.setTextFormat(cash_format);
			}
			
			else if (Main.tutorial == true && Main.tutorialStep == 7 && Airport.currentSelect.country == "France")
			{
				interFace2.play();
				Main.tutorialStep = 8;
				Main.hovertext.text = "Left click on Germany again.";
				Main.collectedAirportDict["Germany"].highLight();
				Main.collectedAirportDict["France"].stopAlpha();
				Main.TUTORIALTEXT = "Left click on Germany again.";
				Main.hovertext.setTextFormat(Main.hoverformat);
				
				airportDict[currentLocation]["terminal"] = true;
				
				for each (var airportEksD in collectedAirportArray)
				{
					if (airportEksD.country == currentLocation)
					{
						airportEksD.airportB.visible = false;
						airportEksD.blueAirportB.visible = true;
					}
				}
				
				buyTerminalButton.visible = false;
				
				store_board.visible = true;
				country_board.visible = true;
				route_board.visible = false;
				modify_route.visible = false;
				player_board.visible = false;
				
				buyplane.visible = true;
				removeterminal.visible = true;
				//buymarketing.visible = true;
				buylanding.visible = true;
				//buyseat.visible = true;
				modify_new_route.visible = false;
				create_new_route.visible = true;
				
				buyAntiAir.visible = false;
				
				influenceBar.x = Math.min(airportDict[currentLocation]["reputation"]*(modify_new_route.width/2+30), modify_new_route.width/2+30);
				blueReputationBar.x = Math.min(airportDict[currentLocation]["bluereputation"]*(modify_new_route.width/2+30), modify_new_route.width/2+30);
				status_info.text = airportDict[currentLocation]["status"];
				status_info.setTextFormat(statusFormat);
				
				Main.numAirplanesTextR.text = String(Main.airportDict[currentLocation]["planesHere"]);
				Main.numAirplanesTextR.setTextFormat(Main.cash_format);
				
				runwayField.text = String(airportDict[currentLocation]["runways"]);
				runwayField.setTextFormat(cash_format);
			}
			
			else if (Main.tutorial == true && Main.tutorialStep == 16 && (Airport.currentSelect.country == "Poland" || Airport.currentSelect.country == "Ukraine" || Airport.currentSelect.country == "Denmark")) 
			{
				if (Airport.currentSelect.country == "Denmark" && airportDict["Ukraine"]["terminal"] == true && airportDict["Poland"]["terminal"] == true)
				{
					Main.tutorialStep = 17;
					Main.collectedAirportDict["Poland"].stopAlpha();
					Main.collectedAirportDict["Denmark"].stopAlpha();
					Main.collectedAirportDict["Ukraine"].stopAlpha();
					Main.hovertext.text = "Well done. Now create a route from Denmark to Ukraine via Poland.";
					Main.TUTORIALTEXT = "Well done. Now create a route from Denmark to Ukraine via Poland.";
					Main.hovertext.setTextFormat(Main.hoverformat);
				}
				
				else if (Airport.currentSelect.country == "Poland" && airportDict["Ukraine"]["terminal"] == true && airportDict["Denmark"]["terminal"] == true)
				{
					Main.tutorialStep = 17;
					Main.collectedAirportDict["Poland"].stopAlpha();
					Main.collectedAirportDict["Denmark"].stopAlpha();
					Main.collectedAirportDict["Ukraine"].stopAlpha();
					Main.hovertext.text = "Well done. Now create a route from Denmark to Ukraine via Poland.";
					Main.TUTORIALTEXT = "Well done. Now create a route from Denmark to Ukraine via Poland.";
					Main.hovertext.setTextFormat(Main.hoverformat);
				}
				
				else if (Airport.currentSelect.country == "Ukraine" && airportDict["Denmark"]["terminal"] == true && airportDict["Poland"]["terminal"] == true)
				{
					Main.tutorialStep = 17;
					Main.collectedAirportDict["Poland"].stopAlpha();
					Main.collectedAirportDict["Denmark"].stopAlpha();
					Main.collectedAirportDict["Ukraine"].stopAlpha();
					Main.hovertext.text = "Well done. Now create a route from Denmark to Ukraine via Poland.";
					Main.TUTORIALTEXT = "Well done. Now create a route from Denmark to Ukraine via Poland.";
					Main.hovertext.setTextFormat(Main.hoverformat);
				}
				
				interFace2.play();
				
				airportDict[currentLocation]["terminal"] = true;
				
				for each (var airportEksDE in collectedAirportArray)
				{
					if (airportEksDE.country == currentLocation)
					{
						airportEksDE.airportB.visible = false;
						airportEksDE.blueAirportB.visible = true;
					}
				}
				
				buyTerminalButton.visible = false;
				
				store_board.visible = true;
				country_board.visible = true;
				route_board.visible = false;
				modify_route.visible = false;
				player_board.visible = false;
				
				buyplane.visible = true;
				removeterminal.visible = true;
				//buymarketing.visible = true;
				buylanding.visible = true;
				//buyseat.visible = true;
				modify_new_route.visible = false;
				create_new_route.visible = true;
				
				buyAntiAir.visible = false;
				
				influenceBar.x = Math.min(airportDict[currentLocation]["reputation"]*(modify_new_route.width/2+30), modify_new_route.width/2+30);
				blueReputationBar.x = Math.min(airportDict[currentLocation]["bluereputation"]*(modify_new_route.width/2+30), modify_new_route.width/2+30);
				status_info.text = airportDict[currentLocation]["status"];
				status_info.setTextFormat(statusFormat);
				
				Main.numAirplanesTextR.text = String(Main.airportDict[currentLocation]["planesHere"]);
				Main.numAirplanesTextR.setTextFormat(Main.cash_format);
				
				runwayField.text = String(airportDict[currentLocation]["runways"]);
				runwayField.setTextFormat(cash_format);
			}
			
			if (Number(cash_field.text) >= terminalprice * Main.airportDict[Main.currentLocation]["GDP"])
			{
				interFace2.play();
				cash_field.text = String(Math.round(Number(cash_field.text) - terminalprice * Main.airportDict[Main.currentLocation]["GDP"]));
				cash_field.setTextFormat(cash_format);
				
				airportDict[currentLocation]["terminal"] = true;
				
				for each (var airportEksF in collectedAirportArray)
				{
					if (airportEksF.country == currentLocation)
					{
						airportEksF.airportB.visible = false;
						airportEksF.blueAirportB.visible = true;
					}
				}
				
				buyTerminalButton.visible = false;
				
				store_board.visible = true;
				country_board.visible = true;
				route_board.visible = false;
				modify_route.visible = false;
				player_board.visible = false;
				
				buyplane.visible = true;
				removeterminal.visible = true;
				//buymarketing.visible = true;
				buylanding.visible = true;
				//buyseat.visible = true;
				modify_new_route.visible = false;
				create_new_route.visible = true;
				
				buyAntiAir.visible = false;
				
				influenceBar.x = Math.min(airportDict[currentLocation]["reputation"]*(modify_new_route.width/2+30), modify_new_route.width/2+30);
				blueReputationBar.x = Math.min(airportDict[currentLocation]["bluereputation"]*(modify_new_route.width/2+30), modify_new_route.width/2+30);
				status_info.text = airportDict[currentLocation]["status"];
				status_info.setTextFormat(statusFormat);
				
				runwayField.text = String(airportDict[currentLocation]["runways"]);
				runwayField.setTextFormat(cash_format);
				
				Main.numAirplanesTextR.text = String(Main.airportDict[currentLocation]["planesHere"]);
				Main.numAirplanesTextR.setTextFormat(Main.cash_format);
				
			}
			else
			{
				reject1.play();
			}
			moneyChange();
		}
		
		private function deleteFunction(evt:MouseEvent):void
		{			
			interFace2.play();
			delete_button.completed = false;
			
			modify_new_route.visible = false;
			
			Airport.ROUTING = false;
			//Airport.DELETING = true;
			Airport.return_ROUTE = new Array();
			return_DELETE = [Line.selectedRoute.startN, Line.selectedRoute.finishN];
			
			Main.delete_button.visible = false;
			Main.delete_button.alpha = 0.8;
			Main.delete_button.completed = true;
			
			Main.removeterminal.visible = false;
			Main.buyengine.visible = false;
			Main.buyseat.visible = false;
			
			Main.collectedRouteArray.splice(Main.collectedRouteArray.indexOf(Line.selectedRoute.routeParent), 1)
			Main.parentRouteDict[Line.selectedRoute.routeParent.parentRoute]["lines"].splice(Main.parentRouteDict[Line.selectedRoute.routeParent.parentRoute]["lines"].indexOf(Line.selectedRoute.routeParent), 1);
			
			Main.airportDict[Line.selectedRoute.startN]["bluereputation"] = Math.max(0.1, Main.airportDict[Line.selectedRoute.startN] -  0.1);
			Line.selectedRoute.routeParent.routeTimer.stop();
			if (Main.parentRouteDict[Line.selectedRoute.routeParent.parentRoute]["lines"].length == 0)
			{
				for each (var a in collectedAirplaneArray)
				{
					if (a.currentRoute == Line.selectedRoute.routeParent.parentRoute)
					{
						a.currentRoute = false;
					}
				}
			}
			Main.airportDict[Line.selectedRoute.startN]["routes"] -= 1;
			if (Main.airportDict[Line.selectedRoute.startN]["routes"] == 0)
			{
				Main.Active_array.splice(Main.Active_array.indexOf(Line.selectedRoute.startN), 1);
				Main.airportDict[Line.selectedRoute.startN]["active"] = false;
				if (Main.airportDict[Line.selectedRoute.startN]["incomingroutes"] == 0)
				{
					Main.airportDict[Line.selectedRoute.startN]["priority"] = Main.airportDict[Line.selectedRoute.startN]["startpriority"];
				}
			}
			Main.airportDict[Line.selectedRoute.startN]["deficit"] = 1;
			bg_image.removeChild(Line.selectedRoute);
			
			
					
			if (Main.lineArray.length == 0)
			{
				Main.randomEventArray.splice(Main.randomEventArray.indexOf(Main.E_RacistVideo), 1);
			}
					
			Main.airportDict[return_DELETE[1]]["incomingroutes"] -= 1;
			if (Main.airportDict[return_DELETE[1]]["incomingroutes"] == 0 && Main.airportDict[return_DELETE[1]]["routes"] == 0)
			{
				Main.airportDict[return_DELETE[1]]["priority"] = Main.airportDict[return_DELETE[1]]["startpriority"];
			}
					
					
			return_DELETE = new Array();
			DELETING = false;
					
			Main.route_board.visible = false;
			modify_route.visible = false;
			Main.player_board.visible = false;
		}

		// EnterFrame / Time function
		private function time(evt:TimerEvent):void
		{
			if (Main.dragLeft == true)
			{
				spImage.x -= 2 / flightScale;
			}
			else if (Main.dragRight == true)
			{
				spImage.x += 2 / flightScale;
			}
			if (Main.dragUp == true)
			{
				spImage.y -= 2 / flightScale;
			}
			else if (Main.dragDown == true)
			{
				spImage.y += 2 / flightScale;
			}
			
			// Movement of airplanes
			airPlaneMovement();
			
			// PLAYER MOVEMENT
			// if right is pressed and speed didnt hit the limit, increase speed
			//if (mapMask.hitTestObject(player))
			/*mapbd = new BitmapData (mapMask.width, mapMask.height, true, 0);
			mapbd.draw (mapMask);
			trace("Hittest", mapbd.hitTest(new Point(player.x, player.y), 0xFF, new Point()));*/
			//trace("Hittest", _collisionTest.simple(mapMask, new Point(player.x, player.y)));
			
			if (Main.moveLeft == true)
			{
				player.xspeed = - Arrow.mSpeed;
			}
			else if (Main.moveRight == true)
			{
				player.xspeed = Arrow.mSpeed;
			}
			else
			{
				player.xspeed = 0;
			}
			if (Main.moveUp == true)
			{
				player.yspeed = - Arrow.mSpeed;
			}
			else if (Main.moveDown == true)
			{
				player.yspeed = Arrow.mSpeed;
			}
			else
			{
				player.yspeed = 0;
			}
			var jiBoolean:Boolean;
			if (player.yspeed == 0 && player.xspeed == 0)
			{
				jiBoolean = true;
			}
			//trace("Collision :", _collisionTest.simple(mapMask, new Point(player.x + player.xspeed, player.y + player.yspeed)), "xspeed: ", player.xspeed, "yspeed: ", player.yspeed, "settled: ", player.settled);
			//trace("xspeed: ", player.xspeed, "yspeed: ", player.yspeed, "settled: ", player.settled, "readytoMove: ", Main.readyToMove);
			if (Main.readyToMove == true && _collisionTest.simple(mapMask, new Point(player.x + player.xspeed, player.y + player.yspeed)) && jiBoolean == false)
			{
				Main.event_field_speed = 3;
				buyAntiAir.visible = true;
				
				player.x += player.xspeed;
				player.y += player.yspeed;
				spImage.x -= player.xspeed / Main.flightScale;
				spImage.y -= player.yspeed / Main.flightScale;
				
				if (player.settled == true)
				{
					if (Math.sqrt(Math.pow((player.x - airportDict[player.playerLocation]["x"]),2) + Math.pow((airportDict[player.playerLocation]["y"] - player.y),2)) > Airport.snapLength * flightScale + 5 * flightScale)
					{
						player.settled = false;
					}
				}
				
				else
				{
					for (var oio:int = 0; oio < Main.collectedAirportArray.length; oio ++)
					{
						var aip:Airport = Main.collectedAirportArray[oio];
						if (aip.visible == true && Math.sqrt(Math.pow((aip.x - player.x),2) + Math.pow((player.y - aip.y),2)) < Airport.snapLength * flightScale)
						{
							player.settled = true;
							buymarketing.visible = true;
							player.playerLocation = aip.country;
							player.x = aip.x;
							player.y = aip.y;
							buyAntiAir.visible = false;
							buyAntiAirGrey.visible = false;
							Main.readyToMove = false;
							//trace("Should be sent back");
							if (Main.tutorial == true && Main.tutorialStep == 4 && aip.country == "Egypt")
							{
								Main.tutorialStep = 5;
								Main.collectedAirportDict["Egypt"].stopAlpha();
								Main.collectedAirportDict["Germany"].highLight();
								Main.hovertext.text = "Well done. Now right click on Germany to fly there.";
								Main.TUTORIALTEXT = "Well done. Now right click on Germany to fly there.";
								Main.hovertext.setTextFormat(Main.hoverformat);
							}
						}
					}
				}
				
			}
			else
			{
				Main.event_field_speed = 2;
			}
			
			//
			
			//player.transport.visible = true;
			//player.transport.rotation = Math.atan(player.yspeed/player.xspeed)/Math.PI*180 - 180 * (Math.abs(player.xspeed)/player.xspeed);
			
			
			

			// Movement of news field:
			if (bm.x + bm.width > eventMask.x)
			{
				//event_field.x -=  event_field_speed;
				bm.x-=event_field_speed;
			}
			else
			{
				if (newsQueue.length > 0)
				{
					var showNews:ScheduledEvent = new ScheduledEvent(newsQueue[0],this);
					newsQueue.splice(0, 1);
				}
				else if (randomEventArray.length > 0)
				{
					randomTall = Math.floor(Math.random() * randomEventArray.length);
					var showRandom:RandomEvent = new RandomEvent(randomEventArray[randomTall],this);
					if (LASTNEWS)
					{
						randomEventArray[randomEventArray.length] = LASTNEWS;
					}
					LASTNEWS = randomEventArray[randomTall];
					
					randomEventArray.splice(randomTall, 1);
					
				}

			}
			// ----------------------------------------------
			// Dynamic date
			dayCount +=  daySpeed;
			
			if (dayCount % (2*dayValue) == 0)
			{
				createRedSignals();
				sendFlights();
			}
			
			else if (dayCount % (30*dayValue) == 0)
			{
				trace("3511: ", 1);
				for (var a:int = 0; a < Main.collectedAirportArray.length; a++)
				{
					if (Main.airportDict[Main.collectedAirportArray[a].country]["relation"] == "War")
					{
						trace("351: ", 2);
						var ss = new Fighter(Main.collectedAirportArray[a].country, bg_image);
						bg_image.addChild(ss);
					}
				}
			}
			
			if (dayCount % dayValue == 0)
			{
				//saveGame();
				var bloop:Boolean = false;
				
				var sIndex:int = maildg.selectedIndex;
				for (var p:int = 0; p < maildp.length; p++)
				{
					if (maildp.getItemAt(p)["Expires in"] != "")
					{
						maildp.getItemAt(p)["Expires in"] -= 1;
						//trace(3518, Main.currentMail);
						if (maildp.getItemAt(p)["Expires in"] == 0)
						{
							trace("Main 3523", Main.currentMail, maildg.getItemAt(p)["mailID"]);
							if (Main.currentMail == maildg.getItemAt(p)["mailID"])
							{
								bigMailBox.visible = false;
								maildg.selectedIndex = -1;
								sIndex = -1;
							}
							mailText.text = String(int(Main.mailText.text) - 1);
							mailText.setTextFormat(importantRedFormatLeft);
							maildg.dataProvider.removeItemAt(p);
							
							if (int(mailText.text) == 0)
							{
								mailIcon.alpha = 0.5;
							}
						}
					}	
				}
				maildg.dataProvider = maildp;
				maildg.selectedIndex = sIndex;
				
				/*for (var o:Object in Mail.expiringMails)
				{
					//trace("Days left:", Mail.expiringMails[o]);
					Mail.expiringMails[o] -= 1;
					
					if (Mail.expiringMails[o] == 0)
					{
						// del mail
						//trace("Deleting mail", "Total number of mails: ", maildp.length);
						for (var p:int = 0; p < maildp.length; p++)
						{
							//trace("Searching through maildp");
							//trace(maildp.getItemAt(p));
							if (maildp.getItemAt(p)["mailID"] == o)
							{
								//trace("Found mail to be deleted");
								maildg.dataProvider.removeItemAt(p);
								bloop = true;
								//mailExpiresIn.visible = false;
								if (Main.currentMail == o)
								{
									bigMailBox.visible = false;
									maildg.selectedIndex = -1;
								}
								mailText.text = String(int(Main.mailText.text) - 1);
								mailText.setTextFormat(importantRedFormatLeft);
							}
						}
						delete Mail.expiringMails[o];
					}
				}*/
				
				/*var sIndex:uint = maildg.selectedIndex + Main.mCo;
				Main.mCo = 0;
				trace("sIndexPre: ", sIndex);
				for (var pp:int = 0; pp < maildp.length; pp++)
				{
					//trace("Searching through maildp");
					//trace(maildp.getItemAt(p));
					if (maildp.getItemAt(pp)["Expires in"] != "")
					{
						maildp.getItemAt(pp)["Expires in"] -= 1;
						maildg.dataProvider = maildp;
						maildg.selectedIndex = sIndex;
						//ListCollectionView(dataGrid.dataProvider).getItemAt(requiredRow).appropriateProperty = newValue;
					}
				}*/
				
				/*trace("1:", Mail.expiringMails);
				trace("2:", maildg.selectedIndex);
				trace("3:", Mail.expiringMails[maildg.getItemAt(maildg.selectedIndex)["mailID"]]);*/
				//trace("sIndexPost: ", sIndex);
				//trace(maildg.selectedIndex);
				/*if (maildg.selectedIndex != -1)
				{
					try
					{
						mailExpiresIn.text = String(Mail.expiringMails[maildg.getItemAt(maildg.selectedIndex)["mailID"]]);
						mailExpiresIn.setTextFormat(importantRedFormat);
					}
					
					catch (e:Error)
					{
						trace("Error 1.3");
					}
				}*/
				
				
				
				fuel_cosinus = Math.round(Math.cos(dayCount*0.1)*5+Math.random()*5);
				fuelPriceText.text =  "$ " + String(fuel_constant+fuel_cosinus);
				fuelPriceText.setTextFormat(airplane_format);
				
				dateNow.setDate(dateNow.getDate() + 1);
				time_field.text = String(dateNow.getDate()) + " " + String(dateNow.getMonth() + 1) + " " + String(dateNow.getFullYear());
				
				if (LOSING == true)
				{
					if (int(count_down_field.text) == 0)
					{
						// You lost
						Airplane.SPEED = 0;
						event_field_speed = 0;
						daySpeed = 0;
						event_field.x = 400;
						event_field.text = "Your company is bankrupt...";
					}
					
					else
					{
						time_field.setTextFormat(redDateFormat);
						count_down_field.text = String(int(count_down_field.text) - 1);
						count_down_field.setTextFormat(bigRedDateFormat);
					}
				}
				
				else
				{
					time_field.setTextFormat(dateFormat);
				}
				
				event_function();

				if (newsWaitingQueue.length > 0)
				{
					for (var count:int = 0; count < newsWaitingQueue.length; count++)
					{
						if (newsWaitingQueue[count][1][0] == dateNow.getDate() && newsWaitingQueue[count][1][1] == dateNow.getMonth() && newsWaitingQueue[count][1][2] == dateNow.getFullYear())
						{
							newsQueue[newsQueue.length] = newsWaitingQueue[count][0];
							//trace("Pushed successfully ending to newsQueue");
						}
					}
				}
			}

			// ---------------------------------

			function event_function():void
			{
				// SCHEDULED EVENTS

				// Winter Olympics
				if ((Number(dateNow.getFullYear())-2014) % 4 == 0 && dateNow.getMonth() == E_winterOlympics["month"]-1 && dateNow.getDate() == 1)
				{
					newsQueue[newsQueue.length] =  new Array(E_winterOlympics, "random", false);
				}

				// Summer Olympics
				if ((Number(dateNow.getFullYear()-2012)) % 4 == 0 && dateNow.getMonth() == E_summerOlympics["month"]-1 && dateNow.getDate() == 1)
				{
					newsQueue[newsQueue.length] =  new Array(E_summerOlympics, "random", false);
				}
				
				/*// Terror attack
				if ((Number(dateNow.getFullYear()-2012)) % 4 == 0 && dateNow.getMonth() == E_summerOlympics["month"]-1 && dateNow.getDate() == 1)
				{
					newsQueue[newsQueue.length] =  new Array(E_summerOlympics, "random", false);
				}
				
				var newMission:Mission = new Mission();
				//newMission.declareVariables(this.eventDict["mission"][Math.floor(Math.random() * this.eventDict["mission"].length)], "random", this.country, 6000000)
				
				if (Main.organizations[this.eventDict["mission"][0]]["type"] == "transport")
				{
					newMission.declareVariables(this.eventDict["mission"][0], "random", this.country, Main.airplanePrice * 10, Main.organizations[this.eventDict["mission"][0]]["expires"], "transport");
				}
				
				else if (Main.organizations[this.eventDict["mission"][0]]["type"] == "setUpRoute")
				{
					newMission.declareVariables(this.eventDict["mission"][0], false, this.country, Main.airplanePrice * 10, Main.organizations[this.eventDict["mission"][0]]["expires"], "setUpRoute");
				}
				//trace("Leading to missions");
				newMission.doMission();*/

				// FIFA World Cup
				if ((Number(dateNow.getFullYear())-2014) % 4 == 0 && dateNow.getMonth() == E_worldCup["month"]-3 && dateNow.getDate() == 1)
				{
					if (Number(dateNow.getFullYear()) == 2014)
					{
						newsQueue[newsQueue.length] = new Array(E_worldCup, "Brazil", false);
					}
					else if (Number(dateNow.getFullYear()) == 2018)
					{
						newsQueue[newsQueue.length] = new Array(E_worldCup, "random", false);
						// insert Russia for random 
					}
					else if (Number(dateNow.getFullYear()) == 2022)
					{
						newsQueue[newsQueue.length] = new Array(E_worldCup, "random", false);
						// insert Qatar for random
					}
					else
					{
						newsQueue[newsQueue.length] = new Array(E_worldCup, "random", false);
					}

				}

				// RANDOM EVENTS
			}
			
			function airPlaneMovement()
			{
				for (var sc:int = 0; sc < Main.collectedShotArray.length; sc++)
				{
					var shot = Main.collectedShotArray[sc];
					
					if (shot.visible == true && shot.Target != false)
					{
						shot.x -= Shot.speed * shot.xDif;
						shot.y -= Shot.speed * shot.yDif;
						
						if (shot.Target.hitTestObject(shot))
						{
							shot.Target.crash();
							shot.Target = false;
							try
							{
								shot.parentPlane.docking = true;
								shot.parentPlane.hunting = false;
								shot.parentPlane.speed = 1;
							}
							catch (e:Error)
							{
								trace("nf error");
							}
							shot.parentPlane.Target = false;
							shot.visible = false;
						}
					}
				}
				
				for (var ac:int = 0; ac < Main.collectedAntiAirArray.length; ac ++)
				{
					Main.collectedAntiAirArray[ac].calculateTarget();
				}
				
				if (player.transport.free == false)
				{
					player.transport.flightCounter += 1;
					
					player.transport.x = player.transport.startingPoint_x + player.transport.vector[0] * player.transport.flightCounter;
					player.transport.y = player.transport.startingPoint_y - player.transport.vector[1] * player.transport.flightCounter;
					
					player.x = player.transport.x;
					player.y = player.transport.y;
					
					if (Math.sqrt(Math.pow((player.transport.destination_x - player.transport.x),2) + Math.pow((player.transport.y - player.transport.destination_y),2)) < 2)
					{
						player.transport.circleMovement = false;
						player.transport.throughCheck = false;
						player.transport.free = true;
						player.transport.flightRotation = 0;
						player.transport.circleCounter = 0;
						player.transport.landingQueue = false;
						player.transport.landingApproachQueue = false;
						player.transport.visible = false;
						buyAntiAir.visible = false;
						player.playerLocation = player.transport.currentLocation;
						player.inAir = false;
						player.settled = true;
						player.x = airportDict[player.playerLocation]["x"];
						player.y = airportDict[player.playerLocation]["y"];
						
						if (Main.tutorial == true && Main.tutorialStep == 5 && player.playerLocation == "Germany")
						{
							Main.tutorialStep = 6;
							Main.hovertext.text = "Left click on Germany, and then buy a terminal there.";
							Main.TUTORIALTEXT = "Left click on Germany, and then buy a terminal there.";
							Main.hovertext.setTextFormat(Main.hoverformat);
							//var mMail = new Mail("Carter DuPont", "There you are", "Hi again. I hope you had a nice trip. Your next task is to create a route to France.", "Spam", false);
						}
					}
				}
				
				for (var fc:int = 0; fc < collectedFighterArray.length; fc++)
				{
					var fighter = collectedFighterArray[fc];
					//trace("Fighter: ", fighter.x, fighter.y);
					if (fighter.hunting == true)
					{
						fighter.calculateRoute(fighter.Target);
					}
					else if (fighter.docking == true)
					{
						fighter.calculateReturn();
						
						if (fighter.shotsFired == false)
						{
							fighter.searchForTarget();
						}
					}
					else if (fighter.inAir == false)
					{
						fighter.searchForTarget();
					}
				}
				
				for each (airplane in collectedAirplaneArray)
				{
					if (airplane.free == false)
					{
						if (int(Math.sqrt(Math.pow((airplane.destination_x - airplane.x),2) + Math.pow((airplane.y - airplane.destination_y),2))) == 20 && airplane.throughCheck == false)
						{
							airplane.throughCheck = true;
							
							if (airportDict[airplane.currentLocation]["danger"] == true)
							{
								if (Math.random() > 0.5 && airplane.carryPlayer == false)
								{
									airplane.crash();
									newsQueue[newsQueue.length] = [E_weatherPenalty, "", airplane.currentLocation, ""];
									continue;
								}
							}
							
							//trace(airportDict[airplane.currentLocation]["landingQueue"]);
							if (airportDict[airplane.currentLocation]["landingApproachQueue"].length >= airportDict[airplane.currentLocation]["runways"])
							{
								airportDict[airplane.currentLocation]["landingQueue"][airportDict[airplane.currentLocation]["landingQueue"].length] = airplane;
								airplane.landingQueue = true;
								airplane.circleMovement = true;
								airplane.circleCounter = 0;
								airplane.flightRotation = airplane.rotation;
								airplane.rotation -= 90;
								//trace("Sirkelbevegelse initiert");
							}
							
							else
							{
								airportDict[airplane.currentLocation]["landingApproachQueue"][airportDict[airplane.currentLocation]["landingApproachQueue"].length] = airplane;
								airplane.landingApproachQueue = true;
							}
						}
						else if (Math.sqrt(Math.pow((airplane.destination_x - airplane.x),2) + Math.pow((airplane.y - airplane.destination_y),2)) < (1+Airplane.SPEED))
						{							
							if (airplane.budget && flightScale < 0.4)
							{
								var createNew:Boolean = true;
								
								for each(var popUp in popUpArray)
								{
									if (popUp.visible == false)
									{
										createNew = false;
										
										popUp.updateText(String(airplane.budget), String(airplane.passengers));
										popUp.updateAirplane(airplane);
										popUp.visible = true;
										popUp.addEventListener(Event.ENTER_FRAME, popUp.reSize);
										
										popUp.x = airplane.destination_x - popUp.width*0.5;
										
										var breakLoop:Boolean = false;
										
										for(var countRR:int = 0; countRR < airportDict[airplane.currentLocation]["currentPopUps"].length; countRR ++)
										{
											if (airportDict[airplane.currentLocation]["currentPopUps"][countRR] == false)
											{
												airportDict[airplane.currentLocation]["currentPopUps"][countRR] = true;
												popUp.y = airplane.destination_y - flightScale * (20 + countRR*15);
												popUp.updateLevel(countRR);
												breakLoop = true;
												break;
											}
										}
										
										if (breakLoop == false)
										{
											airportDict[airplane.currentLocation]["currentPopUps"][airportDict[airplane.currentLocation]["currentPopUps"].length] = true;
											popUp.y = airplane.destination_y - flightScale * (20 + (airportDict[airplane.currentLocation]["currentPopUps"].length)* 15);
											popUp.updateLevel(airportDict[airplane.currentLocation]["currentPopUps"].length);
										}
																				
										break;
									}
								}
								
								if (createNew == true)
								{
									var showProfit = new PopUpProfit();
									
									var breakLoop2:Boolean = false;
																	
									for(var countS:int = 0; countS < airportDict[airplane.currentLocation]["currentPopUps"].length; countS ++)
									{
										if (airportDict[airplane.currentLocation]["currentPopUps"][countS] == false)
										{
											airportDict[airplane.currentLocation]["currentPopUps"][countS] = true;
											showProfit.y = airplane.destination_y - flightScale * (20 + countS*15);
											showProfit.updateLevel(countS);
											breakLoop2 = true;
											break;
										}
									}
									
									if (breakLoop2 == false)
									{
										airportDict[airplane.currentLocation]["currentPopUps"][airportDict[airplane.currentLocation]["currentPopUps"].length] = true;
										showProfit.y = airplane.destination_y - flightScale * (20 + (airportDict[airplane.currentLocation]["currentPopUps"].length)*15);
										showProfit.updateLevel(airportDict[airplane.currentLocation]["currentPopUps"].length);
									}									
								
									bg_image.addChild(showProfit);
									
									showProfit.updateText(String(airplane.budget), String(airplane.passengers));
									showProfit.updateAirplane(airplane);
									showProfit.x = airplane.destination_x - showProfit.width*0.5;
								}							
							}
							
							airportDict[airplane.currentLocation]["landingApproachQueue"].splice(airportDict[airplane.currentLocation]["landingApproachQueue"].indexOf(airplane), 1);
							airplane.circleMovement = false;
							airplane.throughCheck = false;
							airplane.flightRotation = 0;
							airplane.circleCounter = 0;
							airplane.landingQueue = false;
							airplane.landingApproachQueue = false;
														
							if(airportDict[airplane.currentLocation]["landingQueue"].length > 0)
							{
								airportDict[airplane.currentLocation]["landingQueue"][0].Flight(airportDict[airplane.currentLocation]["landingQueue"][0].x, airportDict[airplane.currentLocation]["landingQueue"][0].y, airportDict[airplane.currentLocation]["landingQueue"][0].destination_x, airportDict[airplane.currentLocation]["landingQueue"][0].destination_y, airportDict[airplane.currentLocation]["landingQueue"][0].currentLocation, airportDict[airplane.currentLocation]["landingQueue"][0].budget, airportDict[airplane.currentLocation]["landingQueue"][0].passengers, true);
								airportDict[airplane.currentLocation]["landingQueue"][0].circleMovement = false;
								airportDict[airplane.currentLocation]["landingQueue"][0].landingQueue = false;
								airportDict[airplane.currentLocation]["landingQueue"][0].landingApproachQueue = true;
								airportDict[airplane.currentLocation]["landingQueue"].splice(0, 1);
								airportDict[airplane.currentLocation]["landingApproachQueue"][airportDict[airplane.currentLocation]["landingApproachQueue"].length] = airportDict[airplane.currentLocation]["landingQueue"][0];
							}
			
							airplane.visible = false;
							airplane.free = true;
							
							if (airplane.nextPlan == true)
							{
								trace("Main, 3964, planned flights");
								airplane.nextPlan = false;
								airportDict[airplane.currentLocation]["flightQueue"][airportDict[airplane.currentLocation]["flightQueue"].length] = [airplane, airplane.x, airplane.y, airplane.nextX, airplane.nextY, airplane.nextDest, false, false, false, false, airplane.nextMovO];
								airplane.waiting = true;
							}
							
							var inAirCounter:int = 0;
							
							for (var countSR:int = 0; countSR < Main.collectedAirportArray.length; countSR ++)
							{
								Main.airportDict[Main.collectedAirportArray[countSR].country]["planesHere"] = 0;
							}
							
							for (var countST:int = 0; countST < Main.collectedRouteArray.length; countST ++)
							{
								Main.collectedRouteArray[countST].numPlanes = 0;
							}
				
							for (var countR:int = 0; countR < Main.collectedAirplaneArray.length; countR ++)
							{
								if (Main.collectedAirplaneArray[countR].free == false)
								{
									inAirCounter +=  1;
								}
								
								else
								{
									Main.airportDict[Main.collectedAirplaneArray[countR].currentLocation]["planesHere"] += 1;
								}
								
								if (Main.collectedAirplaneArray[countR].currentRoute != false)
								{
									try
									{
										Main.parentRouteDict[Main.collectedAirplaneArray[countR].currentRoute]["numPlanes"] += 1;
									}
									catch (e:Error)
									{
										trace("Error 1.4");
									}
								}
							}
							
							if (Line.selectedRoute != false)
							{
								if (Line.selectedRoute.routeParent == airplane.currentRoute)
								{
									numAirplanesText.text = String(airplane.currentRoute.numPlanes)
									numAirplanesText.setTextFormat(Main.cash_format);
								}
							}
							
							if (Main.currentLocation != false)
							{	
								if (airplane.currentLocation == Main.currentLocation)
								{
									numAirplanesTextR.text = String(Main.airportDict[airplane.currentLocation]["planesHere"])
									numAirplanesTextR.setTextFormat(Main.cash_format);
								}
							}
				
							numActivePlanes = inAirCounter;
							
							airplane_field.text = String(numActivePlanes) + " / " + String(numPlanes);
							airplane_field.setTextFormat(airplane_format);
			
							cash_field.text = String(Math.round(Number(cash_field.text)+airplane.budget));
							cash_field.setTextFormat(cash_format);
							
							if (airplane.currentRoute != false && airplane.waiting == false)
							{
								if (airplane.currentLocation == Main.parentRouteDict[airplane.currentRoute]["lines"][Main.parentRouteDict[airplane.currentRoute]["lines"].length-1].routePoints[1][2] && Main.parentRouteDict[airplane.currentRoute]["lines"][Main.parentRouteDict[airplane.currentRoute]["lines"].length-1].routePoints[1][2] != Main.parentRouteDict[airplane.currentRoute]["lines"][0].routePoints[0][2])
								{
									trace("Returning plane to: ", Main.parentRouteDict[airplane.currentRoute]["lines"][0].routePoints[0][2]);
									airportDict[airplane.currentLocation]["flightQueue"][airportDict[airplane.currentLocation]["flightQueue"].length] = [airplane, airplane.x, airplane.y, Main.airportDict[Main.parentRouteDict[airplane.currentRoute]["lines"][0].routePoints[0][2]]["x"], Main.airportDict[Main.parentRouteDict[airplane.currentRoute]["lines"][0].routePoints[0][2]]["y"], Main.parentRouteDict[airplane.currentRoute]["lines"][0].routePoints[0][2], false, false, false, false, true];
									airplane.waiting = true;
								}
							}
							
							/*if (Number(cash_field.text) < 0 && tutorial == false)
							{
								if (LOSING == false)
								{
									new LosingCountDown();
								}
							}
							
							if (LOSING == true && Number(cash_field.text) > 0)
							{
								LOSING = false;
							}*/
							
							if (currentMissions.length > 0)
							{
								for (var mis:int = 0; mis < currentMissions.length; mis++)
								{
									var misi:Mission = currentMissions[mis];
									if (airplane.startingName == misi["origin"] && airplane.currentLocation == misi["country"])
									{
										trace("You won mission");
										
										for (var ec:int = 0; ec < misi["endingStrings"].length; ec ++)
										{
											var edi = misi["endingStrings"][ec];
											var edi0:String = edi[0];
											edi0 = edi0.replace(pattern1,misi["origin"]);
											edi0 = edi0.replace(pattern2,misi["country"]);
											var edi1:String = edi[1];
											edi1 = edi1.replace(pattern1,misi["origin"]);
											edi1 = edi1.replace(pattern2,misi["country"]);
											var edi2:String = edi[2];
											edi2 = edi2.replace(pattern1,misi["origin"]);
											edi2 = edi2.replace(pattern2,misi["country"]);
											var nMail = new Mail(edi0, edi1, edi2, edi[3], edi[4], misi);
										}
										
										if (misi.country != false)
										{
											trace("Changing relation");
											airportDict[misi.country]["relation"] = misi.relation;
											dataDict[misi.relation][dataDict[misi.relation].length] = misi.country;
											
											if (misi.relation == "Blockade")
											{
												airportDict[misi.country]["accessible"] = false;
											}
											Main.notMissionArray[Main.notMissionArray.length] = misi.country;
											Main.airportDict[misi.country]["mission"] = false;
										}
										
										if (misi.origin != false)
										{
											Main.notMissionArray[Main.notMissionArray.length] = misi.origin;
											Main.airportDict[misi.origin]["mission"] = false;
										}
										
										if (misi.org == "Terrorist Cell")
										{
											newsQueue[newsQueue.length] = new Array(E_terroristAttack, misi.country, false)
										}
										
										currentMissions.splice(mis, 1);
									}
								}
							}
						}
						else
						{
							if (airplane.circleMovement == true)
							{
								airplane.circleCounter += 0.01;
								airplane.x = airplane.destination_x + 20 * Math.cos(Math.PI/180 * (airplane.flightRotation - 180) + airplane.circleCounter);
								airplane.y = airplane.destination_y + 20 * Math.sin(Math.PI/180 * (airplane.flightRotation - 180) + airplane.circleCounter);
								airplane.rotation += 0.01 * 180/Math.PI;
							}
							
							else
							{
								airplane.flightCounter += Airplane.SPEED;
								
								airplane.x = airplane.startingPoint_x + airplane.vector[0] * airplane.flightCounter;
								airplane.y = airplane.startingPoint_y - airplane.vector[1] * airplane.flightCounter;
							}
						}
					}
				}
			}
			
			function saveGame():void
			{				
				so.data.saved = true;
				
				storageArray = new Array();
				for (var keh:Object in airportDict)
				{
					storageArray[storageArray.length] = [keh, airportDict[keh]]
				}
				so.data.storageArray = storageArray;
			
				so.data.bank = cash_field.text;
				so.data.dateNow = dateNow;
				so.data.numPlanes = numPlanes;
				so.data.LOSING = LOSING;
				so.data.countDown = count_down_field.text;
				so.data.numActivePlanes = numActivePlanes;
				so.data.planeCapacity = planeCapacity;
				so.data.fuel_constant = fuel_constant;
				so.data.fuelPriceText = fuelPriceText.text;
				
				so.data.eventCountry = event_country.text;
				so.data.eventFieldLastX = event_field.x;
				so.data.eventText = event_field.text;
				so.data.LASTNEWS = LASTNEWS;
				so.data.newsQueue = newsQueue;
				so.data.newsWaitingQueue = newsWaitingQueue;
				so.data.currentNewsPlace = currentNewsPlace;
			
				so.data.airplanePrice = airplanePrice;
				so.data.marketingPrice = marketingPrice;
				so.data.landingPrice = landingPrice;
				so.data.seatPrice = seatPrice;
				
				so.data.popUpArray = popUpArray;
				if (collectedAirplaneArray.length > 0)
				{
					for each (var airplane:Object in collectedAirplaneArray)
					{
						airplane.lastX = airplane.x;
						airplane.lastY = airplane.y;
						airplane.lastRot = airplane.rotation;
					}
				}
				so.data.collectedAirportArray = collectedAirportArray;
				so.data.collectedAirplaneArray = collectedAirplaneArray;
				so.data.lineArray = lineArray;
				so.data.routeArray = routeArray;
				
				so.flush();
			}
			
			function sendFlights():void
			{
				for each(airportElement in collectedAirportArray)
				{
					if (airportDict[airportElement.country]["flightQueue"].length > 0)
					{
						var maxCount:int = Math.min(airportDict[airportElement.country]["flightQueue"].length, airportDict[airportElement.country]["runways"]);
						for (var countR:int = 0; countR < maxCount; countR ++)
						{				
							airportDict[airportElement.country]["flightQueue"][0][0].Flight(airportDict[airportElement.country]["flightQueue"][0][1], airportDict[airportElement.country]["flightQueue"][0][2], airportDict[airportElement.country]["flightQueue"][0][3], airportDict[airportElement.country]["flightQueue"][0][4], airportDict[airportElement.country]["flightQueue"][0][5], airportDict[airportElement.country]["flightQueue"][0][6], airportDict[airportElement.country]["flightQueue"][0][7], airportDict[airportElement.country]["flightQueue"][0][8], airportDict[airportElement.country]["flightQueue"][0][9], airportDict[airportElement.country]["flightQueue"][0][10]);
							airportDict[airportElement.country]["flightQueue"].splice(0, 1);
						}
					}
				}
			}
		}

		
		private function createRedSignals():void
		{
			if (bm.x + bm.width > 250 && currentNewsPlace != "")
			{
				var redSignal = new RedSignal(airportDict[currentNewsPlace]["x"], airportDict[currentNewsPlace]["y"]);
				bg_image.addChildAt(redSignal,1);
			}
		}
		
		// Functions for game speed buttons
		private function stop_function(evt:MouseEvent):void
		{			
			Airplane.SPEED = 0;
			event_field_speed = 0;
			daySpeed = 0;
			play_fast_button.visible = false;
			play_button.visible = true;
			
			trace(Main.notMissionArray);
		}
		private function start_function(evt:MouseEvent):void
		{
			Airplane.SPEED = 0.5;
			event_field_speed = 2;
			dayValue = 60;
			daySpeed = 1;
			play_button.visible = false;
			play_fast_button.visible = true;
		}

		private function play_fast_function(evt:MouseEvent):void
		{
			Airplane.SPEED = 1.5;
			event_field_speed = 10;
			dayValue = 20;
			daySpeed = 1;
			play_button.visible = true;
			play_fast_button.visible = false;
			
			//trace(Airplane.incomingTransport);
			
			/*trace(Active_array.length);
			for(var TEC:int = 0; TEC < Active_array.length; TEC ++)
			{
				trace(Active_array[TEC]);
			}*/
		}
		
		private function restart_function(evt:MouseEvent):void
		{
			Airplane.SPEED = 0;
			event_field_speed = 0;
			daySpeed = 0;
			restartbox.visible = true;
			
			yesConfirm.addEventListener(MouseEvent.CLICK, confirmRestart);
			noDeny.addEventListener(MouseEvent.CLICK, denyRestart);
		}
		
		private function confirmRestart(evt:MouseEvent):void
		{
			yesConfirm.removeEventListener(MouseEvent.CLICK, confirmRestart);
			noDeny.removeEventListener(MouseEvent.CLICK, denyRestart);
			
			clearProgress()
			
			Airplane.SPEED = 0.5;
			event_field_speed = 2;
			dayValue = 60;
			daySpeed = 1;
			restartbox.visible = false;
		}
		
		private function denyRestart(evt:MouseEvent):void
		{
			yesConfirm.removeEventListener(MouseEvent.CLICK, confirmRestart);
			noDeny.removeEventListener(MouseEvent.CLICK, denyRestart);
			
			Airplane.SPEED = 0.5;
			event_field_speed = 2;
			dayValue = 60;
			daySpeed = 1;
			restartbox.visible = false;
			Airport.ROUTINGFROM = false;
		}
	
		/*private function loadProgress():void
		{
			trace ("Loading progress...");
			
			collectedAirplaneArray = so.data.collectedAirplaneArray;
			numPlanes = collectedAirplaneArray.length;
			LOSING = so.data.LOSING;
			count_down_field.text = so.data.countDown;
			count_down_field.setTextFormat(bigRedDateFormat);
			numActivePlanes = so.data.numActivePlanes;
			airplane_field.text = String(numActivePlanes) + " / " + String(numPlanes);
			airplane_field.setTextFormat(airplane_format);
			
			cash_field.text = so.data.bank;
			cash_field.setTextFormat(cash_format);
			
			airportDict = new Dictionary();
			storageArray = so.data.storageArray;
			
			for (var DCOUNT:int = 0; DCOUNT < storageArray.length; DCOUNT ++)
			{
				airportDict[storageArray[DCOUNT][0]] = storageArray[DCOUNT][1];
			}
			
			//trace("Successfull start... " + airportDict);
			
			//trace(storageArray[0]);
			//trace(storageArray[0][0]);
			//trace(storageArray[0][1]);
			
			for (var countR:int = 0; countR < Airport_array.length; countR ++)
			{
				airportDict[Airport_array[countR]]["landingQueue"] = new Array();
				airportDict[Airport_array[countR]]["landingApproachQueue"] = new Array();
				airportDict[Airport_array[countR]]["flightQueue"] = new Array();
				airportDict[Airport_array[countR]]["currentPopUps"] = new Array();
			}
			
			var collectedAirplaneArrayCopy = collectedAirplaneArray;
			collectedAirplaneArray = new Array();
			for each (var aircraft in collectedAirplaneArrayCopy)
			{
				var airplane = new Airplane(bg_image, aircraft.lastX, aircraft.lastY, aircraft.free, aircraft.waiting, aircraft.throughCheck, aircraft.flightRotation, aircraft.flightCounter, aircraft.circleMovement, aircraft.circleCounter, aircraft.currentLocation, false, aircraft.visible, aircraft.lastRot, aircraft.startingPoint_x, aircraft.startingPoint_y, aircraft.destination_x, aircraft.destination_y, aircraft.vector_x, aircraft.vector_y, aircraft.absvector, aircraft.stigningstall, aircraft.budget, aircraft.passengers, aircraft.landingQueue, aircraft.landingApproachQueue);
				bg_image.addChild(airplane);
				collectedAirplaneArray[collectedAirplaneArray.length] = airplane;
				
				var myColorTransformThingy:ColorTransform = new ColorTransform();
				if (airplane.budget)
				{
					myColorTransformThingy.color = 0x000000;
				}
				else
				{
					myColorTransformThingy.color = 0xCC0000;
				}
				
				airplane.transform.colorTransform = myColorTransformThingy;
				
				if (airplane.landingQueue == true)
				{
					airportDict[airplane.currentLocation]["landingQueue"][airportDict[airplane.currentLocation]["landingQueue"].length] = airplane;
				}
				
				if (airplane.landingApproachQueue == true)
				{
					airportDict[airplane.currentLocation]["landingApproachQueue"][airportDict[airplane.currentLocation]["landingApproachQueue"].length] = airplane;
				}
			}
			
			dateNow = so.data.dateNow;
			
			airplanePrice = so.data.airplanePrice;
			marketingPrice = so.data.marketingPrice;
			landingPrice = so.data.landingPrice;
			seatPrice = so.data.seatPrice;
			hoverDict[buyplane][1] = airplanePrice;
			hoverDict[buymarketing][1] = marketingPrice;
			hoverDict[buylanding][1] = landingPrice;
			hoverDict[buyseat][1] = seatPrice;
			
			fuel_constant = so.data.fuel_constant;
			fuelPriceText.text = so.data.fuelPriceText;
			fuelPriceText.setTextFormat(airplane_format);
			
			planeCapacity = so.data.planeCapacity;
			maxPassengersText.text = String(planeCapacity);
			maxPassengersText.setTextFormat(cash_format);
			
			LASTNEWS = so.data.LASTNEWS;
			newsQueue = so.data.newsQueue;
			newsWaitingQueue = so.data.newsWaitingQueue;
			currentNewsPlace = so.data.currentNewsPlace;
			event_field.x = so.data.eventFieldLastX;
			event_field.text = so.data.eventText;
			event_field.width = event_field.textWidth + 5;
			event_field.setTextFormat(dateFormat);
			
			event_country.text = so.data.eventCountry; 
			event_country.setTextFormat(importantRedFormat);
			
			bmd = new BitmapData(event_field.width,event_field.height,true,0);
			bmd.draw(event_field);

			this.removeChild(bm);
			bm = new Bitmap(bmd);
			bm.x = event_field.x;
			bm.y = event_field.y;
			bm.smoothing = true;
			this.addChild(bm);
			bm.mask = eventMask;

			popUpArray = so.data.popUpArray;
			var popUpArrayCopy:Array = popUpArray;
			popUpArray = new Array();
			for each (var popUp:Object in popUpArrayCopy)
			{
				var showProfit = new PopUpProfit();
				bg_image.addChild(showProfit);
			}
			
			lineArray = new Array();
			routeArray = so.data.routeArray;
			var routeArrayCopy:Array = routeArray;
			routeArray = new Array();
			
			if (routeArrayCopy.length > 0)
			{
				for each (var route:Object in routeArrayCopy)
				{
					var newRoute:Route = new Route(route[0], this, route[1], route[2]);
				}
			}
		}*/
		
		private function clearProgress():void
		{
			trace("Clearing save");
			
			moneyChange();
			resetEventDict();
			
			airportDict = new Dictionary();
			resetDataDict();
			resetAirportDict();
			resetMissions();
			
			try
			{
				player.scaleX = minScale;
				player.scaleY = minScale;
			}
			catch (e:Error)
			{
				
			}
			Main.flightScale = minScale;
			Main.spImage.scaleX = 1;
			Main.spImage.scaleY = 1;
			Main.spImage.x = 0;
			Main.spImage.y = 70;
			bg_image.scaleX = minScale;
			bg_image.scaleY = minScale;
			bg_image.x = 0;
			bg_image.y = 0;
			
			maildp = new DataProvider();
			maildg.dataProvider  = maildp;
			
			bigMailBox.visible = false;
			mailText.text = String(0);
			mailText.setTextFormat(importantRedFormatLeft);
			maildg.selectedIndex = -1;
			Main.mailIcon.alpha = 0.5;
			
			Main.currentMail = undefined;
			Mail.expiringMails = new Dictionary();
			Main.currentMissions = new Array();
			Main.currentMailFrom = "";
			Main.currentMailIndex = 0;
			
			for each (var airport in collectedAirportArray)
			{
				airport.airportS.visible = true;
				airport.airportB.visible = false;
				airport.greenAirport.visible = false;
				airport.greenAirportB.visible = false;
				airport.blueAirport.visible = false;
				airport.blueAirportB.visible = false;
				
				airport.scaleX = minScale;
				airport.scaleY = minScale;
				
				if (airportDict[airport.country]["priority"] > 1 && airport.airportB.visible == false && airport.greenAirport.visible == false && airport.greenAirportB.visible == false && airport.blueAirport.visible == false && airport.blueAirportB.visible == false)
				{
					airport.visible = false;
				}
			}			
			
			for each (var aircraft in collectedAirplaneArray)
			{
				bg_image.removeChild(aircraft);
			}
			collectedAirplaneArray = new Array();
			
			for each (var fighter in collectedFighterArray)
			{
				bg_image.removeChild(fighter);
			}
			collectedFighterArray = new Array();
			
			for each (var antiAir in collectedAntiAirArray)
			{
				bg_image.removeChild(antiAir);
			}
			collectedAntiAirArray = new Array();
			
			for each (var line in lineArray)
			{
				for each (var subline in line[0])
				{
					bg_image.removeChild(subline[2]);
					
				}
				line[1].stop();
			}
			lineArray = new Array();
			
			routeArray = new Array();
			
			dateNow = new Date();
			
			currentNewsPlace = "";
			
			if (tutorial == true)
			{
				cash_field.text = String(0);
			}
			else
			{
				cash_field.text = String(startBank);
			}
			Airplane.SPEED = 0.5;
			cash_field.setTextFormat(cash_format);
			numPlanes = 0;
			LOSING = false;
			count_down_field.visible = false;
			numActivePlanes = 0;
			airplane_field.text = String(numActivePlanes) + " / " + String(numPlanes);
			airplane_field.setTextFormat(airplane_format);
			planeCapacity = 150;
			maxPassengersText.text = String(planeCapacity);
			maxPassengersText.setTextFormat(cash_format);
			fuel_constant = 150;
			fuelPriceText.text =  "$ " + String(fuel_constant+fuel_cosinus);
			fuelPriceText.setTextFormat(airplane_format);
			
			LASTNEWS = undefined;
			newsQueue = new Array();
			newsWaitingQueue = new Array();
			
			enginePrice = start_enginePrice;
			antiAirPrice = start_antiAirPrice;
			airplanePrice = start_airplanePrice;
			marketingPrice = start_marketingPrice;
			landingPrice = start_landingPrice;
			seatPrice = start_seatPrice;
			hoverDict[buyplane][1] = airplanePrice;
			hoverDict[buymarketing][1] = marketingPrice;
			hoverDict[buylanding][1] = landingPrice;
			hoverDict[buyseat][1] = seatPrice;
			hoverDict[buyengine][1] = enginePrice;
			hoverDict[buyAntiAir][1] = antiAirPrice;
			
			bm.x = -4000;
			
			so.clear();
			so.data.saved = false;
			so.flush();
		}
		
		private function resetDataDict():void
		{
			dataDict = new Dictionary();
			
			notYetAdded = ["Congo", "Madagascar", "Mongolia", "Nigeria", "Somalia"];
			dataDict["NotYetAdded"] = notYetAdded;
			 notMissionArray = ["Congo", "Madagascar", "Mongolia", "Nigeria", "Somalia", "Algeria", "America", "Argentina", "Australia","Brazil", "Canada", "China", "Denmark", "Egypt", "England", "France", "Germany", "Greece", "Iceland", "India", "Indonesia", "Iran", "Italy", "Japan", "Libya", "Mexico", "Norway", "Poland", "Portugal", "Russia", "Arabia", "South Africa", "Spain", "Sweden", "Turkey", "Ukraine"];
			dataDict["Airport"] = Airport_array;
			 Airport_array = ["Algeria", "America", "Argentina", "Australia","Brazil", "Canada", "China", "Denmark", "Egypt", "England", "France", "Germany", "Greece", "Iceland", "India", "Indonesia", "Iran", "Italy", "Japan", "Libya", "Mexico", "Norway", "Poland", "Portugal", "Russia", "Arabia", "South Africa", "Spain", "Sweden", "Turkey", "Ukraine"];
			dataDict["Airport"] = Airport_array;
			 Neutral_array = Airport_array;
			dataDict["Neutral"] = Neutral_array;
			 Friendly_array = new Array();
			dataDict["Friendly"] = Friendly_array;
			 War_array = new Array();
			dataDict["War"] = War_array;
			 Blockade_array = new Array();
			dataDict["Blockade"] = Blockade_array;
			 Tornado_array = ["Australia","Brazil", "Canada", "China", "Mexico", "India","South Africa", "Spain", "America"];
			dataDict["Tornado"] = Tornado_array;
			 Tsunami_array = ["Australia","Brazil", "Canada", "China", "England", "France", "Greenland", "Greece", "Iceland", "India", "Indonesia", "Italy", "Japan", "Mexico", "Norway", "Portugal", "South Africa", "Spain", "America"];
			dataDict["Tsunami"] = Tsunami_array;
			 HasOil_array = ["Algeria", "Brazil", "Canada", "China", "England", "India", "Indonesia", "Iran", "Libya", "Mexico", "Norway","Arabia", "Russia","America"];
			dataDict["HasOil"] = HasOil_array;
			 Volcano_array = ["Australia", "China", "Indonesia", "Iran", "Italy", "Mexico", "America"];
			dataDict["Volcano"] = Volcano_array;
			 Nuclear_array = ["America", "Brazil", "Canada", "China", "England", "France", "Germany", "Iran", "Japan", "Mexico", "Russia","South Africa", "Spain", "Sweden", "Ukraine"];
			dataDict["Nuclear"] = Nuclear_array;
			 Rich_array = ["Australia", "Canada", "Denmark", "England", "France", "Germany", "Iceland", "Japan", "Norway", "America", "Sweden"];
			dataDict["Rich"] = Rich_array;
			 Power_array = ["America", "China", "Russia"];
			dataDict["Power"] = Power_array;
			 Terrorist_array = ["Algeria", "Argentina", "Iran", "India", "Mexico", "Libya", "Arabia"];
			dataDict["Terrorist"] = Terrorist_array;
			 Pirate_array = ["Mexico", "India", "Indonesia", "Libya"]
			dataDict["Pirate"] = Pirate_array;
			 Malaria_array = ["Argentina", "South Africa", "Brazil", "China", "India", "Indonesia", "Iran", "Mexico"];
			dataDict["Malaria"] = Malaria_array;
			 Dictatorship_array = [];
			dataDict["Dictatorship"] = Dictatorship_array;
			 Europe_array = ["Denmark", "England", "France", "Germany", "Greece", "Iceland", "Italy", "Norway", "Poland", "Portugal", "Russia", "Spain", "Sweden", "Turkey", "Ukraine"];
			dataDict["Europe"] = Europe_array;
			 Poor_array = ["Libya", "Iran"];
			dataDict["Poor"] = Poor_array;
			 Active_array = [];
			dataDict["Active"] = Active_array;
		}
		
		private function resetAirportDict():void
		{
			S_Algeria["x"] = 410;
			S_Algeria["y"] = 158;
			S_Algeria["name"] = "Algeria";
			S_Algeria["city"] = "Algiers";
			S_Algeria["adjective"] = "Algerian";
			S_Algeria["population"] = 39;
			S_Algeria["GDP"] = 7.5;
			S_Algeria["popularity"] = 52;
			S_Algeria["reputation"] = 0.1;
			S_Algeria["bluereputation"] = 0.1;
			S_Algeria["accessibility"] = true;
			S_Algeria["active"] = false;
			S_Algeria["mission"] = false;
			S_Algeria["status"] = "";
			S_Algeria["currentPopUps"] = new Array();
			S_Algeria["landingQueue"] = new Array();
			S_Algeria["landingApproachQueue"] = new Array();
			S_Algeria["runways"] = 1;
			S_Algeria["flightQueue"] = new Array();
			S_Algeria["routes"] = 0;
			S_Algeria["incomingroutes"] = 0;
			S_Algeria["danger"] = false;
			S_Algeria["appeared"] = true;
			S_Algeria["priority"] = 2;
			S_Algeria["startpriority"] = 2;
			S_Algeria["terminal"] = false;
			S_Algeria["planesHere"] = 0;
			S_Algeria["relation"] = "Neutral";
			S_America["x"] = 180.7;
			S_America["y"] = 149.9;
			S_America["name"] = "America";
			S_America["city"] = "New York";
			S_America["adjective"] = "American";
			S_America["population"] = 317;
			S_America["GDP"] = 52;
			S_America["popularity"] = 191;
			S_America["reputation"] = 0.1;
			S_America["bluereputation"] = 0.1;
			S_America["accessibility"] = true;
			S_America["active"] = false;
			S_America["mission"] = false;
			S_America["status"] = "";
			S_America["currentPopUps"] = new Array();
			S_America["landingQueue"] = new Array();
			S_America["landingApproachQueue"] = new Array();
			S_America["runways"] = 1;
			S_America["flightQueue"] = new Array();
			S_America["routes"] = 0;
			S_America["incomingroutes"] = 0;
			S_America["danger"] = false;
			S_America["appeared"] = true;
			S_America["priority"] = 1;
			S_America["startpriority"] = 1;
			S_America["terminal"] = false;
			S_America["planesHere"] = 0;
			S_America["relation"] = "Neutral";
			S_Argentina["x"] = 235;
			S_Argentina["y"] = 411;
			S_Argentina["name"] = "Argentina";
			S_Argentina["city"] = "Buenos Aires";
			S_Argentina["adjective"] = "Argentine";
			S_Argentina["population"] = 43;
			S_Argentina["GDP"] = 18.7;
			S_Argentina["popularity"] = 115;
			S_Argentina["reputation"] = 0.1;
			S_Argentina["bluereputation"] = 0.1;
			S_Argentina["accessibility"] = true;
			S_Argentina["active"] = false;
			S_Argentina["mission"] = false;
			S_Argentina["status"] = "";
			S_Argentina["currentPopUps"] = new Array();
			S_Argentina["landingQueue"] = new Array();
			S_Argentina["landingApproachQueue"] = new Array();
			S_Argentina["runways"] = 1;
			S_Argentina["flightQueue"] = new Array();
			S_Argentina["routes"] = 0;
			S_Argentina["incomingroutes"] = 0;
			S_Argentina["danger"] = false;
			S_Argentina["appeared"] = true;
			S_Argentina["priority"] = 1;
			S_Argentina["startpriority"] = 1;
			S_Argentina["terminal"] = false;
			S_Argentina["planesHere"] = 0;
			S_Argentina["relation"] = "Neutral";
			S_Australia["x"] = 809.35;
			S_Australia["y"] = 414.95;
			S_Australia["name"] = "Australia";
			S_Australia["city"] = "Sydney";
			S_Australia["adjective"] = "Australian";
			S_Australia["population"] = 60;
			S_Australia["GDP"] = 42;
			S_Australia["popularity"] = 266;
			S_Australia["reputation"] = 0.1;
			S_Australia["bluereputation"] = 0.1;
			S_Australia["accessibility"] = true;
			S_Australia["active"] = false;
			S_Australia["mission"] = false;
			S_Australia["status"] = "";
			S_Australia["currentPopUps"] = new Array();
			S_Australia["landingQueue"] = new Array();
			S_Australia["landingApproachQueue"] = new Array();
			S_Australia["runways"] = 1;
			S_Australia["flightQueue"] = new Array();
			S_Australia["routes"] = 0;
			S_Australia["incomingroutes"] = 0;
			S_Australia["danger"] = false;
			S_Australia["appeared"] = true;
			S_Australia["priority"] = 1;
			S_Australia["startpriority"] = 1;
			S_Australia["terminal"] = false;
			S_Australia["planesHere"] = 0;
			S_Australia["relation"] = "Neutral";
			S_Brazil["x"] = 272;
			S_Brazil["y"] = 361;
			S_Brazil["name"] = "Brazil";
			S_Brazil["city"] = "Rio de Janeiro";
			S_Brazil["adjective"] = "Brazilian";
			S_Brazil["population"] = 201;
			S_Brazil["GDP"] = 12;
			S_Brazil["popularity"] = 26;
			S_Brazil["reputation"] = 0.1;
			S_Brazil["bluereputation"] = 0.1;
			S_Brazil["accessibility"] = true;
			S_Brazil["active"] = false;
			S_Brazil["mission"] = false;
			S_Brazil["status"] = "";
			S_Brazil["currentPopUps"] = new Array();
			S_Brazil["landingQueue"] = new Array();
			S_Brazil["landingApproachQueue"] = new Array();
			S_Brazil["runways"] = 1;
			S_Brazil["flightQueue"] = new Array();
			S_Brazil["routes"] = 0;
			S_Brazil["incomingroutes"] = 0;
			S_Brazil["danger"] = false;
			S_Brazil["appeared"] = true;
			S_Brazil["priority"] = 1;
			S_Brazil["startpriority"] = 1;
			S_Brazil["terminal"] = false;
			S_Brazil["planesHere"] = 0;
			S_Brazil["relation"] = "Neutral";
			S_Canada["x"] = 88;
			S_Canada["y"] = 103;
			S_Canada["name"] = "Canada";
			S_Canada["city"] = "Vancouver";
			S_Canada["adjective"] = "Canadian";
			S_Canada["population"] = 35;
			S_Canada["GDP"] = 43;
			S_Canada["popularity"] = 516;
			S_Canada["reputation"] = 0.1;
			S_Canada["bluereputation"] = 0.1;
			S_Canada["accessibility"] = true;
			S_Canada["active"] = false;
			S_Canada["mission"] = false;
			S_Canada["status"] = "";
			S_Canada["currentPopUps"] = new Array();
			S_Canada["landingQueue"] = new Array();
			S_Canada["landingApproachQueue"] = new Array();
			S_Canada["runways"] = 1;
			S_Canada["flightQueue"] = new Array();
			S_Canada["routes"] = 0;
			S_Canada["incomingroutes"] = 0;
			S_Canada["danger"] = false;
			S_Canada["appeared"] = true;
			S_Canada["priority"] = 1;
			S_Canada["startpriority"] = 1;
			S_Canada["terminal"] = false;
			S_Canada["planesHere"] = 0;
			S_Canada["relation"] = "Neutral";
			S_China["x"] = 716.2;
			S_China["y"] = 143.3;
			S_China["name"] = "China";
			S_China["city"] = "Beijing";
			S_China["adjective"] = "Chinese";
			S_China["population"] = 1351;
			S_China["GDP"] = 9;
			S_China["popularity"] = 40;
			S_China["reputation"] = 0.1;
			S_China["bluereputation"] = 0.1;
			S_China["accessibility"] = true;
			S_China["active"] = false;
			S_China["mission"] = false;
			S_China["status"] = "";
			S_China["currentPopUps"] = new Array();
			S_China["landingQueue"] = new Array();
			S_China["landingApproachQueue"] = new Array();
			S_China["runways"] = 1;
			S_China["flightQueue"] = new Array();
			S_China["routes"] = 0;
			S_China["incomingroutes"] = 0;
			S_China["danger"] = false;
			S_China["appeared"] = true;
			S_China["priority"] = 1;
			S_China["startpriority"] = 1;
			S_China["terminal"] = false;
			S_China["planesHere"] = 0;
			S_China["relation"] = "Neutral";
			S_Congo["x"] = 446;
			S_Congo["y"] = 303.5;
			S_Congo["name"] = "Congo";
			S_Congo["city"] = "Kinshasa";
			S_Congo["adjective"] = "Congolese";
			S_Congo["population"] = 69.4;
			S_Congo["GDP"] = 0.648;
			S_Congo["popularity"] = 68;
			S_Congo["reputation"] = 0.1;
			S_Congo["bluereputation"] = 0.1;
			S_Congo["accessibility"] = true;
			S_Congo["active"] = false;
			S_Congo["mission"] = false;
			S_Congo["status"] = "";
			S_Congo["currentPopUps"] = new Array();
			S_Congo["landingQueue"] = new Array();
			S_Congo["landingApproachQueue"] = new Array();
			S_Congo["runways"] = 1;
			S_Congo["flightQueue"] = new Array();
			S_Congo["routes"] = 0;
			S_Congo["incomingroutes"] = 0;
			S_Congo["danger"] = false;
			S_Congo["appeared"] = false;
			S_Congo["priority"] = 2;
			S_Congo["startpriority"] = 2;
			S_Congo["terminal"] = false;
			S_Congo["planesHere"] = 0;
			S_Congo["relation"] = "Neutral";
			S_Denmark["x"] = 434;
			S_Denmark["y"] = 91.4;
			S_Denmark["name"] = "Denmark";
			S_Denmark["city"] = "Copenhagen";
			S_Denmark["adjective"] = "Danish";
			S_Denmark["population"] = 6;
			S_Denmark["GDP"] = 38;
			S_Denmark["popularity"] = 821;
			S_Denmark["reputation"] = 0.1;
			S_Denmark["bluereputation"] = 0.1;
			S_Denmark["accessibility"] = true;
			S_Denmark["active"] = false;
			S_Denmark["mission"] = false;
			S_Denmark["status"] = "";
			S_Denmark["currentPopUps"] = new Array();
			S_Denmark["landingQueue"] = new Array();
			S_Denmark["landingApproachQueue"] = new Array();
			S_Denmark["runways"] = 1;
			S_Denmark["flightQueue"] = new Array();
			S_Denmark["routes"] = 0;
			S_Denmark["incomingroutes"] = 0;
			S_Denmark["danger"] = false;
			S_Denmark["appeared"] = true;
			S_Denmark["priority"] = 2;
			S_Denmark["startpriority"] = 2;
			S_Denmark["terminal"] = false;
			S_Denmark["planesHere"] = 0;
			S_Denmark["relation"] = "Neutral";
			S_Egypt["x"] = 489;
			S_Egypt["y"] = 181;
			S_Egypt["name"] = "Egypt";
			S_Egypt["city"] = "Cairo";
			S_Egypt["adjective"] = "Egyptian";
			S_Egypt["population"] = 87;
			S_Egypt["GDP"] = 6.6;
			S_Egypt["popularity"] = 150;
			S_Egypt["reputation"] = 0.1;
			S_Egypt["bluereputation"] = 0.1;
			S_Egypt["accessibility"] = true;
			S_Egypt["active"] = false;
			S_Egypt["mission"] = false;
			S_Egypt["status"] = "";
			S_Egypt["currentPopUps"] = new Array();
			S_Egypt["landingQueue"] = new Array();
			S_Egypt["landingApproachQueue"] = new Array();
			S_Egypt["runways"] = 1;
			S_Egypt["flightQueue"] = new Array();
			S_Egypt["routes"] = 0;
			S_Egypt["incomingroutes"] = 0;
			S_Egypt["danger"] = false;
			S_Egypt["appeared"] = true;
			S_Egypt["priority"] = 1;
			S_Egypt["startpriority"] = 1;
			S_Egypt["terminal"] = false;
			S_Egypt["planesHere"] = 0;
			S_Egypt["relation"] = "Neutral";
			S_England["x"] = 396;
			S_England["y"] = 100;
			S_England["name"] = "England";
			S_England["city"] = "Birmingham";
			S_England["adjective"] = "English";
			S_England["population"] = 53;
			S_England["GDP"] = 37;
			S_England["popularity"] = 500;
			S_England["reputation"] = 0.1;
			S_England["bluereputation"] = 0.1;
			S_England["accessibility"] = true;
			S_England["active"] = false;
			S_England["mission"] = false;
			S_England["status"] = "";
			S_England["currentPopUps"] = new Array();
			S_England["landingQueue"] = new Array();
			S_England["landingApproachQueue"] = new Array();
			S_England["runways"] = 1;
			S_England["flightQueue"] = new Array();
			S_England["routes"] = 0;
			S_England["incomingroutes"] = 0;
			S_England["danger"] = false;
			S_England["appeared"] = true;
			S_England["priority"] = 1;
			S_England["startpriority"] = 1;
			S_England["terminal"] = false;
			S_England["planesHere"] = 0;
			S_England["relation"] = "Neutral";
			S_France["x"] = 410.2;
			S_France["y"] = 115.55;
			S_France["name"] = "France";
			S_France["city"] = "Paris";
			S_France["adjective"] = "French";
			S_France["population"] = 67;	
			S_France["GDP"] = 35;
			S_France["popularity"] = 1277;
			S_France["reputation"] = 0.1;
			S_France["bluereputation"] = 0.1;
			S_France["accessibility"] = true;
			S_France["active"] = false;
			S_France["mission"] = false;
			S_France["status"] = "";
			S_France["currentPopUps"] = new Array();
			S_France["landingQueue"] = new Array();
			S_France["landingApproachQueue"] = new Array();
			S_France["runways"] = 1;
			S_France["flightQueue"] = new Array();
			S_France["routes"] = 0;
			S_France["incomingroutes"] = 0;
			S_France["danger"] = false;
			S_France["appeared"] = true;
			S_France["priority"] = 1;
			S_France["startpriority"] = 1;
			S_France["terminal"] = false;
			S_France["planesHere"] = 0;
			S_France["relation"] = "Neutral";
			S_Germany["x"] = 433;
			S_Germany["y"] = 116;
			S_Germany["name"] = "Germany";
			S_Germany["city"] = "Munich";
			S_Germany["adjective"] = "German";
			S_Germany["population"] = 81;
			S_Germany["GDP"] = 40;
			S_Germany["popularity"] = 302;
			S_Germany["reputation"] = 0.1;
			S_Germany["bluereputation"] = 0.1;
			S_Germany["accessibility"] = true;
			S_Germany["active"] = false;
			S_Germany["mission"] = false;
			S_Germany["status"] = "";
			S_Germany["currentPopUps"] = new Array();
			S_Germany["landingQueue"] = new Array();
			S_Germany["landingApproachQueue"] = new Array();
			S_Germany["runways"] = 1;
			S_Germany["flightQueue"] = new Array();
			S_Germany["routes"] = 0;
			S_Germany["incomingroutes"] = 0;
			S_Germany["danger"] = false;
			S_Germany["appeared"] = true;
			S_Germany["priority"] = 2;
			S_Germany["startpriority"] = 2;
			S_Germany["terminal"] = false;
			S_Germany["planesHere"] = 0;
			S_Germany["relation"] = "Neutral";
			S_Greece["x"] = 466.4;
			S_Greece["y"] = 151.5;
			S_Greece["name"] = "Greece";
			S_Greece["city"] = "Athens";
			S_Greece["adjective"] = "Greek";
			S_Greece["population"] = 11;
			S_Greece["GDP"] = 24;
			S_Greece["popularity"] = 1500;
			S_Greece["reputation"] = 0.1;
			S_Greece["bluereputation"] = 0.1;
			S_Greece["accessibility"] = true;
			S_Greece["active"] = false;
			S_Greece["mission"] = false;
			S_Greece["status"] = "";
			S_Greece["currentPopUps"] = new Array();
			S_Greece["landingQueue"] = new Array();
			S_Greece["landingApproachQueue"] = new Array();
			S_Greece["runways"] = 1;
			S_Greece["flightQueue"] = new Array();
			S_Greece["routes"] = 0;
			S_Greece["incomingroutes"] = 0;
			S_Greece["danger"] = false;
			S_Greece["appeared"] = true;
			S_Greece["priority"] = 2;
			S_Greece["startpriority"] = 2;
			S_Greece["terminal"] = false;
			S_Greece["planesHere"] = 0;
			S_Greece["relation"] = "Neutral";
			S_Greenland["x"] = 292;
			S_Greenland["y"] = 61;
			S_Greenland["name"] = "Greenland";
			S_Greenland["city"] = "Nuuk";
			S_Greenland["adjective"] = "Greenlandic";
			S_Greenland["population"] = 0.056;
			S_Greenland["GDP"] = 37;
			S_Greenland["popularity"] = 1000;
			S_Greenland["reputation"] = 0.1;
			S_Greenland["bluereputation"] = 0.1;
			S_Greenland["accessibility"] = true;
			S_Greenland["active"] = false;
			S_Greenland["mission"] = false;
			S_Greenland["status"] = "";
			S_Greenland["currentPopUps"] = new Array();
			S_Greenland["landingQueue"] = new Array();
			S_Greenland["landingApproachQueue"] = new Array();
			S_Greenland["runways"] = 1;
			S_Greenland["flightQueue"] = new Array();
			S_Greenland["routes"] = 0;
			S_Greenland["incomingroutes"] = 0;
			S_Greenland["danger"] = false;
			S_Greenland["appeared"] = true;
			S_Greenland["priority"] = 1;
			S_Greenland["startpriority"] = 1;
			S_Greenland["terminal"] = false;
			S_Greenland["planesHere"] = 0;
			S_Greenland["relation"] = "Neutral";
			S_Kenya["x"] = 508.5;
			S_Kenya["y"] = 291;
			S_Kenya["name"] = "Kenya";
			S_Kenya["city"] = "Nairobi";
			S_Kenya["adjective"] = "Kenyan";
			S_Kenya["population"] = 45.5;
			S_Kenya["GDP"] = 1.8;
			S_Kenya["popularity"] = 32;
			S_Kenya["reputation"] = 0.1;
			S_Kenya["bluereputation"] = 0.1;
			S_Kenya["accessibility"] = true;
			S_Kenya["active"] = false;
			S_Kenya["mission"] = false;
			S_Kenya["status"] = "";
			S_Kenya["currentPopUps"] = new Array();
			S_Kenya["landingQueue"] = new Array();
			S_Kenya["landingApproachQueue"] = new Array();
			S_Kenya["runways"] = 1;
			S_Kenya["flightQueue"] = new Array();
			S_Kenya["routes"] = 0;
			S_Kenya["incomingroutes"] = 0;
			S_Kenya["danger"] = false;
			S_Kenya["appeared"] = false;
			S_Kenya["priority"] = 1;
			S_Kenya["startpriority"] = 1;
			S_Kenya["terminal"] = false;
			S_Kenya["planesHere"] = 0;
			S_Kenya["relation"] = "Neutral";
			S_Iceland["x"] = 358;
			S_Iceland["y"] = 62.3;
			S_Iceland["name"] = "Iceland";
			S_Iceland["city"] = "Reykjavík";
			S_Iceland["adjective"] = "Icelandic";
			S_Iceland["population"] = 0.327;
			S_Iceland["GDP"] = 41;
			S_Iceland["popularity"] = 3620;
			S_Iceland["reputation"] = 0.1;
			S_Iceland["bluereputation"] = 0.1;
			S_Iceland["accessibility"] = true;
			S_Iceland["active"] = false;
			S_Iceland["mission"] = false;
			S_Iceland["status"] = "";
			S_Iceland["currentPopUps"] = new Array();
			S_Iceland["landingQueue"] = new Array();
			S_Iceland["landingApproachQueue"] = new Array();
			S_Iceland["runways"] = 1;
			S_Iceland["flightQueue"] = new Array();
			S_Iceland["routes"] = 0;
			S_Iceland["incomingroutes"] = 0;
			S_Iceland["danger"] = false;
			S_Iceland["appeared"] = true;
			S_Iceland["priority"] = 1;
			S_Iceland["startpriority"] = 1;
			S_Iceland["terminal"] = false;
			S_Iceland["planesHere"] = 0;
			S_Iceland["relation"] = "Neutral";
			S_India["x"] = 632;
			S_India["y"] = 195;
			S_India["name"] = "India";
			S_India["city"] = "Delhi";
			S_India["adjective"] = "Indian";
			S_India["population"] = 1242;
			S_India["GDP"] = 13;
			S_India["popularity"] = 5;
			S_India["reputation"] = 0.1;
			S_India["bluereputation"] = 0.1;
			S_India["accessibility"] = true;
			S_India["active"] = false;
			S_India["mission"] = false;
			S_India["status"] = "";
			S_India["currentPopUps"] = new Array();
			S_India["landingQueue"] = new Array();
			S_India["landingApproachQueue"] = new Array();
			S_India["runways"] = 1;
			S_India["flightQueue"] = new Array();
			S_India["routes"] = 0;
			S_India["incomingroutes"] = 0;
			S_India["danger"] = false;
			S_India["appeared"] = true;
			S_India["priority"] = 1;
			S_India["startpriority"] = 1;
			S_India["terminal"] = false;
			S_India["planesHere"] = 0;
			S_India["relation"] = "Neutral";
			S_Indonesia["x"] = 719;
			S_Indonesia["y"] = 310;
			S_Indonesia["name"] = "Indonesia";
			S_Indonesia["city"] = "Jakarta";
			S_Indonesia["adjective"] = "Indonesian";
			S_Indonesia["population"] = 252;
			S_Indonesia["GDP"] = 5.2;
			S_Indonesia["popularity"] = 26;
			S_Indonesia["reputation"] = 0.1;
			S_Indonesia["bluereputation"] = 0.1;
			S_Indonesia["accessibility"] = true;
			S_Indonesia["active"] = false;
			S_Indonesia["mission"] = false;
			S_Indonesia["status"] = "";
			S_Indonesia["currentPopUps"] = new Array();
			S_Indonesia["landingQueue"] = new Array();
			S_Indonesia["landingApproachQueue"] = new Array();
			S_Indonesia["runways"] = 1;
			S_Indonesia["flightQueue"] = new Array();
			S_Indonesia["routes"] = 0;
			S_Indonesia["incomingroutes"] = 0;
			S_Indonesia["danger"] = false;
			S_Indonesia["appeared"] = true;
			S_Indonesia["priority"] = 1;
			S_Indonesia["startpriority"] = 1;
			S_Indonesia["terminal"] = false;
			S_Indonesia["planesHere"] = 0;
			S_Indonesia["relation"] = "Neutral";
			S_Iran["x"] = 547;
			S_Iran["y"] = 162;
			S_Iran["name"] = "Iran";
			S_Iran["city"] = "Teheran";
			S_Iran["adjective"] = "Iranian";
			S_Iran["population"] = 77;
			S_Iran["GDP"] = 4;
			S_Iran["popularity"] = 3;
			S_Iran["reputation"] = 0.1;
			S_Iran["bluereputation"] = 0.1;
			S_Iran["accessibility"] = true;
			S_Iran["active"] = false;
			S_Iran["mission"] = false;
			S_Iran["status"] = "";
			S_Iran["currentPopUps"] = new Array();
			S_Iran["landingQueue"] = new Array();
			S_Iran["landingApproachQueue"] = new Array();
			S_Iran["runways"] = 1;
			S_Iran["flightQueue"] = new Array();
			S_Iran["routes"] = 0;
			S_Iran["incomingroutes"] = 0;
			S_Iran["danger"] = false;
			S_Iran["appeared"] = true;
			S_Iran["priority"] = 1;
			S_Iran["startpriority"] = 1;
			S_Iran["terminal"] = false;
			S_Iran["planesHere"] = 0;
			S_Iran["relation"] = "Neutral";
			S_Italy["x"] = 435;
			S_Italy["y"] = 136;
			S_Italy["name"] = "Italy";
			S_Italy["city"] = "Rome";
			S_Italy["adjective"] = "Italian";
			S_Italy["population"] = 61;
			S_Italy["GDP"] = 30;
			S_Italy["popularity"] = 735;
			S_Italy["reputation"] = 0.1;
			S_Italy["bluereputation"] = 0.1;
			S_Italy["accessibility"] = true;
			S_Italy["active"] = false;
			S_Italy["mission"] = false;
			S_Italy["status"] = "";
			S_Italy["currentPopUps"] = new Array();
			S_Italy["landingQueue"] = new Array();
			S_Italy["landingApproachQueue"] = new Array();
			S_Italy["runways"] = 1;
			S_Italy["flightQueue"] = new Array();
			S_Italy["routes"] = 0;
			S_Italy["incomingroutes"] = 0;
			S_Italy["danger"] = false;
			S_Italy["appeared"] = true;
			S_Italy["priority"] = 2;
			S_Italy["startpriority"] = 2;
			S_Italy["terminal"] = false;
			S_Italy["planesHere"] = 0;
			S_Italy["relation"] = "Neutral";
			S_Japan["x"] = 794;
			S_Japan["y"] = 160;
			S_Japan["name"] = "Japan";
			S_Japan["city"] = "Tokyo";
			S_Japan["adjective"] = "Japanese";
			S_Japan["population"] = 127;
			S_Japan["GDP"] = 37;
			S_Japan["popularity"] = 66;
			S_Japan["reputation"] = 0.1;
			S_Japan["bluereputation"] = 0.1;
			S_Japan["accessibility"] = true;
			S_Japan["active"] = false;
			S_Japan["mission"] = false;
			S_Japan["status"] = "";
			S_Japan["currentPopUps"] = new Array();
			S_Japan["landingQueue"] = new Array();
			S_Japan["landingApproachQueue"] = new Array();
			S_Japan["runways"] = 1;
			S_Japan["flightQueue"] = new Array();
			S_Japan["routes"] = 0;
			S_Japan["incomingroutes"] = 0;
			S_Japan["danger"] = false;
			S_Japan["appeared"] = true;
			S_Japan["priority"] = 1;
			S_Japan["startpriority"] = 1;
			S_Japan["terminal"] = false;
			S_Japan["planesHere"] = 0;
			S_Japan["relation"] = "Neutral";
			S_Libya["x"] = 439;
			S_Libya["y"] = 171;
			S_Libya["name"] = "Libya";
			S_Libya["city"] = "Tripoli";
			S_Libya["adjective"] = "Libyan";
			S_Libya["population"] = 6.2;
			S_Libya["GDP"] = 12;
			S_Libya["popularity"] = 36;
			S_Libya["reputation"] = 0.1;
			S_Libya["bluereputation"] = 0.1;
			S_Libya["accessibility"] = true;
			S_Libya["active"] = false;
			S_Libya["mission"] = false;
			S_Libya["status"] = "";
			S_Libya["currentPopUps"] = new Array();
			S_Libya["landingQueue"] = new Array();
			S_Libya["landingApproachQueue"] = new Array();
			S_Libya["runways"] = 1;
			S_Libya["flightQueue"] = new Array();
			S_Libya["routes"] = 0;
			S_Libya["incomingroutes"] = 0;
			S_Libya["danger"] = false;
			S_Libya["appeared"] = true;
			S_Libya["priority"] = 2;
			S_Libya["startpriority"] = 2;
			S_Libya["terminal"] = false;
			S_Libya["planesHere"] = 0;
			S_Libya["relation"] = "Neutral";
			S_Mexico["x"] = 106;
			S_Mexico["y"] = 211;
			S_Mexico["name"] = "Mexico";
			S_Mexico["city"] = "Mexico City";
			S_Mexico["adjective"] = "Mexican";
			S_Mexico["population"] = 120;
			S_Mexico["GDP"] = 16;
			S_Mexico["popularity"] = 206;
			S_Mexico["reputation"] = 0.1;
			S_Mexico["bluereputation"] = 0.1;
			S_Mexico["accessibility"] = true;
			S_Mexico["active"] = false;
			S_Mexico["mission"] = false;
			S_Mexico["status"] = "";
			S_Mexico["currentPopUps"] = new Array();
			S_Mexico["landingQueue"] = new Array();
			S_Mexico["landingApproachQueue"] = new Array();
			S_Mexico["runways"] = 1;
			S_Mexico["flightQueue"] = new Array();
			S_Mexico["routes"] = 0;
			S_Mexico["incomingroutes"] = 0;
			S_Mexico["danger"] = false;
			S_Mexico["appeared"] = true;
			S_Mexico["priority"] = 1;
			S_Mexico["startpriority"] = 1;
			S_Mexico["terminal"] = false;
			S_Mexico["planesHere"] = 0;
			S_Mexico["relation"] = "Neutral";
			S_Madagascar["x"] = 538;
			S_Madagascar["y"] = 352;
			S_Madagascar["name"] = "Madagascar";
			S_Madagascar["city"] = "Antananarivo";
			S_Madagascar["adjective"] = "Malagasy";
			S_Madagascar["population"] = 21;
			S_Madagascar["GDP"] = 0.970;
			S_Madagascar["popularity"] = 19;
			S_Madagascar["reputation"] = 0.1;
			S_Madagascar["bluereputation"] = 0.1;
			S_Madagascar["accessibility"] = true;
			S_Madagascar["active"] = false;
			S_Madagascar["mission"] = false;
			S_Madagascar["status"] = "";
			S_Madagascar["currentPopUps"] = new Array();
			S_Madagascar["landingQueue"] = new Array();
			S_Madagascar["landingApproachQueue"] = new Array();
			S_Madagascar["runways"] = 1;
			S_Madagascar["flightQueue"] = new Array();
			S_Madagascar["routes"] = 0;
			S_Madagascar["incomingroutes"] = 0;
			S_Madagascar["danger"] = false;
			S_Madagascar["appeared"] = false;
			S_Madagascar["priority"] = 1;
			S_Madagascar["startpriority"] = 1;
			S_Madagascar["terminal"] = false;
			S_Madagascar["planesHere"] = 0;
			S_Madagascar["relation"] = "Neutral";
			S_Mongolia["x"] = 683;
			S_Mongolia["y"] = 118;
			S_Mongolia["name"] = "Mongolia";
			S_Mongolia["city"] = "Ulan Bator";
			S_Mongolia["adjective"] = "Mongolian";
			S_Mongolia["population"] = 2.9;
			S_Mongolia["GDP"] = 5.8;
			S_Mongolia["popularity"] = 149;
			S_Mongolia["reputation"] = 0.1;
			S_Mongolia["bluereputation"] = 0.1;
			S_Mongolia["accessibility"] = true;
			S_Mongolia["active"] = false;
			S_Mongolia["mission"] = false;
			S_Mongolia["status"] = "";
			S_Mongolia["currentPopUps"] = new Array();
			S_Mongolia["landingQueue"] = new Array();
			S_Mongolia["landingApproachQueue"] = new Array();
			S_Mongolia["runways"] = 1;
			S_Mongolia["flightQueue"] = new Array();
			S_Mongolia["routes"] = 0;
			S_Mongolia["incomingroutes"] = 0;
			S_Mongolia["danger"] = false;
			S_Mongolia["appeared"] = false;
			S_Mongolia["priority"] = 2;
			S_Mongolia["startpriority"] = 2;
			S_Mongolia["terminal"] = false;
			S_Mongolia["planesHere"] = 0;
			S_Mongolia["relation"] = "Neutral";
			S_Nigeria["x"] = 409.5;
			S_Nigeria["y"] = 263;
			S_Nigeria["name"] = "Nigeria";
			S_Nigeria["city"] = "Lagos";
			S_Nigeria["adjective"] = "Nigerian";
			S_Nigeria["population"] = 178.5;
			S_Nigeria["GDP"] = 2.8;
			S_Nigeria["popularity"] = 76;
			S_Nigeria["reputation"] = 0.1;
			S_Nigeria["bluereputation"] = 0.1;
			S_Nigeria["accessibility"] = true;
			S_Nigeria["active"] = false;
			S_Nigeria["mission"] = false;
			S_Nigeria["status"] = "";
			S_Nigeria["currentPopUps"] = new Array();
			S_Nigeria["landingQueue"] = new Array();
			S_Nigeria["landingApproachQueue"] = new Array();
			S_Nigeria["runways"] = 1;
			S_Nigeria["flightQueue"] = new Array();
			S_Nigeria["routes"] = 0;
			S_Nigeria["incomingroutes"] = 0;
			S_Nigeria["danger"] = false;
			S_Nigeria["appeared"] = false;
			S_Nigeria["priority"] = 2;
			S_Nigeria["startpriority"] = 2;
			S_Nigeria["terminal"] = false;
			S_Nigeria["planesHere"] = 0;
			S_Nigeria["relation"] = "Neutral";
			S_Norway["x"] = 420;
			S_Norway["y"] = 73;
			S_Norway["name"] = "Norway";
			S_Norway["city"] = "Bergen";
			S_Norway["adjective"] = "Norwegian";
			S_Norway["population"] = 5;
			S_Norway["GDP"] = 54;
			S_Norway["popularity"] = 956;
			S_Norway["reputation"] = 0.1;
			S_Norway["bluereputation"] = 0.1;
			S_Norway["accessibility"] = true;
			S_Norway["active"] = false;
			S_Norway["mission"] = false;
			S_Norway["status"] = "";
			S_Norway["currentPopUps"] = new Array();
			S_Norway["landingQueue"] = new Array();
			S_Norway["landingApproachQueue"] = new Array();
			S_Norway["runways"] = 1;
			S_Norway["flightQueue"] = new Array();
			S_Norway["routes"] = 0;
			S_Norway["incomingroutes"] = 0;
			S_Norway["danger"] = false;
			S_Norway["appeared"] = true;
			S_Norway["priority"] = 2;
			S_Norway["startpriority"] = 2;
			S_Norway["terminal"] = false;
			S_Norway["planesHere"] = 0;
			S_Norway["relation"] = "Neutral";
			S_Poland["x"] = 456;
			S_Poland["y"] = 103;
			S_Poland["name"] = "Poland";
			S_Poland["city"] = "Warsaw";
			S_Poland["adjective"] = "Polish";
			S_Poland["population"] = 38;
			S_Poland["GDP"] = 21;
			S_Poland["popularity"] = 337;
			S_Poland["reputation"] = 0.1;
			S_Poland["bluereputation"] = 0.1;
			S_Poland["accessibility"] = true;
			S_Poland["active"] = false;
			S_Poland["mission"] = false;
			S_Poland["status"] = "";
			S_Poland["currentPopUps"] = new Array();
			S_Poland["landingQueue"] = new Array();
			S_Poland["landingApproachQueue"] = new Array();
			S_Poland["runways"] = 1;
			S_Poland["flightQueue"] = new Array();
			S_Poland["routes"] = 0;
			S_Poland["incomingroutes"] = 0;
			S_Poland["danger"] = false;
			S_Poland["appeared"] = true;
			S_Poland["priority"] = 2;
			S_Poland["startpriority"] = 2;
			S_Poland["terminal"] = false;
			S_Poland["planesHere"] = 0;
			S_Poland["relation"] = "Neutral";
			S_Portugal["x"] = 376;
			S_Portugal["y"] = 148;
			S_Portugal["name"] = "Portugal";
			S_Portugal["city"] = "Lisboa";
			S_Portugal["adjective"] = "Portuguese";
			S_Portugal["population"] = 10;
			S_Portugal["GDP"] = 23;
			S_Portugal["popularity"] = 1300;
			S_Portugal["reputation"] = 0.1;
			S_Portugal["bluereputation"] = 0.1;
			S_Portugal["accessibility"] = true;
			S_Portugal["active"] = false;
			S_Portugal["mission"] = false;
			S_Portugal["status"] = "";
			S_Portugal["currentPopUps"] = new Array();
			S_Portugal["landingQueue"] = new Array();
			S_Portugal["landingApproachQueue"] = new Array();
			S_Portugal["runways"] = 1;
			S_Portugal["flightQueue"] = new Array();
			S_Portugal["routes"] = 0;
			S_Portugal["incomingroutes"] = 0;
			S_Portugal["danger"] = false;
			S_Portugal["appeared"] = true;
			S_Portugal["priority"] = 2;
			S_Portugal["startpriority"] = 2;
			S_Portugal["terminal"] = false;
			S_Portugal["planesHere"] = 0;
			S_Portugal["relation"] = "Neutral";
			S_Russia["x"] = 505;
			S_Russia["y"] = 87;
			S_Russia["name"] = "Russia";
			S_Russia["city"] = "Moscow";
			S_Russia["adjective"] = "Russian";
			S_Russia["population"] = 144;
			S_Russia["GDP"] = 18;
			S_Russia["popularity"] = 168;
			S_Russia["reputation"] = 0.1;
			S_Russia["bluereputation"] = 0.1;
			S_Russia["accessibility"] = true;
			S_Russia["active"] = false;
			S_Russia["mission"] = false;
			S_Russia["status"] = "";
			S_Russia["currentPopUps"] = new Array();
			S_Russia["landingQueue"] = new Array();
			S_Russia["landingApproachQueue"] = new Array();
			S_Russia["runways"] = 1;
			S_Russia["flightQueue"] = new Array();
			S_Russia["routes"] = 0;
			S_Russia["incomingroutes"] = 0;
			S_Russia["danger"] = false;
			S_Russia["appeared"] = true;
			S_Russia["priority"] = 1;
			S_Russia["startpriority"] = 1;
			S_Russia["terminal"] = false;
			S_Russia["planesHere"] = 0;
			S_Russia["relation"] = "Neutral";
			S_Saudi_Arabia["x"] = 535;
			S_Saudi_Arabia["y"] = 197;
			S_Saudi_Arabia["name"] = "Arabia";
			S_Saudi_Arabia["city"] = "Riyadh";
			S_Saudi_Arabia["adjective"] = "Arabian";
			S_Saudi_Arabia["population"] = 30;
			S_Saudi_Arabia["GDP"] = 31;
			S_Saudi_Arabia["popularity"] = 524;
			S_Saudi_Arabia["reputation"] = 0.1;
			S_Saudi_Arabia["bluereputation"] = 0.1;
			S_Saudi_Arabia["accessibility"] = true;
			S_Saudi_Arabia["active"] = false;
			S_Saudi_Arabia["mission"] = false;
			S_Saudi_Arabia["status"] = "";
			S_Saudi_Arabia["currentPopUps"] = new Array();
			S_Saudi_Arabia["landingQueue"] = new Array();
			S_Saudi_Arabia["landingApproachQueue"] = new Array();
			S_Saudi_Arabia["runways"] = 1;
			S_Saudi_Arabia["flightQueue"] = new Array();
			S_Saudi_Arabia["routes"] = 0;
			S_Saudi_Arabia["incomingroutes"] = 0;
			S_Saudi_Arabia["danger"] = false;
			S_Saudi_Arabia["appeared"] = true;
			S_Saudi_Arabia["priority"] = 1;
			S_Saudi_Arabia["startpriority"] = 1;
			S_Saudi_Arabia["terminal"] = false;
			S_Saudi_Arabia["planesHere"] = 0;
			S_Saudi_Arabia["relation"] = "Neutral";
			S_Somalia["x"] = 535;
			S_Somalia["y"] = 277;
			S_Somalia["name"] = "Somalia";
			S_Somalia["city"] = "Mogadishu";
			S_Somalia["adjective"] = "Somalian";
			S_Somalia["population"] = 11;
			S_Somalia["GDP"] = 0.6;
			S_Somalia["popularity"] = 46;
			S_Somalia["reputation"] = 0.1;
			S_Somalia["bluereputation"] = 0.1;
			S_Somalia["accessibility"] = true;
			S_Somalia["active"] = false;
			S_Somalia["mission"] = false;
			S_Somalia["status"] = "";
			S_Somalia["currentPopUps"] = new Array();
			S_Somalia["landingQueue"] = new Array();
			S_Somalia["landingApproachQueue"] = new Array();
			S_Somalia["runways"] = 1;
			S_Somalia["flightQueue"] = new Array();
			S_Somalia["routes"] = 0;
			S_Somalia["incomingroutes"] = 0;
			S_Somalia["danger"] = false;
			S_Somalia["appeared"] = true;
			S_Somalia["priority"] = 2;
			S_Somalia["startpriority"] = 2;
			S_Somalia["terminal"] = false;
			S_Somalia["planesHere"] = 0;
			S_Somalia["relation"] = "Neutral";
			S_South_Africa["x"] = 467;
			S_South_Africa["y"] = 402;
			S_South_Africa["name"] = "South Africa";
			S_South_Africa["city"] = "Cape Town";
			S_South_Africa["adjective"] = "South African";
			S_South_Africa["population"] = 53;
			S_South_Africa["GDP"] = 11;
			S_South_Africa["popularity"] = 197;
			S_South_Africa["reputation"] = 0.1;
			S_South_Africa["bluereputation"] = 0.1;
			S_South_Africa["accessibility"] = true;
			S_South_Africa["active"] = false;
			S_South_Africa["mission"] = false;
			S_South_Africa["status"] = "";
			S_South_Africa["currentPopUps"] = new Array();
			S_South_Africa["landingQueue"] = new Array();
			S_South_Africa["landingApproachQueue"] = new Array();
			S_South_Africa["runways"] = 1;
			S_South_Africa["flightQueue"] = new Array();
			S_South_Africa["routes"] = 0;
			S_South_Africa["incomingroutes"] = 0;
			S_South_Africa["danger"] = false;		
			S_South_Africa["appeared"] = true;
			S_South_Africa["priority"] = 1;
			S_South_Africa["startpriority"] = 1;
			S_South_Africa["terminal"] = false;
			S_South_Africa["planesHere"] = 0;
			S_South_Africa["relation"] = "Neutral";
			S_Spain["x"] = 404;
			S_Spain["y"] = 140;
			S_Spain["name"] = "Spain";
			S_Spain["city"] = "Barcelona";
			S_Spain["adjective"] = "Spanish";
			S_Spain["population"] = 47;
			S_Spain["GDP"] = 30;
			S_Spain["popularity"] = 1415;
			S_Spain["reputation"] = 0.1;
			S_Spain["bluereputation"] = 0.1;
			S_Spain["accessibility"] = true;
			S_Spain["active"] = false;
			S_Spain["mission"] = false;
			S_Spain["status"] = "";
			S_Spain["currentPopUps"] = new Array();
			S_Spain["landingQueue"] = new Array();
			S_Spain["landingApproachQueue"] = new Array();
			S_Spain["runways"] = 1;
			S_Spain["flightQueue"] = new Array();
			S_Spain["routes"] = 0;
			S_Spain["incomingroutes"] = 0;
			S_Spain["danger"] = false;		
			S_Spain["appeared"] = true;
			S_Spain["priority"] = 2;
			S_Spain["startpriority"] = 2;
			S_Spain["terminal"] = false;
			S_Spain["planesHere"] = 0;
			S_Spain["relation"] = "Neutral";
			S_Sweden["x"] = 446;
			S_Sweden["y"] = 78;
			S_Sweden["name"] = "Sweden";
			S_Sweden["city"] = "Stockholm";
			S_Sweden["adjective"] = "Swedish";
			S_Sweden["population"] = 10;
			S_Sweden["GDP"] = 41;
			S_Sweden["popularity"] = 500;
			S_Sweden["reputation"] = 0.1;
			S_Sweden["bluereputation"] = 0.1;
			S_Sweden["accessibility"] = true;
			S_Sweden["active"] = false;
			S_Sweden["mission"] = false;
			S_Sweden["status"] = "";
			S_Sweden["currentPopUps"] = new Array();
			S_Sweden["landingQueue"] = new Array();
			S_Sweden["landingApproachQueue"] = new Array();
			S_Sweden["runways"] = 1;
			S_Sweden["flightQueue"] = new Array();
			S_Sweden["routes"] = 0;
			S_Sweden["incomingroutes"] = 0;
			S_Sweden["danger"] = false;		
			S_Sweden["appeared"] = true;
			S_Sweden["priority"] = 2;
			S_Sweden["startpriority"] = 2;
			S_Sweden["terminal"] = false;
			S_Sweden["planesHere"] = 0;
			S_Sweden["relation"] = "Neutral";
			S_Turkey["x"] = 491;
			S_Turkey["y"] = 145.5;
			S_Turkey["name"] = "Turkey";
			S_Turkey["city"] = "Ankara";
			S_Turkey["adjective"] = "Turkish";
			S_Turkey["population"] = 76;
			S_Turkey["GDP"] = 15.3;
			S_Turkey["popularity"] = 348;
			S_Turkey["reputation"] = 0.1;
			S_Turkey["bluereputation"] = 0.1;
			S_Turkey["accessibility"] = true;
			S_Turkey["active"] = false;
			S_Turkey["mission"] = false;
			S_Turkey["status"] = "";
			S_Turkey["currentPopUps"] = new Array();
			S_Turkey["landingQueue"] = new Array();
			S_Turkey["landingApproachQueue"] = new Array();
			S_Turkey["runways"] = 1;
			S_Turkey["flightQueue"] = new Array();
			S_Turkey["routes"] = 0;
			S_Turkey["incomingroutes"] = 0;
			S_Turkey["danger"] = false;		
			S_Turkey["appeared"] = true;
			S_Turkey["priority"] = 2;
			S_Turkey["startpriority"] = 2;
			S_Turkey["terminal"] = false;
			S_Turkey["planesHere"] = 0;
			S_Turkey["relation"] = "Neutral";
			S_Ukraine["x"] = 481;
			S_Ukraine["y"] = 108;
			S_Ukraine["name"] = "Ukraine";
			S_Ukraine["city"] = "Kiev";
			S_Ukraine["adjective"] = "Ukrainian";
			S_Ukraine["population"] = 43;
			S_Ukraine["GDP"] = 7;
			S_Ukraine["popularity"] = 375;
			S_Ukraine["reputation"] = 0.1;
			S_Ukraine["bluereputation"] = 0.1;
			S_Ukraine["accessibility"] = true;
			S_Ukraine["active"] = false;
			S_Ukraine["mission"] = false;
			S_Ukraine["status"] = "";
			S_Ukraine["currentPopUps"] = new Array();
			S_Ukraine["landingQueue"] = new Array();
			S_Ukraine["landingApproachQueue"] = new Array();
			S_Ukraine["runways"] = 1;
			S_Ukraine["flightQueue"] = new Array();
			S_Ukraine["routes"] = 0;
			S_Ukraine["incomingroutes"] = 0;
			S_Ukraine["danger"] = false;		
			S_Ukraine["appeared"] = true;
			S_Ukraine["priority"] = 2;
			S_Ukraine["startpriority"] = 2;
			S_Ukraine["terminal"] = false;
			S_Ukraine["planesHere"] = 0;
			S_Ukraine["relation"] = "Neutral";
			
	
			// ----------------------------------------------------
			airportDict["Algeria"] = S_Algeria;
			airportDict["America"] = S_America;
			airportDict["Argentina"] = S_Argentina;
			airportDict["Australia"] = S_Australia;
			airportDict["Brazil"] = S_Brazil;
			airportDict["Canada"] = S_Canada;
			airportDict["Congo"] = S_Congo;
			airportDict["China"] = S_China;
			airportDict["Denmark"] = S_Denmark;
			airportDict["Egypt"] = S_Egypt;
			airportDict["England"] = S_England;
			airportDict["France"] = S_France;
			airportDict["Germany"] = S_Germany;
			airportDict["Greece"] = S_Greece;
			airportDict["Greenland"] = S_Greenland;
			airportDict["Kenya"] = S_Kenya;
			airportDict["Iceland"] = S_Iceland;
			airportDict["India"] = S_India;
			airportDict["Indonesia"] = S_Indonesia;
			airportDict["Iran"] = S_Iran;
			airportDict["Italy"] = S_Italy;
			airportDict["Japan"] = S_Japan;
			airportDict["Libya"] = S_Libya;
			airportDict["Madagascar"] = S_Madagascar;
			airportDict["Mexico"] = S_Mexico;
			airportDict["Mongolia"] = S_Mongolia;
			airportDict["Nigeria"] = S_Nigeria;
			airportDict["Norway"] = S_Norway;
			airportDict["Poland"] = S_Poland;
			airportDict["Portugal"] = S_Portugal;
			airportDict["Russia"] = S_Russia;
			airportDict["Russia"] = S_Russia;
			airportDict["Arabia"] = S_Saudi_Arabia;
			airportDict["South Africa"] = S_South_Africa;
			airportDict["Somalia"] = S_Somalia;
			airportDict["Spain"] = S_Spain;
			airportDict["Sweden"] = S_Sweden;
			airportDict["Turkey"] = S_Turkey;
			airportDict["Ukraine"] = S_Ukraine;
		}
		
		private function resetEventDict():void
		{
			// RUNTIME EVENTS

			// SCHEDULED EVENTS:
			E_winterOlympics["String"] = "%TARGETCOUNTRY is scheduled to host the Winter Olympics this winter";
			E_winterOlympics["status"] = "Currently hosting the Winter Olympic Games.";
			E_winterOlympics["popularityMultiplier"] = 5;
			E_winterOlympics["populationMultiplier"] = 1;
			E_winterOlympics["GDPMultiplier"] = 1.1;
			E_winterOlympics["oilPriceMultiplier"] = false;
			E_winterOlympics["accessible"] = "";
			E_winterOlympics["spreadRisk"] = false;
			E_winterOlympics["radius"] = false;
			E_winterOlympics["month"] = 2;
			E_winterOlympics["mail"] = false;
			E_winterOlympics["mission"] = "Olympiad";
			E_winterOlympics["duration"] = 1;
			E_winterOlympics["countries"] = "Rich";
			E_winterOlympics["following"] = false;
			E_winterOlympics["ending"] = {
				"String": "The Olympic winter games in %TARGETCOUNTRY have ended.",
				"status": "",
				"popularityMultiplier": 0.2,
				"populationMultiplier": 1,
				"GDPMultiplier": 1,
				"oilPriceMultiplier": false,
				"accessible": "",
				"spreadRisk": false,
				"radius": false,
				"month": false,
				"mail": false,
				"mission": false,
				"duration": 0,
				"countries": "Airport",
				"following": false,
				"ending":false
				};
			scheduledEventArray[scheduledEventArray.length] = E_winterOlympics;
			E_summerOlympics["String"] = "%TARGETCOUNTRY is scheduled to host the Summer Olympics this summer.";
			E_summerOlympics["status"] = "Currently hosting the Summer Olympic Games.";
			E_summerOlympics["popularityMultiplier"] = 5;
			E_summerOlympics["populationMultiplier"] = 1;
			E_summerOlympics["GDPMultiplier"] = 1.1;
			E_summerOlympics["oilPriceMultiplier"] = false;
			E_summerOlympics["accessible"] = "";
			E_summerOlympics["spreadRisk"] = false;
			E_summerOlympics["radius"] = false;
			E_summerOlympics["month"] = 8;
			E_summerOlympics["mail"] = false;
			E_summerOlympics["mission"] = "Olympiad";
			E_summerOlympics["duration"] = 8;
			E_summerOlympics["countries"] = "Airport";
			E_summerOlympics["following"] = false;
			E_summerOlympics["ending"] = {
				"String": "The Olympic games in %TARGETCOUNTRY have ended.",
				"status": "",
				"popularityMultiplier": 0.2,
				"populationMultiplier": 1,
				"GDPMultiplier": 1,
				"oilPriceMultiplier": false,
				"accessible": "",
				"spreadRisk": false,
				"radius": false,
				"month": false,
				"mail": false,
				"mission": false,
				"duration": 0,
				"countries": "Airport",
				"following": false,
				"ending":false
				};
			scheduledEventArray[scheduledEventArray.length] = E_summerOlympics;
			E_worldCup["String"] = "%TARGETCOUNTRY is scheduled to host the FIFA World Cup this summer";
			E_worldCup["status"] = "Currently hosting the FIFA World Cup.";
			E_worldCup["popularityMultiplier"] = 10;
			E_worldCup["populationMultiplier"] = 1;
			E_worldCup["GDPMultiplier"] = 1.1;
			E_worldCup["oilPriceMultiplier"] = false;
			E_worldCup["accessible"] = "";
			E_worldCup["spreadRisk"] = false;
			E_worldCup["radius"] = false;
			E_worldCup["month"] = 5;
			E_worldCup["mail"] = false;
			E_worldCup["mission"] = "Footballer";
			E_worldCup["duration"] = 1;
			E_worldCup["countries"] = "Airport";
			E_worldCup["following"] = false;
			E_worldCup["ending"] = {
				"String": "The FIFA World Cup in %TARGETCOUNTRY has come to an end.",
				"status": "",
				"popularityMultiplier": 0.2,
				"populationMultiplier": 1,
				"GDPMultiplier": 1,
				"oilPriceMultiplier": false,
				"accessible": "",
				"spreadRisk": false,
				"radius": false,
				"month": false,
				"mail": false,
				"mission": false,
				"duration": 0,
				"countries": "Airport",
				"following": false,
				"ending":false
				};
			scheduledEventArray[scheduledEventArray.length] = E_worldCup;
		
			E_weatherPenalty["String"] = "One of your flights operating near %TARGETCOUNTRY has crashed as a result of mechanical failure; preliminary evidence suggests this failure was caused by the recently observed anomalous weather patterns.";
			E_weatherPenalty["status"] = "";
			E_weatherPenalty["popularityMultiplier"] = 1;
			E_weatherPenalty["populationMultiplier"] = 1;
			E_weatherPenalty["GDPMultiplier"] = 1;
			E_weatherPenalty["oilPriceMultiplier"] = false;
			E_weatherPenalty["accessible"] = "";
			E_weatherPenalty["spreadRisk"] = false;
			E_weatherPenalty["radius"] = false;
			E_weatherPenalty["month"] = 5;
			E_weatherPenalty["mail"] = false;
			E_weatherPenalty["mission"] = false;
			E_weatherPenalty["duration"] = 0;
			E_weatherPenalty["countries"] = false;
			E_weatherPenalty["following"] = false;
			E_weatherPenalty["ending"] = 
			{
				"String": "You are being fined by international regulatory organizations for continuing to operate in spite of dangerous weather conditions.",
				"status": "",
				"popularityMultiplier": 0.2,
				"populationMultiplier": 1,
				"GDPMultiplier": 1,
				"oilPriceMultiplier": false,
				"moneyChange": - 400000,
				"accessible": "",
				"spreadRisk": false,
				"radius": false,
				"month": false,
				"mail": false,
				"mission": false,
				"duration": 0,
				"countries": "Airport",
				"following": false,
				"ending":false
				};;
			scheduledEventArray[scheduledEventArray.length] = E_weatherPenalty;
			
			E_newCountryAppearance["String"] = "%TARGETCOUNTRY opened a new airport. The government says it is the beginning of a 'new era' for the nation.";
			E_newCountryAppearance["status"] = "";
			E_newCountryAppearance["popularityMultiplier"] = 1;
			E_newCountryAppearance["populationMultiplier"] = 1;
			E_newCountryAppearance["GDPMultiplier"] = 1;
			E_newCountryAppearance["oilPriceMultiplier"] = false;
			E_newCountryAppearance["accessible"] = "";
			E_newCountryAppearance["spreadRisk"] = false;
			E_newCountryAppearance["radius"] = false;
			E_newCountryAppearance["month"] = 1;
			E_newCountryAppearance["mail"] = false;
			E_newCountryAppearance["mission"] = "Air Government";
			E_newCountryAppearance["duration"] = 1;
			E_newCountryAppearance["countries"] = "NotYetAdded";
			E_newCountryAppearance["following"] = false;
			E_newCountryAppearance["ending"] = false;
			randomEventArray[randomEventArray.length] = E_newCountryAppearance;
			//scheduledEventArray[scheduledEventArray.length] = E_newCountryAppearance;
			
			eventDict["scheduled"] = scheduledEventArray;

			// ------------------------------------------------

			// RANDOM EVENTS:
			E_nuclearDisaster["String"] = "A nuclear plant near the %TARGETADJECTIVE city %TARGETCITY has suffered a meltdown.";
			E_nuclearDisaster["status"] = "Affected by a nuclear accident.";
			E_nuclearDisaster["popularityMultiplier"] = 0.5;
			E_nuclearDisaster["populationMultiplier"] = 1;
			E_nuclearDisaster["GDPMultiplier"] = 1;
			E_nuclearDisaster["oilPriceMultiplier"] = false;
			E_nuclearDisaster["accessible"] = "";
			E_nuclearDisaster["spreadRisk"] = false;
			E_nuclearDisaster["radius"] = false;
			E_nuclearDisaster["month"] = false;
			E_nuclearDisaster["mail"] = false;
			E_nuclearDisaster["mission"] = false;
			E_nuclearDisaster["duration"] = 0;
			E_nuclearDisaster["countries"] = "Nuclear";
			E_nuclearDisaster["ending"] = false;
			E_nuclearDisaster["following"] = new Array
			(
				{
				// Utfall 1
			 	"String": "The nuclear accident in %TARGETCOUNTRY continues to escalate. An uninhabitable area extending %RANDOMNUMBER0 kilometres in all directions has been officially called the 'zone of alienation' by government regulators. The goverment has also declared a state of emergency following riots in multiple cities, including %TARGETCITY.",
			 	"status": "Affected by a nuclear accident.",
				"popularityMultiplier": 0.5,
			 	"populationMultiplier": 0.8,
			 	"GDPMultiplier": 0.8,
				"oilPriceMultiplier": false,
			 	"accessible": "",
			 	"spreadRisk": false,
			 	"radius": false,
			 	"month": false,
				"mail": false,
				"mission": "Aid organization",
			 	"duration": 6,
			 	"countries": "Nuclear",
			 	"following": false,
			 	"ending": false
				},
			 	{
				// Utfall 2
				 "String": "The government in %TARGETCOUNTRY has successfully managed to avoid a nuclear explosion related to the recent meltdown in one of the country's nuclear plants near %TARGETCITY.",
			 	"status": "",
				"popularityMultiplier": 2,
			 	"populationMultiplier": 1,
			 	"GDPMultiplier": 1,
				"oilPriceMultiplier": false,
			 	"accessible": "",
			 	"spreadRisk": false,
			 	"radius": false,
			 	"month": false,
				"mail": false,
				"mission": "Aid organization",
			 	"duration": 0,
			 	"countries": "Nuclear",
			 	"following": false,
				"ending": false
				}
			)
			randomEventArray[randomEventArray.length] = E_nuclearDisaster;
			
			E_terroristAttack["String"] = "A terrorist attack has taken place in %TARGETCOUNTRY.";
			E_terroristAttack["status"] = "Recently hit by terrorism.";
			E_terroristAttack["popularityMultiplier"] = 0.5;
			E_terroristAttack["populationMultiplier"] = 1;
			E_terroristAttack["GDPMultiplier"] = 1;
			E_terroristAttack["oilPriceMultiplier"] = false;
			E_terroristAttack["accessible"] = "";
			E_terroristAttack["spreadRisk"] = "Terrorist";
			E_terroristAttack["radius"] = false;
			E_terroristAttack["month"] = false;
			E_terroristAttack["mail"] = false;
			E_terroristAttack["mission"] = false;
			E_terroristAttack["duration"] = 0;
			E_terroristAttack["countries"] = "Power";
			E_terroristAttack["following"] = false;
			E_terroristAttack["ending"] = 
			{
				"String": "The %CAUSEADJECTIVE government has officially declared war on %TARGETCOUNTRY. The decision was made subsequent to several findings which indicated a significant %TARGETADJECTIVE governmental contribution to the recent terrorist bombing in %CAUSECITY.",
				"status": "Being attacked by %CAUSECOUNTRY.",
				"popularityMultiplier": 0.5,
				"populationMultiplier": 1,
				"GDPMultiplier": 1,
				"CausePopularityMultiplier": 1,
				"CausePopulationMultiplier": 1,
				"CauseGDPMultiplier": 1,
				"oilPriceMultiplier": false,
				"accessible": "",
				"spreadRisk": false,
				"radius": false,
				"month": false,
				"mail": false,
				"mission": false,
				"duration": 0,
				"countries": "Nuclear",
				"ending": false,
				"following": new Array
				(
					{
					// Utfall 1
					"String": "The UN has denounced %CAUSECOUNTRY for reasons of accused military conquest and political terror following their invasion of %TARGETCOUNTRY. %CAUSECOUNTRY's military aggresion is alleged to be in violation of international law, and numerous economic sanctions have been imposed on %CAUSECOUNTRY in order to restore peace in the %TARGETADJECTIVE region.",
					"status": "Being attacked by %CAUSECOUNTRY.",
					"popularityMultiplier": 0.5,
					"populationMultiplier": 0.8,
					"GDPMultiplier": 1,
					"CausePopularityMultiplier": 0.2,
					"CausePopulationMultiplier": 1,
					"CauseGDPMultiplier": 0.5,
					"oilPriceMultiplier": false,
					"accessible": "",
					"spreadRisk": false,
					"radius": false,
					"month": false,
					"mail": false,
					"mission": false,
					"duration": 0,
					"countries": "Nuclear",
					"ending": false,
					"following": new Array
						(
							{
							// Utfall 1
							"String": "%CAUSECOUNTRY threatens to 'destroy global economy' as they finalize the annexation of northern regions of %TARGETCOUNTRY. Despite international condemnation there have been no signs of %CAUSEADJECTIVE willingness to give up their imperialist foreign policies.",
							"status": "Recently attacked by %CAUSECOUNTRY.",
							"popularityMultiplier": 0.5,
							"populationMultiplier": 1,
							"GDPMultiplier": 0.5,
							"CausePopularityMultiplier": 0.5,
							"CauseGDPMultiplier": 0.5,
							"oilPriceMultiplier": false,
							"accessible": "",
							"spreadRisk": false,
							"radius": false,
							"month": false,
							"mail": false,
							"mission": false,
							"duration": 0,
							"countries": "Nuclear",
							"following": false,
							"ending": false
							},
							{
							// Utfall 2
							"String": "%CAUSECOUNTRY has released an official apology for their premature invation of %TARGETCOUNTRY. Recent intellegence has debunked the accusations of %TARGETADJECTIVE contribution to the fatal terrorist attack in %CAUSECITY.",
							"status": "Recently attacked by %CAUSECOUNTRY.",
							"popularityMultiplier": 4,
							"populationMultiplier": 1,
							"GDPMultiplier": 1,
							"CausePopularityMultiplier": 10,
							"CausePopulationMultiplier": 1,
							"CauseGDPMultiplier": 4,
							"oilPriceMultiplier": false,
							"accessible": "",
							"spreadRisk": false,
							"radius": false,
							"month": false,
							"mail": false,
							"mission": false,
							"duration": 0,
							"countries": "Nuclear",
							"following": false,
							"ending": false
							}
						)
					},
					{
					// Utfall 2
					"String": "The %CAUSEADJECTIVE military intervention in %TARGETCOUNTRY has been regarded as 'totally legitimate' by the international community. Numerous nations have pledged support to %CAUSECOUNTRY in their war on terror. The regime forces, still loyal to the %TARGETADJECTIVE government and suffering from catastrophic losses at the battle of %TARGETCITY, is expected to capitulate shortly along with the collapse of the governmental authority in %TARGETCITY.",
					"status": "Being attacked by %CAUSECOUNTRY.",
					"popularityMultiplier": 0.1,
					"populationMultiplier": 1,
					"GDPMultiplier": 0.1,
					"CausePopularityMultiplier": 1,
					"CausePopulationMultiplier": 1,
					"CauseGDPMultiplier": 1,
					"oilPriceMultiplier": false,
					"accessible": "",
					"spreadRisk": false,
					"radius": false,
					"month": false,
					"mail": false,
					"mission": false,
					"duration": 0,
					"countries": "Nuclear",
					"following": false,
					"ending": 
						{
						"String": "The %CAUSEADJECTIVE military has successfully captured the governmental buildings in %TARGETCITY assited by international peacekeeping forces. After 'years of mismanagement' by the corrupt %TARGETADJECTIVE regime, the world is hoping that situation in %TARGETCOUNTRY will be stabilized through the planned democratic reforms.",
						"status": "Recently attacked by %CAUSECOUNTRY.",
						"popularityMultiplier": 10,
						"populationMultiplier": 1,
						"GDPMultiplier": 10,
						"CausePopularityMultiplier": 1,
						"CausePopulationMultiplier": 1,
						"CauseGDPMultiplier": 1,
						"oilPriceMultiplier": false,
						"accessible": "",
						"spreadRisk": false,
						"radius": false,
						"month": false,
						"mail": false,
						"mission": false,
						"duration": 0,
						"countries": "Nuclear",
						"following": false,
						"ending": false
						}
					}
				)
			};
			randomEventArray[randomEventArray.length] = E_terroristAttack;
			
			E_fatalVolcanicEruption["String"] = "A volcano near %TARGETCITY has erupted.";
			E_fatalVolcanicEruption["status"] = "Hit by volcanic eruption.";
			E_fatalVolcanicEruption["popularityMultiplier"] = 0.5;
			E_fatalVolcanicEruption["populationMultiplier"] = 0.5;
			E_fatalVolcanicEruption["GDPMultiplier"] = 0.8;
			E_fatalVolcanicEruption["oilPriceMultiplier"] = false;
			E_fatalVolcanicEruption["accessible"] = "";
			E_fatalVolcanicEruption["spreadRisk"] = false;
			E_fatalVolcanicEruption["radius"] = false;
			E_fatalVolcanicEruption["month"] = false;
			E_fatalVolcanicEruption["mail"] = false;
			E_fatalVolcanicEruption["mission"] = false;
			E_fatalVolcanicEruption["duration"] = 2;
			E_fatalVolcanicEruption["countries"] = "Volcano";
			E_fatalVolcanicEruption["following"] = new Array
			(
				{
				"String": "The ash cloud released from the volcanic eruption in %TARGETCOUNTRY is expected to disrupt air travel in neighboring countries as the jet stream continues to spread the cloud of hot ash.",
				"status": "Hit by volcanic eruption.",
				"popularityMultiplier": 2,
				"populationMultiplier": 1,
				"GDPMultiplier": 1.25,
				"oilPriceMultiplier": false,
				"accessible": false,
				"spreadRisk": false,
				"radius": 200,
				"month": false,
				"mail": false,
				"mission": false,
				"duration": 0,
				"countries": "Volcano",
				"following": false,
				"ending":
					{
					"String": "%TARGETCOUNTRY has closed its airspace following the volcanic eruption near %CAUSECITY.",
					"status": "Hit by volcanic eruption.",
					"popularityMultiplier": 1,
					"populationMultiplier": 1,
					"GDPMultiplier": 1,
					"oilPriceMultiplier": false,
					"accessible": false,
					"spreadRisk": false,
					"radius": false,
					"month": false,
					"mail": false,
					"mission": false,
					"duration": 1,
					"countries": "Volcano",
					"following": false,
					"ending":
						{
						"String": "%TARGETCOUNTRY has again opened its airspace.",
						"status": "",
						"popularityMultiplier": 1,
						"populationMultiplier": 1,
						"GDPMultiplier": 1,
						"oilPriceMultiplier": false,
						"accessible": true,
						"spreadRisk": false,
						"radius": false,
						"month": false,
						"mail": false,
						"mission": false,
						"duration": 1,
						"countries": "Volcano",
						"following": false,
						"ending":false
						}
					}
				}
			);
			E_fatalVolcanicEruption["ending"] = false;
			randomEventArray[randomEventArray.length] = E_fatalVolcanicEruption;	
			
			E_MilitaryCoup["String"] = "A revolutionary right wing extremist party in %TARGETCOUNTRY has taken control of the government with military force.";
			E_MilitaryCoup["status"] = "Affected by internal turmoil.";
			E_MilitaryCoup["popularityMultiplier"] = 0.5;
			E_MilitaryCoup["populationMultiplier"] = 1;
			E_MilitaryCoup["GDPMultiplier"] = 1;
			E_MilitaryCoup["oilPriceMultiplier"] = false;
			E_MilitaryCoup["accessible"] = "";
			E_MilitaryCoup["spreadRisk"] = false;
			E_MilitaryCoup["radius"] = false;
			E_MilitaryCoup["month"] = false;
			E_MilitaryCoup["mail"] = false;
			E_MilitaryCoup["mission"] = false;
			E_MilitaryCoup["duration"] = 1;
			E_MilitaryCoup["countries"] = "Airport";
			E_MilitaryCoup["ending"] = false;
			E_MilitaryCoup["following"] = new Array
				(
					{
					//Utfall 1
			 		"String": "The revolutionary party in %TARGETCOUNTRY has successfully driven the incumbent regime into permanent exile, declaring their leaders to be 'enemies of God'. A strict curfew has been imposed in the capital of %TARGETCOUNTRY. All resistance to the new government is being put down with deadly force.",
			 		"status": "Affected by internal turmoil.",
					"popularityMultiplier": 0.5,
			 		"populationMultiplier": 0.8,
			 		"GDPMultiplier": 0.8,
					"oilPriceMultiplier": false,
			 		"accessible": "",
			 		"spreadRisk": false,
			 		"radius": false,
			 		"month": false,
					"mail": false,
					"mission": false,
			 		"duration": 6,
			 		"countries": "Airport",
			 		"following": false,
			 		"ending": false
			 		},
			 		{
					//Utfall 2
			 		"String": "The coup staged by the revolutionary party in %TARGETCOUNTRY has been met with international opposition, resulting in an multinational invasion of the country, forcefully removing the revolutionary party from power before any damage could be done. The legitimate regime returned to power as citizens took to the streets in celebration.",
			 		"status": "",
					"popularityMultiplier": 2,
			 		"populationMultiplier": 1,
			 		"GDPMultiplier": 1,
					"oilPriceMultiplier": false,
			 		"accessible": "",
			 		"spreadRisk": false,
			 		"radius": false,
			 		"month": false,
					"mail": false,
					"mission": false,
			 		"duration": 0,
			 		"countries": "Nuclear",
			 		"following": false,
					"ending": false
					},
					{
					// Utfall 3
			 		"String": "The revolutionary party in %TARGETCOUNTRY has been fought to a standstill by a well armed resistance, fighting to reinstate the legitimate regime. The international community is worried that this might lead to civil war.",
			 		"status": "Affected by internal turmoil.",
					"popularityMultiplier": 2,
			 		"populationMultiplier": 1,
					"GDPMultiplier": 1,
					"oilPriceMultiplier": false,
			 		"accessible": "",
			 		"spreadRisk": false,
			 		"radius": false,
			 		"month": false,
					"mail": false,
					"mission": false,
			 		"duration": 0,
			 		"countries": "Nuclear",
			 		"following": false,
					"ending": E_CivilWar
					}
				);
			randomEventArray[randomEventArray.length] = E_MilitaryCoup;
			
			E_crimeSpree["String"] = "A newly founded criminal gang called %RANDOMGANG in %TARGETCITY has begun a violent crime spree."
			E_crimeSpree["status"] = "Affected by internal turmoil."
			E_crimeSpree["popularityMultiplier"] = 0.5;
			E_crimeSpree["popularityMultiplier"] = 0.5;
			E_crimeSpree["populationMultiplier"] = 1;
			E_crimeSpree["GDPMultiplier"] = 1;
			E_crimeSpree["oilPriceMultiplier"] = false;
			E_crimeSpree["accessible"] = "";
			E_crimeSpree["spreadRisk"] = false;
			E_crimeSpree["radius"] = false;
			E_crimeSpree["month"] = false;
			E_crimeSpree["mail"] = false;
			E_crimeSpree["mission"] = false;
			E_crimeSpree["duration"] = 1;
			E_crimeSpree["countries"] = "Airport";
			E_crimeSpree["ending"] = false;
			E_crimeSpree["following"] = new Array
			(
				{
				// Utfall 1
			 	"String": "The criminal gang called %GANG in %TARGETCITY has begun bribing politicians with important positions within law enforcement to ensure their safety, giving them more room to plunder the goods of the %TARGETADJECTIVE population.",
			 	"status": "Affected by internal turmoil.",
				"popularityMultiplier": 0.5,
			 	"populationMultiplier": 0.8,
			 	"GDPMultiplier": 0.8,
				"oilPriceMultiplier": false,
			 	"accessible": "",
			 	"spreadRisk": false,
			 	"radius": false,
			 	"month": false,
				"mail": false,
				"mission": false,
			 	"duration": 6,
			 	"countries": "Airport",
			 	"following": false,
			 	"ending":
			 	{
					// Ending 
					"String": "%GANG has successfully been eradicated by the %TARGETADJECTIVE law enforcement. The crime spree has subsequently come to a halt.",
					"status": "",
					"popularityMultiplier": 4,
					"populationMultiplier": 1,
					"GDPMultiplier": 1,
					"oilPriceMultiplier": false,
					"accessible": "",
					"spreadRisk": false,
					"radius": false,
					"month": false,
					"mail": false,
					"mission": false,
					"duration": 0,
					"countries": "Airport",
					"following": false,
					"ending":false
			 		}
				},
			 	{
				// Utfall 2
			 	"String": "The law enforcement of %TARGETCITY has successfully hunted down the top leaders of %GANG, resulting in a violent shootout with the gang taking hostages. The leaders of the gang was subsequently shot dead on the spot in a successful tactical operation led by %TARGETADJECTIVE special police forces.",
			 	"status": "",
				"popularityMultiplier": 2,
			 	"populationMultiplier": 1,
			 	"GDPMultiplier": 1,
				"oilPriceMultiplier": false,
			 	"accessible": "",
			 	"spreadRisk": false,
			 	"radius": false,
			 	"month": false,
				"mail": false,
				"mission": false,
			 	"duration": 0,
			 	"countries": "Nuclear",
			 	"following": false,
				"ending": false
				}
			)
			randomEventArray[randomEventArray.length] = E_crimeSpree;
			
			E_CivilWar["String"] = "Civil war has begun in %TARGETCOUNTRY.";
			E_CivilWar["status"] = "Affected by internal turmoil.";
			E_CivilWar["popularityMultiplier"] = 0.5;
			E_CivilWar["populationMultiplier"] = 1;
			E_CivilWar["GDPMultiplier"] = 1;
			E_CivilWar["oilPriceMultiplier"] = false;
			E_CivilWar["accessible"] = "";
			E_CivilWar["spreadRisk"] = false;
			E_CivilWar["radius"] = false;
			E_CivilWar["month"] = false;
			E_CivilWar["mail"] = false;
			E_CivilWar["mission"] = false;
			E_CivilWar["duration"] = 1;
			E_CivilWar["countries"] = "Airport";
			E_CivilWar["ending"] = false
			E_CivilWar["following"] = new Array
			(
				{
				// Utfall 1
			 	"String": "The revolutionary party in %TARGETCOUNTRY has successfully driven the incumbent regime into permanent exile, declaring their leaders to be 'enemies of God'. A strict curfew has been imposed in the capital of %TARGETCITY. All resistance to the new government is being put down with deadly force",
			 	"status": "Affected by internal turmoil.",
				"popularityMultiplier": 0.5,
			 	"populationMultiplier": 0.8,
			 	"GDPMultiplier": 0.8,
				"oilPriceMultiplier": false,
			 	"accessible": "",
			 	"spreadRisk": false,
			 	"radius": false,
			 	"month": false,
				"mail": false,
				"mission": false,
			 	"duration": 0,
			 	"countries": "Airport",
			 	"following": false,
			 	"ending": false
				},
			 	{
				// Utfall 2
			 	"String": "The coup staged by the revolutionary party in %TARGETCOUNTRY has been met with international opposition, resulting in an multinational invasion of the country, forcefully removing the revolutionary party from power before any damage could be done. The legitimate regime returned to power as citizens took to the streets in celebration.",
			 	"status": "",
				"popularityMultiplier": 2,
			 	"populationMultiplier": 1,
			 	"GDPMultiplier": 1,
				"oilPriceMultiplier": false,
			 	"accessible": "",
			 	"spreadRisk": false,
			 	"radius": false,
			 	"month": false,
				"mail": false,
				"mission": false,
			 	"duration": 0,
			 	"countries": "Airport",
			 	"following": false,
				"ending": false
				},
				// Utfall 3
				{
			 	"String": "The war between right-wing and left-wing forces in %TARGETCOUNTRY intensifies, with ground to air missiles being fired at passenger and emergency aircraft out of suspicion of foreign espionage.",
			 	"status": "",
				"popularityMultiplier": 0.5,
			 	"populationMultiplier": 1,
			 	"GDPMultiplier": 1,
				"oilPriceMultiplier": false,
			 	"accessible": "",
			 	"spreadRisk": false,
			 	"radius": false,
				"danger": true,
			 	"month": false,
				"mail": false,
				"mission": false,
			 	"duration": 1,
			 	"countries": "Airport",
			 	"following": false,
				"ending": {
					"String": "Attacks against civilian aircraft flying through the airspace of %TARGETCOUNTRY have ceased following the announcement of exploratory peace talks.",
			 		"status": "",
					"popularityMultiplier": 2,
					"populationMultiplier": 1,
					"GDPMultiplier": 1,
					"oilPriceMultiplier": false,
					"accessible": "",
					"spreadRisk": false,
					"radius": false,
					"danger": false,
					"month": false,
					"mail": false,
					"mission": false,
					"duration": 1,
					"countries": "Airport",
					"following": false,
					"ending": false
				}
				}
				
			)
			randomEventArray[randomEventArray.length] = E_CivilWar;
			
			E_foundOil["String"] = "Up to %RANDOMNUMBER00 billion barrels of oil have been discovered in the %TARGETADJECTIVE outback. Global gasoline prices are dropping dramatically.";
			E_foundOil["status"] = "Recently found oil.";
			E_foundOil["popularityMultiplier"] = 1;
			E_foundOil["populationMultiplier"] = 1;
			E_foundOil["GDPMultiplier"] = 1.2;
			E_foundOil["oilPriceMultiplier"] = -20;
			E_foundOil["accessible"] = "";
			E_foundOil["spreadRisk"] = false;
			E_foundOil["radius"] = false;
			E_foundOil["month"] = false;
			E_foundOil["mail"] = false;
			E_foundOil["mission"] = false;
			E_foundOil["duration"] = 1;
			E_foundOil["countries"] = "HasOil";
			E_foundOil["following"] = false;
			E_foundOil["ending"] = {
					"String": "Global fuel prices have stabilized themselves to the level prior to the recent oil discovery in %TARGETCOUNTRY.",
					"status": "Recently found oil.",
					"popularityMultiplier": 1,
					"populationMultiplier": 1,
					"GDPMultiplier": 1,
					"oilPriceMultiplier": 20,
					"accessible": "",
					"spreadRisk": false,
					"radius": false,
					"month": false,
					"mail": false,
					"mission": false,
					"duration": 0,
					"countries": "Airport",
					"following": false,
					"ending":false
					};
			randomEventArray[randomEventArray.length] = E_foundOil; 
			
			E_BandSuccess["String"] = "Legendary electronic musician %RANDOMBAND is currently on a nationwide tour in %TARGETCOUNTRY. The famous artist has also shared on social media that he is planning on visiting another European country afterwards.";
			E_BandSuccess["status"] = "";
			E_BandSuccess["popularityMultiplier"] = 2.0;
			E_BandSuccess["populationMultiplier"] = 1;
			E_BandSuccess["GDPMultiplier"] = 1;
			E_BandSuccess["oilPriceMultiplier"] = false;
			E_BandSuccess["accessible"] = "";
			E_BandSuccess["spreadRisk"] = "Europe";
			E_BandSuccess["radius"] = false;
			E_BandSuccess["month"] = false;
			E_BandSuccess["mail"] = false;
			E_BandSuccess["mission"] = false;
			E_BandSuccess["duration"] = 2; //2
			E_BandSuccess["countries"] = "Europe";
			E_BandSuccess["following"] = false
			E_BandSuccess["ending"] = {
				"String": "On his final concert in %CAUSECOUNTRY, %BAND confirmed that he will be performing at multiple festivals in %TARGETCOUNTRY during the next two months. His upcoming concerts were sold out in seconds.",
				"status": "",
				"popularityMultiplier": 2,
				"populationMultiplier": 1,
				"GDPMultiplier": 1,
				"CausePopularityMultiplier": 0.5,
				"CausePopulationMultiplier": 1,
				"CauseGDPMultiplier": 1,
				"oilPriceMultiplier": false,
				"accessible": "",
				"spreadRisk": false,
				"radius": false,
				"month": false,
				"mail": false,
				"mission": false,
				"duration": 3, //3
				"countries": "Europe",
				"following": false,
				"ending": 
					{
					"String": "%BAND's tour in %TARGETCOUNTRY has ended.",
					"status": "",
					"popularityMultiplier": 0.5,
					"populationMultiplier": 1,
					"GDPMultiplier": 1,
					"CausePopularityMultiplier": 1,
					"CausePopulationMultiplier": 1,
					"CauseGDPMultiplier": 1,
					"oilPriceMultiplier": false,
					"accessible": "",
					"spreadRisk": false,
					"radius": false,
					"month": false,
					"mail": false,
					"mission": false,
					"duration": 0,
					"countries": "Europe",
					"following": false,
					"ending": false
					}
				};;
			randomEventArray[randomEventArray.length] = E_BandSuccess;
			
			E_RacistVideo["String"] = "A video of your airline's air staff treating a customer with racist contempt has gone viral on the internet, with over %RANDOMNUMBER0 million views.";
			E_RacistVideo["status"] = "";
			E_RacistVideo["popularityMultiplier"] = 0.5;
			E_RacistVideo["populationMultiplier"] = 1;
			E_RacistVideo["GDPMultiplier"] = 1;
			E_RacistVideo["oilPriceMultiplier"] = false;
			E_RacistVideo["accessible"] = "";
			E_RacistVideo["spreadRisk"] = false;
			E_RacistVideo["radius"] = false;
			E_RacistVideo["month"] = false;
			E_RacistVideo["mail"] = false;
			E_RacistVideo["mission"] = false;
			E_RacistVideo["duration"] = 1;
			E_RacistVideo["countries"] = "Active";
			E_RacistVideo["following"] = false
			E_RacistVideo["ending"] = {
				"String": false,
				"status": "",
				"popularityMultiplier": 2,
				"populationMultiplier": 1,
				"GDPMultiplier": 1,
				"oilPriceMultiplier": false,
				"accessible": "",
				"spreadRisk": false,
				"radius": false,
				"month": false,
				"mail": ["Carter DuPont", "Status Report", "Everyone in %TARGETCOUNTRY seems to have forgotten your blatantly racist staff, woohoo!", "Spam", false],
				"mission": false,
				"duration": 1,
				"countries": "Active",
				"following": false,
				"ending": false
				};
				
			E_Malaria["String"] = "The %TARGETADJECTIVE government has closed off all borders due to an outbreak of malaria. All flights to and from %TARGETCOUNTRY have been cancelled";
			E_Malaria["status"] = "Malaria outbrake.";
			E_Malaria["popularityMultiplier"] = 0.5;
			E_Malaria["populationMultiplier"] = 0.8;
			E_Malaria["GDPMultiplier"] = 0.8;
			E_Malaria["oilPriceMultiplier"] = false;
			E_Malaria["accessible"] = false;
			E_Malaria["spreadRisk"] = false;
			E_Malaria["radius"] = false;
			E_Malaria["month"] = false;
			E_Malaria["mail"] = false;
			E_Malaria["mission"] = false;
			E_Malaria["duration"] = 1;
			E_Malaria["countries"] = "Malaria";
			E_Malaria["following"] = false;
			E_Malaria["ending"] = {
				"String": "The %TARGETADJECTIVE government has reopened the country's borders.",
				"status": "",
				"popularityMultiplier": 2,
				"populationMultiplier": 1.25,
				"GDPMultiplier": 1.25,
				"oilPriceMultiplier": false,
				"accessible": true,
				"spreadRisk": false,
				"radius": false,
				"month": false,
				"mail": false,
				"mission": false, 
				"duration": 1,
				"countries": "Malaria",
				"following": false,
				"ending": false
				};
			randomEventArray[randomEventArray.length] = E_Malaria;
			
			E_Pirates["String"] = "%TARGETADJECTIVE pirates claim to have taken western hostages. The nationality of the hostages is still unknown.";
			E_Pirates["status"] = "";
			E_Pirates["popularityMultiplier"] = 1;
			E_Pirates["populationMultiplier"] = 1;
			E_Pirates["GDPMultiplier"] = 1;
			E_Pirates["oilPriceMultiplier"] = false;
			E_Pirates["accessible"] = "";
			E_Pirates["spreadRisk"] = "Rich";
			E_Pirates["radius"] = false;
			E_Pirates["month"] = false;
			E_Pirates["mail"] = false;
			E_Pirates["mission"] = false;
			E_Pirates["duration"] = 0;
			E_Pirates["countries"] = "Pirate";
			E_Pirates["following"] = false;
			E_Pirates["ending"] = 
			{
				"String": "It has been confirmed that the victims of the recent kidnapping near the coast of %CAUSECOUNTRY are %TARGETADJECTIVE citizens.",
				"status": "",
				"popularityMultiplier": 1,
				"populationMultiplier": 1,
				"GDPMultiplier": 1,
				"CausePopularityMultiplier": 1,
				"CausePopulationMultiplier": 1,
				"CauseGDPMultiplier": 1,
				"oilPriceMultiplier": false,
				"accessible": false,
				"spreadRisk": false,
				"radius": false,
				"month": false,
				"mail": false,
				"mission": false,
				"duration": 0,
				"countries": "Rich",
				"following": new Array(
					{
					// Utfall 1
					"String": "The %TARGETADJECTIVE government has stated that a military operation in order to free the sailors being held hostage in %CAUSECOUNTRY will be initiated due to the pirates' unwillingness to accept a ransom.",
					"status": "",
					"popularityMultiplier": 1,
					"populationMultiplier": 1,
					"GDPMultiplier": 1,
					"CausePopularityMultiplier": 1,
					"CausePopulationMultiplier": 1,
					"CauseGDPMultiplier": 1,
					"oilPriceMultiplier": false,
					"accessible": false,
					"spreadRisk": false,
					"radius": false,
					"month": false,
					"mail": false,
					"mission": "Pirates",
					"duration": 1,
					"countries": "Rich",
					"following": false,
					"ending": false
					},
					{
					// Utfall 2
					"String": "The %TARGETADJECTIVE sailors have returned to %TARGETCOUNTRY after being held hostage by %CAUSEADJECTIVE pirates. One of the pirates involved in the incident is claiming that they recieved a ransom of %RANDOMNUMBER0 millions dollars for releasing the hostages. However, the %TARGETADJECTIVE government has refused to comment these speculations.",
					"status": "",
					"popularityMultiplier": 1,
					"populationMultiplier": 1,
					"GDPMultiplier": 1,
					"CausePopularityMultiplier": 1,
					"CausePopulationMultiplier": 1.2,
					"CauseGDPMultiplier": 1,
					"oilPriceMultiplier": false,
					"accessible": false,
					"spreadRisk": false,
					"radius": false,
					"month": false,
					"mail": false,
					"mission": false,
					"duration": 1,
					"countries": "Rich",
					"following": false,
					"ending": false
					}
				),
				"ending": false
			}
			
			randomEventArray[randomEventArray.length] = E_Pirates;
			
			E_foundOil2["String"] = "Drilling in Antartica has revealed a huge oil reserve under sheet ice. Global fuel prices are falling.";
			E_foundOil2["status"] = "Recently found oil.";
			E_foundOil2["popularityMultiplier"] = 1;
			E_foundOil2["populationMultiplier"] = 1;
			E_foundOil2["GDPMultiplier"] = 1;
			E_foundOil2["oilPriceMultiplier"] = 20;
			E_foundOil2["accessible"] = "";
			E_foundOil2["spreadRisk"] = false;
			E_foundOil2["radius"] = false;
			E_foundOil2["month"] = false;
			E_foundOil2["mail"] = false;
			E_foundOil2["mission"] = false;
			E_foundOil2["duration"] = 1;
			E_foundOil2["countries"] = false;
			E_foundOil2["following"] = false;
			E_foundOil2["ending"] = {
				"String": "Global fuel prices have stabilized themselves to the level prior to the recent oil discovery in Antarctica.",
				"status": "Recently found oil.",
				"popularityMultiplier": 1,
				"populationMultiplier": 1,
				"GDPMultiplier": 1,
				"oilPriceMultiplier": -20,
				"accessible": "",
				"spreadRisk": false,
				"radius": false,
				"month": false,
				"mail": false,
				"mission": false,
				"duration": 1,
				"countries": false,
				"following": false,
				"ending": false
				};
			randomEventArray[randomEventArray.length] = E_foundOil2;
			
			E_FreakyWeather["String"] = "Freak weather patterns in %TARGETCOUNTRY have caused increased foreign interest, but airlines warn of the danger of air travel in the region.";
			E_FreakyWeather["status"] = "";
			E_FreakyWeather["popularityMultiplier"] = 2;
			E_FreakyWeather["populationMultiplier"] = 1;
			E_FreakyWeather["GDPMultiplier"] = 1;
			E_FreakyWeather["oilPriceMultiplier"] = false;
			E_FreakyWeather["accessible"] = "";
			E_FreakyWeather["spreadRisk"] = false;
			E_FreakyWeather["radius"] = false;
			E_FreakyWeather["danger"] = true;
			E_FreakyWeather["month"] = false;
			E_FreakyWeather["mail"] = false;
			E_FreakyWeather["mission"] = false;
			E_FreakyWeather["duration"] = 4;
			E_FreakyWeather["countries"] = "Tsunami";
			E_FreakyWeather["following"] = false
			E_FreakyWeather["ending"] = {
				"String": "The explosion in tourism in %TARGETCOUNTRY is reversing as the freak weather patterns in that region have subsided.",
				"status": "",
				"popularityMultiplier": 0.5,
				"populationMultiplier": 1,
				"GDPMultiplier": 1,
				"oilPriceMultiplier": false,
				"accessible": "",
				"spreadRisk": false,
				"radius": false,
				"danger": false,
				"month": false,
				"mail": false,
				"mission": false,
				"duration": 3,
				"countries": "Tsunami",
				"following": false,
				"ending": false
				};;
			randomEventArray[randomEventArray.length] = E_FreakyWeather;
			
			// NEEDS WORK
			E_plague["String"] = "A new type of plague has been discovered in %TARGETCOUNTRY. Doctors say if uncontrolled, it could have a similar death toll to the Spanish Flu.";
			E_plague["status"] = "Plague outbrake.";
			E_plague["popularityMultiplier"] = 0.5;
			E_plague["populationMultiplier"] = 0.8;
			E_plague["GDPMultiplier"] = 0.8;
			E_plague["oilPriceMultiplier"] = false;
			E_plague["accessible"] = false;
			E_plague["spreadRisk"] = false;
			E_plague["radius"] = false;
			E_plague["month"] = false;
			E_plague["mail"] = false;
			E_plague["mission"] = false;
			E_plague["duration"] = 1;
			E_plague["countries"] = "Malaria";
			E_plague["ending"] = false;
			E_plague["following"] = new Array(
				{
					"String": "The plague containment measures in %TARGETCOUNTRY have failed; symptoms of the epidemic have been spotted in neighboring countries.",
					"status": "",
					"popularityMultiplier": 1,
					"populationMultiplier": 1,
					"GDPMultiplier": 1,
					"oilPriceMultiplier": false,
					"accessible": "",
					"spreadRisk": false,
					"radius": false,
					"month": false,
					"mail": false,
					"mission": false, 
					"duration": 1,
					"countries": "Malaria",
					"following": false, // spread
					"ending": false // spppperead
				},
				{
					"String": "National borders surrounding %TARGETCOUNTRY have reopened following the succesful synthesis of a vaccine, bringing the epidemic to a close.",
					"status": "",
					"popularityMultiplier": 2,
					"populationMultiplier": 1.25,
					"GDPMultiplier": 1.25,
					"oilPriceMultiplier": false,
					"accessible": true,
					"spreadRisk": false,
					"radius": false,
					"month": false,
					"mail": false,
					"mission": false, 
					"duration": 1,
					"countries": "Malaria",
					"following": false,
					"ending": false
				});
			randomEventArray[randomEventArray.length] = E_plague;
			
			E_CometVisible["String"] = "Astronomers predict %RANDOMCOMET will only be visible in %TARGETCOUNTRY. Those missing the event will have to wait for another %RANDOMNUMBER%RANDOMNUMBER years.";
			E_CometVisible["status"] = "";
			E_CometVisible["popularityMultiplier"] = 5;
			E_CometVisible["populationMultiplier"] = 1;
			E_CometVisible["GDPMultiplier"] = 1.1;
			E_CometVisible["oilPriceMultiplier"] = false;
			E_CometVisible["accessible"] = "";
			E_CometVisible["spreadRisk"] = false;
			E_CometVisible["radius"] = false;
			E_CometVisible["month"] = false;
			E_CometVisible["mail"] = false;
			E_CometVisible["mission"] = false;
			E_CometVisible["duration"] = 1;
			E_CometVisible["countries"] = "Airport";
			E_CometVisible["following"] = false
			E_CometVisible["ending"] = {
				"String": "The tourism boom enjoyed by %TARGETCOUNTRY has ended following the passing of %COMET.",
				"status": "",
				"popularityMultiplier": 0.2,
				"populationMultiplier": 1,
				"GDPMultiplier": 1,
				"oilPriceMultiplier": false,
				"accessible": "",
				"spreadRisk": false,
				"radius": false,
				"month": false,
				"mail": false,
				"mission": false,
				"duration": 1,
				"countries": "Airport",
				"following": false,
				"ending": false
				};;
			
			randomEventArray[randomEventArray.length] = E_CometVisible;
			
			
			
			eventDict["random"] = randomEventArray;
		}
		
		private function resetMissions():void
		{
			organizations["Aid organization"] = 
			{
				"string": ["Aid organization", "Transport me", "Hi. In order to help the victims of the nuclear disaster in %COUNTRY, we need our doctors to be transported there from %ORIGIN. You will be rewarded if you do us this service.", "An aid organization has requested your help to transport doctors to %COUNTRY from here.", "An aid organization has requested your help to transport doctors here from %ORIGIN."], 
				"countries": "Rich",
				"tcountries": false,
				"endings": [["Aid organization", "Payment", "Thanks. Our doctors successfully managed to reduce the scale of the disastrous disastrous in %COUNTRY.", "MissionReward", false]],
				"expires": 60,
				"type": "transport",
				"relation": "Neutral"
			}
			organizations["Olympiad"] = 
			{
				"string": ["%Olympiad", "Transport me", "Hello. I am an olympiad from %ORIGIN. Can you please escort me to %TARGETCOUNTRY? You will be payed.", "An olympiad has requested a ride from here to the olympic games in %COUNTRY", "An olympiad has requested a ride from %ORIGIN to the olympic games in this country."], 
				"countries": "Rich",
				"tcountries": false,
				"endings": [["Olympiad", "Payment", "Thanks for getting me to the Olympic games in %COUNTRY. Please accept this reward.", "MissionReward", false]],
				"expires": 30,
				"type": "transport",
				"relation": "Neutral"
			}
			organizations["Footballer"] = 
			{
				"string": ["Footballer", "Transport me", "Hello. I am a football player from %ORIGIN. Can you escort me to the World Cup in %COUNTRY.", "A footballer from this country needs a ride to the world cup in %COUNTRY", "A footbaler from %ORIGIN needs a ride to the world cup."], 
				"countries": "Rich",
				"tcountries": false,
				"endings": [["Footballer", "Payment", "Thanks for getting me to the World Cup in %COUNTRY. Please accept this reward.", "MissionReward", false]],
				"expires": 30,
				"type": "transport",
				"relation": "Neutral"
			}
			organizations["Air Government"] = 
			{
				"string": ["%COUNTRY", "Set up route", "We have recently established a new airport in our country. We will pay you if you set up routes involving %COUNTRY. We have also offered other airlines the same. This is exclusive.", "", "The %COUNTRYADJECTIVE government would like you to set up routes to or from this airport."], 
				"countries": false,
				"tcountries": false,
				"endings": [["%COUNTRY", "Mission Status", "To receive your reward you must first succesfully complete 30 flights.", "Spam", false]],
				"expires": 60,
				"type": "setUpRoute",
				"relation": "Friendly"
			}
			organizations["Terrorist Cell"] =
			{
				"string": ["Terrorist Cell", "Transportation", "Hi. We're planning a terrorist attack in %COUNTRY. Would you like to transport us from %ORIGIN?", "Terrorist cell needs to be transported from here to %COUNTRY", "Terrorist cell needs to be transported from %ORIGIN to here."],
				"countries": "Poor",
				"tcountries": "Rich",
				"endings": [["Terrorist Cell", "Mission Reward", "Thanks for getting us into %COUNTRY", "MissionReward", false], ["%COUNTRY government", "Request", "We disapprove of your actions in our country and request that you disband your terminal from our country.", "Spam", false]],
				"expires": 60,
				"type": "transport",
				"relation": "War"
			}
			organizations["Pirates"] =
			{
				"string": ["%ORIGIN", "Transportation", "The recent kidnapping in %COUNTRY has forced us to send military personnel there. However, we don't have sufficient airplanes, and need your company to help out. You will be rewarded.", "The %ORIGINADJECTIVE military needs transport to %COUNTRY", "The %ORIGINADJECTIVE military needs transport to here"],
				"countries": "Poor",
				"tcountries": "Rich",
				"endings": [["%ORIGIN", "Mission Reward", "Thanks for your help getting us into %COUNTRY", "MissionReward", false]],
				"expires": 60,
				"type": "targetedtransport",
				"relation": "Friendly"
			}
		}
		
		private function rejectMail(evt:MouseEvent):void
		{
			//delete Mail.expiringMails[maildg.getItemAt(maildg.selectedIndex)["mailID"]];
			bigMailBox.visible = false;
			currentMail = undefined;
			maildp.removeItemAt(maildg.selectedIndex);
			mailText.text = String(int(Main.mailText.text) - 1);
			mailText.setTextFormat(importantRedFormatLeft);
			maildg.selectedIndex = -1;
			
			if (int(Main.mailText.text) == 0)
			{
				Main.mailIcon.alpha = 0.5;
			}
			stage.focus=stage;
		}
		
		private function acceptMail(evt:MouseEvent):void
		{			
			if (Main.tutorial == true && Main.tutorialStep == 2 && Main.currentMailFrom == "Carter DuPont")
			{
				Main.tutorialStep = 3;
				Main.hoverbox.visible = true;
				Main.hoverVis = true;
				player.highLight();
				Main.hovertext.setTextFormat(Main.hoverformat);
			}
			
			else if (Main.tutorial == true && Main.tutorialStep == 15 && Main.currentMailFrom == "Carter DuPont")
			{
				Main.tutorialStep = 16;
				Main.hoverbox.visible = true;
				Main.hoverVis = true;
				Main.collectedAirportDict["Denmark"].highLight();
				Main.collectedAirportDict["Poland"].highLight();
				Main.collectedAirportDict["Ukraine"].highLight();
				Main.hovertext.text = "So buy terminals in Denmark, Poland and Ukraine";
				Main.TUTORIALTEXT = "So buy terminals in Denmark, Poland and Ukraine";
				Main.hovertext.setTextFormat(Main.hoverformat);
			}
		
			delete Mail.expiringMails[maildg.getItemAt(maildg.selectedIndex)["mailID"]];
			bigMailBox.visible = false;
			maildp.removeItemAt(maildg.selectedIndex);
			//trace(String(int(Main.mailText.text) - 1));
			mailText.text = String(int(Main.mailText.text) - 1);
			mailText.setTextFormat(importantRedFormatLeft);
			maildg.selectedIndex = -1;
			if (int(Main.mailText.text) == 0)
			{
				Main.mailIcon.alpha = 0.5;
			}
			
			if (currentMail.Type == "MissionRequest")
			{
				currentMissions[currentMissions.length] = currentMail.pMyParent;
				
				for each (var airportIns in collectedAirportArray)
				{
					if (airportIns.country == currentMail.pMyParent.origin || airportIns.country == currentMail.pMyParent.country)
					{
						if (Airport.currentSelect == airportIns.country)
						{
							airportIns.greenAirportB.visible = true;
							airportIns.airportB.visible = false;
						}
						else
						{
							airportIns.greenAirport.visible = true;
							airportIns.airportS.visible = false;
						}
					}
				}
			}
			
			else if (currentMail.Type == "MissionReward")
			{				
				cash_field.text = String(Math.round(Number(cash_field.text)+currentMail.pMyParent.payment));
				cash_field.setTextFormat(cash_format);
										
				if (currentMail.pMyParent.origin != false)
				{
					//trace(currentMail.pMyParent.origin);
					if (Main.currentLocation == currentMail.pMyParent.origin)
					{
						Main.collectedAirportDict[currentMail.pMyParent.origin].greenAirportB.visible = false;
						if (Main.airportDict[currentMail.pMyParent.origin]["terminal"] == true)
						{
							Main.collectedAirportDict[currentMail.pMyParent.origin].blueAirportB.visible = true;
						}
						else
						{
							Main.collectedAirportDict[currentMail.pMyParent.origin].airportB.visible = true;
						}
					}
					else
					{
						Main.collectedAirportDict[currentMail.pMyParent.origin].greenAirport.visible = false;
						if (Main.airportDict[currentMail.pMyParent.origin]["terminal"] == true)
						{
							Main.collectedAirportDict[currentMail.pMyParent.origin].blueAirport.visible = true;
							Main.collectedAirportDict[currentMail.pMyParent.origin].blueAirportB.visible = false;
						}
						else
						{
							Main.collectedAirportDict[currentMail.pMyParent.origin].airportS.visible = true;
							Main.collectedAirportDict[currentMail.pMyParent.origin].airportB.visible = false;
						}
					}
				}
				
				if (currentMail.pMyParent.country != false)
				{					
					if (Main.currentLocation == currentMail.pMyParent.country)
					{
						Main.collectedAirportDict[currentMail.pMyParent.country].greenAirportB.visible = false;
						Main.collectedAirportDict[currentMail.pMyParent.country].airportB.visible = true;
					}
					else
					{
						Main.collectedAirportDict[currentMail.pMyParent.country].greenAirport.visible = false;
						Main.collectedAirportDict[currentMail.pMyParent.country].airportS.visible = true;
					}
				}
			}
			
			currentMail = undefined;
			stage.focus=stage;
		}
		
		
		
		private function selectMail(evt:ListEvent):void
		{
			if (Main.tutorial == true && Main.tutorialStep == 1 && evt.target.getItemAt(evt.rowIndex)["From"] == "Carter DuPont")
			{
				Main.tutorialStep = 2;
				Main.hoverbox.visible = false;
				Main.hoverVis = false;
				Main.hovertext.text = "Good. Select the player (the arrow on the map).";
				Main.TUTORIALTEXT = "Good. Select the player (the arrow on the map).";
				Main.hovertext.setTextFormat(Main.hoverformat);
			}
			
			interFace2.play();
			bigMailBox.visible = true;
			mailContent.text = evt.target.getItemAt(evt.rowIndex)["Content"];
			mailContent.setTextFormat(hoverformat);
			
			Main.currentMail = evt.target.getItemAt(evt.rowIndex)["mailID"];
			Main.currentMailFrom = evt.target.getItemAt(evt.rowIndex)["From"]
			
			if (evt.target.getItemAt(evt.rowIndex)["Expires"] != false)
			{
				Mail.expiringMails[evt.target.getItemAt(evt.rowIndex)["mailID"]] -= 1;
			}
			
			/*currentMail = evt.target.getItemAt(evt.rowIndex);*/
			currentMailIndex = int(evt.rowIndex);
		}
		
		private function showMails(evt:MouseEvent):void
		{
			maildg.visible = true;
			if (Main.tutorial == true && Main.tutorialStep == 0)
			{
				Main.tutorialStep = 1;
				mailIcon.stopAlpha();
				Main.hovertext.text = "Now read the mail from Carter DuPont.";
				Main.TUTORIALTEXT = "Now read the mail from Carter DuPont.";
				Main.hovertext.setTextFormat(Main.hoverformat);
			}
			
			if (Main.tutorial == true && Main.tutorialStep == 15)
			{
					Main.hoverVis = false;
					mailIcon.stopAlpha();
			}
			
			if (Airport.currentSelect != false)
			{
				Airport.currentSelect.airportB.visible = false;
				Airport.currentSelect.airportS.visible = true;
				
				if (Airport.currentSelect.greenAirportB.visible == true)
				{
					Airport.currentSelect.greenAirport.visible = true;
					Airport.currentSelect.greenAirportB.visible = false;
				}
				
				if (Airport.currentSelect.blueAirportB.visible == true)
				{
					Airport.currentSelect.blueAirport.visible = true;
					Airport.currentSelect.blueAirportB.visible = false;
				}
			}
			
			if (Line.selectedRoute != false)
			{
				Line.selectedRoute.hoverLine.alpha = 0;
				Line.selectedLines = new Array();
				
				for (var slc:int = 0; slc < Main.parentRouteDict[Line.selectedRoute.routeParent.parentRoute]["lines"].length; slc ++)
				{
					Main.parentRouteDict[Line.selectedRoute.routeParent.parentRoute]["lines"][slc].lineDisplay.familyHoverLine.alpha = 0;
				}
			}
			
			Main.buyTerminalButton.visible = false;
			Main.buyTerminalGreyButton.visible = false;
			store_board.visible = false;
			route_board.visible = false;
			modify_route.visible = false;
			country_board.visible = false;
			player_board.visible = false;
			buyTerminalButton.visible = false;
			emptyBigButton.visible = true;
			maildg.visible = true;
			
			if (Airport.currentSelect != false)
			{
				if (Airport.currentSelect.airportB.visible == true)
				{
					Airport.currentSelect.airportS.visible = true;
					Airport.currentSelect.airportB.visible = false;
				}
				else if (Airport.currentSelect.blueAirportB.visible == true)
				{
					Airport.currentSelect.blueAirportB.visible = false;
					Airport.currentSelect.blueAirport.visible = true;
				}
				else if (Airport.currentSelect.greenAirportB.visible == true)
				{
					Airport.currentSelect.greenAirportB.visible = false;
					Airport.currentSelect.greenAirport.visible = true;
				}
			}
		}
		
		/*private function addingPlane(evt:MouseEvent)
		{
			var minValue:int = 11;
			var returnPlane = false;
			var breakLoop:Boolean = false;
			
			if (collectedAirplaneArray.length > 0)
			{
				for each (var p1 in collectedAirplaneArray)
				{
					if (p1.currentRoute == false && p1.movingOn == true)
					{
						//trace("Found static plane");
						returnPlane = p1;
						breakLoop = true;
						break;
					}
				}
				
				if (breakLoop == false)
				{
					for each (var p in collectedAirplaneArray)
					{
						if (p.currentRoute.deficit < minValue && p.free == true && p.waiting == false && p.movingOn == true && p.currentRoute != Line.selectedRoute.routeParent)
						{
							//trace("Took plane");
							minValue = p.currentRoute.deficit;
							returnPlane = p;
							breakLoop = true;
						}
					}
				}
				
				if (breakLoop == false)
				{
					var minValue:int = 11;
					for each (var p2 in collectedAirplaneArray)
					{
						if (p2.currentRoute.deficit < minValue && p.movingOn == true && p.currentRoute != Line.selectedRoute.routeParent)
						{
							//trace("Found plane in the air");
							minValue = p2.currentRoute.deficit;
							returnPlane = p2;
						}
					}
					
					if (returnPlane != false)
					{
						trace("Planned flight");
						returnPlane.planFlight(Line.selectedRoute.routeParent.routePoints[0][0], Line.selectedRoute.routeParent.routePoints[0][1], Line.selectedRoute.routeParent.routePoints[0][2], true);
					}
				}
				
				else
				{
					if (returnPlane != false)
					{
						trace("Doing flight now..");
						airportDict[returnPlane.currentLocation]["flightQueue"][airportDict[returnPlane.currentLocation]["flightQueue"].length] = [returnPlane, returnPlane.x,returnPlane.y, Line.selectedRoute.routeParent.routePoints[0][0],Line.selectedRoute.routeParent.routePoints[0][1], Line.selectedRoute.routeParent.routePoints[0][2], false, false, false, false, true];
						returnPlane.waiting = true;
					}
				}
				
				//trace("Returnplane:", returnPlane)
				//trace("Selected route", Line.selectedRoute);
				
				
				
				if (returnPlane != false)
				{
					//trace("Setting current route:", Line.selectedRoute.routeParent);
					returnPlane.currentRoute = Line.selectedRoute.routeParent;
				}
			}
		}*/
		
		private function moneyChange():void
		{
			if (Main.tutorial == false)
			{
				for (var uo = 0; uo < storeArray.length; uo++)
				{
					var button:StoreButton = storeArray[uo];
	
					if (Number(cash_field.text) >= button.price && button.visible == true)
					{
						storeDict[button].visible = false;
					}
					else
					{
						storeDict[button].visible = true;
					}	
					if (button.visible == false)
					{
						storeDict[button].visible = false;
					}
				}
				
				if (Main.buyTerminalButton.visible == true)
				{
					if (Math.round(Main.terminalprice * Main.airportDict[Main.currentLocation]["GDP"]) >= Number(Main.cash_field.text))
					{
						Main.buyTerminalGreyButton.visible = false;
					}
					else
					{
						Main.buyTerminalGreyButton.visible = true;
					}
				}
			}
		}
		
		private function finishTutorial(evt:MouseEvent):void
		{
			trace("Finished tutorial");
			Main.finishTut.visible = false;
			Main.tutorial = false;
			Main.tutorialStep = 0;
			clearProgress();
		}
	}
}