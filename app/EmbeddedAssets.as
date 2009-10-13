package
{
	import flash.display.Sprite;
	import flash.display.MovieClip;

	public class EmbeddedAssets extends Sprite
	{
		
		public var musicaneLogo;
		public var buyButton;
		public var close;
		public var animatedBlueBkg:MovieClip;
		public var bkgFadeIn:MovieClip;
		public var blueSpotlight:MovieClip;

		public function EmbeddedAssets():void
		{
			bkgFadeIn		= new BkgFadeIn() as MovieClip;
			buyButton		= new BuyButton();
			close			= new Close();
			animatedBlueBkg = new AnimatedBlueBkg() as MovieClip;
			musicaneLogo	= new MusicaneLogo();			
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

		[Embed(source="../assets/animatedBleuBkg.swf")]
		private var AnimatedBlueBkg:Class;

		[Embed(source="../assets/bkgFadeIn.swf")]
		private var BkgFadeIn:Class;

		[Embed(source="../assets/blueSpotlight.swf")]
		private var BlueSpotlight:Class;
	}
}
