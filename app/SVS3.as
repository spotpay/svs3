package 
{
	import fl.motion.easing.Sine;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;	
	import flash.net.URLRequest;
	import gs.TweenLite;
	import models.Campaign;
	import Web.WebConfig;


	public class SVS3 extends Sprite
	{
		//Model class
		var campaign:Campaign;

		//View Classes
		// -- Parent
		var inState:MovieClip;
		var inMask:MovieClip;

		// -- Background
		var bkg:MovieClip;
		var blueBkg:Class;
		var blackBkg:Class;
		var bkgMask:Sprite;

		// -- Meta
		var coverArt:MovieClip;

		// -- Actions
		var closeAd:Class;
		var buy:Class;
		var logo:Class;

		var widgetPayApiUrl:String = WebConfig.Get().ServiceUrl+"/swf/WidgetPayApi.swf";
		var widgetPayApi:DisplayObject = null;
		
		public function SVS3():void
		{
			loadWidgetPayApi();
		}

		//loads the widgetPayApi Swf
		private function loadWidgetPayApi():void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadWidgetPayApiComplete);
			loader.load(new URLRequest(widgetPayApiUrl));
		}

		private function loadWidgetPayApiComplete(e:Event):void
		{
			widgetPayApi = e.target.loader.content;
			addChild(widgetPayApi);
			build();
		}

		//Build fluid interface
		private function build():void
		{
			//Setup the container for the in state
			inState = new MovieClip();
			inState.x = 0;
			inState.y = 0;
			addChild(inState);
			
			//Create BKG
			bkg = new MovieClip();
			
			//Create fade in and prepare for animation
			blackBkg = new EmbeddedAssets.BkgFadeIn();
			blackBkg.x = stage.stageWidth;
			blackBkg.y = 20;
			blackBkg.black.width = stage.stageWidth;
			
			//Add fade in to BKG
			bkg.addChild(blackBkg as DisplayObject);
			
			//Create BKG Mask
			bkgMask = new Sprite();
			bkgMask.graphics.beginFill(0x000000);
			bkgMask.graphics.drawRect(0,0,stage.stageWidth, 65);
			bkgMask.y = 20;
			
			//Add BKG and Mask to inState
			inState.addChild(bkg);
			inState.addChild(bkgMask);
			
			//Apply mask to BKG	
			bkg.mask = bkgMask;
			
			//Create Cover Art MC
			coverArt = new MovieClip();
			coverArt.graphics.beginFill(0x999999);
			coverArt.graphics.drawRect(0,0,64,64);
			coverArt.graphics.beginFill(0xFFFFFF);
			coverArt.graphics.drawRect(1,1,62,62);
			coverArt.x = 16;
			coverArt.y = 90;
			inState.addChild(coverArt);
			
			//Position Close button
			closeAd = new EmbeddedAssets.Close();
			closeAd.x = stage.stageWidth - closeAd.width - 10;
			closeAd.y = 12;
			closeAd.alpha = 0;
			inState.addChild(closeAd as DisplayObject);
			
			//Position Buy button
			buy = new EmbeddedAssets.BuyButton();
			buy.x = closeAd.x - buy.width - 8;
			buy.y = 28;
			buy.alpha = 0;
			inState.addChild(buy as DisplayObject);
			
			//Position Musicane logo
			logo = new EmbeddedAssets.MusicaneLogo();
			logo.x = buy.x - 7;
			logo.y = 60;
			inState.addChild(logo as DisplayObject);
			
			//Mask for outro
			inMask = new MovieClip();
			inMask.graphics.beginFill(0x000000);
			inMask.graphics.drawRect(0,0,stage.stageWidth, 85);
			
			addChild(inMask);
			inState.mask = inMask;
			
			loadFeedable();
		}

		private function loadFeedable():void
		{
			campaign = new Campaign();
			loadImage();
		}

		private function loadImage():void
		{
			var ldr:Loader = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, imageComplete);
			ldr.load(new URLRequest(campaign.product.img_url));
		}

		private function imageComplete(e:Event):void
		{
			var loader:Loader = e.target.loader;
			loader.x = loader.y = 2;
			coverArt.addChild(loader);
			dataLoaded();
		}

		private function dataLoaded(e:Event = null):void
		{
			playIntro();
		}

		private function hideAd(e:MouseEvent):void
		{
			playHide();
		}

		private function showAd(e:MouseEvent):void
		{
			
		}

		private function playIntro():void
		{
			//Scripted animation queue
			TweenLite.to(blackBkg, .5, {x:-245, onComplete:playBlue});		
			TweenLite.to(coverArt, .3, {y:10, delay:1, ease:coverEase});		
			TweenLite.to(buy, .3, {alpha:1, delay:1.3});
			TweenLite.to(closeAd, .2, {alpha:1, delay:1.6, onComplete:finalizeInterface});
		}

		private function playHide():void
		{
			TweenLite.to(bkgMask, .4, {y:5, height:80});
			TweenLite.to(inMask, .2, {y:85, delay:.3, ease:Sine.easeIn});
		}

		private function playBlue():void
		{
			//Create BlueBkg
			blueBkg = new EmbeddedAssets.AnimatedBlueBkg();
			
			//Position blue effect
			blueBkg.x = (logo.x - 340 > 0) ? 0 : logo.x - 340;
			blueBkg.y = 20;
			
			//createMask
			var blueMask:Class = new EmbeddedAssets.BlueSpotlight();
			blueMask.x = blueBkg.x;
			blueMask.y = blueBkg.y;
			
			//Set up alpha masking
			blueBkg.cacheAsBitmap = true;
			blueMask.cacheAsBitmap = true;
			
			//Set mask
			blueBkg.mask = blueMask as DisplayObject;
			
			//addChildren
			bkg.addChildAt(blueBkg as DisplayObject, 1);
			bkg.addChildAt(blueMask as DisplayObject, 2);
		}

		private function finalizeInterface():void
		{
			//Turn on click functionality for close
			closeAd.buttonMode = true;
			closeAd.useHandCursor = true;
			closeAd.addEventListener(MouseEvent.CLICK, hideAd);
			
			//Turn on click functionality for buy	
			buy.buttonMode = true;
			buy.useHandCursor = true;
			buy.addEventListener(MouseEvent.CLICK, addToCart);
		}
		
		private function coverEase(t:Number, b:Number, c:Number, d:Number):Number
		{
			var ts:Number = (t/=d)*t;
			var tc:Number = ts*t;
			return b+c*(-0.7205613178767587*tc*ts + 1.71446003660769*ts*ts + 0.2867602196461263*tc + -4.441732763880413*ts + 4.1610738255033555*t);
		}	

		public function addToCart(e:MouseEvent):void
		{
			var obj:Object = {a:"hi"};
			Object(widgetPayApi).AddToCartAndCheckout(obj);
		}
	}
}