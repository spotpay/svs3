package
{
	public class EmbeddedAssets
	{
		[Embed(source="../assets/symbols.swf", symbol="musicaneLogo")]
		public static var MusicaneLogo:Class;

		[Embed(source="../assets/symbols.swf", symbol="buyButton")]
		public static var BuyButton:Class;

		[Embed(source="../assets/symbols.swf", symbol="close")]
		public static var Close:Class;

		[Embed(source="../assets/animatedBleuBkg.swf")]
		public static var AnimatedBlueBkg:Class;

		[Embed(source="../assets/bkgFadeIn.swf")]
		public static var BkgFadeIn:Class;

		[Embed(source="../assets/blueSpotlight.swf")]
		public static var BlueSpotlight:Class;
	}
}
