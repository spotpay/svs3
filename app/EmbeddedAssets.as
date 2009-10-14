package
{
	import flash.display.Sprite;
	import flash.display.MovieClip;

	public class EmbeddedAssets extends Sprite
	{
		//Symbols
		public var musicaneLogo;
		public var buyButton;
		public var close;
		public var pill;
		public var buySong;
		public var playButton;
		//Clips
		public var animatedBlueBkg:MovieClip;
		public var bkgFadeIn:MovieClip;
		public var blueSpotlight:MovieClip;
		

		public function EmbeddedAssets():void
		{
			bkgFadeIn		= new BkgFadeIn() as MovieClip;			
			animatedBlueBkg = new AnimatedBlueBkg() as MovieClip;
			
			musicaneLogo	= new MusicaneLogo();
			buyButton		= new BuyButton();
			close			= new Close();			

			pill			= new Pill();
			buySong			= new BuySong();
			playButton		= new PlayButton();
			
		}
		
		public function SetBlueMask():void
		{
			blueSpotlight	= new BlueSpotlight() as MovieClip;
		}

		[Embed(source="../assets/symbols.swf", symbol="musicaneLogo")]
		private var MusicaneLogo:Class;

		[Embed(source="../assets/symbols.swf", symbol="buyButton")]
		private var BuyButton:Class;

		[Embed(source="../assets/symbols.swf", symbol="close")]
		private var Close:Class;

		[Embed(source="../assets/symbols.swf", symbol="pill")]
		private var Pill:Class;
		
		[Embed(source="../assets/symbols.swf", symbol="playButton")]
		private var PlayButton:Class;

		[Embed(source="../assets/symbols.swf", symbol="buySong")]
		private var BuySong:Class;

		[Embed(source="../assets/animatedBleuBkg.swf")]
		public var AnimatedBlueBkg:Class;

		[Embed(source="../assets/bkgFadeIn.swf")]
		private var BkgFadeIn:Class;

		[Embed(source="../assets/blueSpotlight.swf")]
		public var BlueSpotlight:Class;
	}
}
