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
	import flash.text.TextField;
	import flash.text.TextFormat;
	import gs.TweenLite;
	import models.Campaign;
	import Web.WebConfig;
	import mx.skins.halo.TitleBackground;
	import mx.controls.Text;

	public class SVS3 extends Sprite
	{
		//Embedded class
		var ea:EmbeddedAssets;

		//Model class
		var campaign:Campaign;

		//View Classes
		// -- Parent
		var inState:MovieClip;
		var inMask:MovieClip;

		// -- Background
		var bkg:MovieClip;
		var blueBkg:MovieClip;
		var blackBkg:MovieClip;
		var bkgMask:Sprite;

		// -- Meta
		var coverArt:MovieClip;
		var textMC:MovieClip;
		var artistField:TextField;
		var albumField:TextField;
		var titleField:TextField;
		var textMask:MovieClip;

		// -- Actions
		var closeAd;
		var buy;
		var logo;

		var widgetPayApiUrl:String = WebConfig.Get().ServiceUrl+"/WidgetPayApi.swf";
		var widgetPayApi:DisplayObject = null;
		
		public function SVS3():void
		{
			addEventListener(Event.ADDED_TO_STAGE, build);
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
		}

		//Build fluid interface
		private function build(e:Event):void
		{
			ea = new EmbeddedAssets();
			
			//Setup the container for the in state
			inState = new MovieClip();
			inState.x = 0;
			inState.y = 0;
			addChild(inState);
			
			//Create BKG
			bkg = new MovieClip();
			
			//Create fade in and prepare for animation
			blackBkg = ea.bkgFadeIn;
			blackBkg.x = stage.stageWidth;
			
			//Add fade in to BKG
			bkg.addChild(blackBkg);
			
			//Create BKG Mask
			bkgMask = new MovieClip();
			bkgMask.graphics.beginFill(0xFF0000);
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
			closeAd = ea.close;
			closeAd.x = stage.stageWidth - closeAd.width - 10;
			closeAd.y = 12;
			closeAd.alpha = 0;
			inState.addChild(closeAd);
			
			//Position Buy button
			buy = ea.buyButton;
			buy.x = closeAd.x - buy.width - 8;
			buy.y = 28;
			buy.alpha = 0;
			inState.addChild(buy);
			
			//Position Musicane logo
			logo = ea.musicaneLogo;
			logo.x = buy.x - 7;
			logo.y = 60;
			inState.addChild(logo);
			
			//Mask for outro
			inMask = new MovieClip();
			inMask.graphics.beginFill(0x000000);
			inMask.graphics.drawRect(0,0,stage.stageWidth, 85);
			
			addChild(inMask);
			inState.mask = inMask;
			
			loadFeedable();
			//playIntro();
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
			loader.width = coverArt.width - 4;
			loader.height = coverArt.height - 4;
			coverArt.addChild(loader);
			dataLoaded();
		}

		private function dataLoaded(e:Event = null):void
		{
			//Create Text MC
			textMC = new MovieClip();
			textMC.x = (coverArt.x + coverArt.width + 10);
			textMC.y = 30;
			
			var titleFormat:TextFormat = new TextFormat();
			titleFormat.font = "Arial";
			titleFormat.color = 0xFFFFFF;
			titleFormat.size = 14;	
			titleFormat.bold = true;
		
			var artistFormat:TextFormat = new TextFormat();
			artistFormat.font = "Arial";
			artistFormat.color = 0xFFFFFF;
			artistFormat.size = 14;
		
			var albumFormat:TextFormat = new TextFormat();
			albumFormat.font = "Arial";
			albumFormat.color = 0xD1D1D1;
			albumFormat.size = 11;

			titleField = new TextField();
			titleField.defaultTextFormat = titleFormat;
			titleField.x = -2;
			titleField.y = -2;
			titleField.text = campaign.product.title;

			artistField = new TextField();
			artistField.defaultTextFormat = artistFormat;
			artistField.x = -2;
			artistField.y = 14;
			artistField.text = campaign.product.artist.name;						
			
			albumField = new TextField();
			albumField.defaultTextFormat = albumFormat;
			albumField.x = -2;
			albumField.y = 30;
			albumField.text = campaign.product.album_title;						
			
			var textWidth:int;
			textWidth = titleField.width = artistField.width = albumField.width = (logo.x - 10) - (coverArt.x + coverArt.width + 10);

			textMask = new MovieClip();
			textMask.graphics.beginFill(0x000000);
			textMask.graphics.drawRect(0,0, textWidth, 100);
			textMask.x = textMC.x;
			textMask.y = textMC.y;
			textMask.alpha = 0;

			textMC.addChild(titleField);
			textMC.addChild(albumField);
			textMC.addChild(artistField);
			
			inState.addChild(textMC);
			inState.addChild(textMask);
			
			textMask.cacheAsBitmap = true;
			textMC.cacheAsBitmap = true;
	
			textMC.mask = textMask;

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
			TweenLite.to(textMask, .5, {alpha:1, delay:1.3, ease:coverEase});		
			TweenLite.to(buy, .3, {alpha:1, delay:1.6});
			TweenLite.to(closeAd, .2, {alpha:1, delay:1.9, onComplete:finalizeInterface});
		}

		private function playHide():void
		{
			TweenLite.to(bkgMask, .4, {y:5, height:80});
			TweenLite.to(inMask, .2, {y:85, delay:.3, ease:Sine.easeIn});
		}

		private function playBlue():void
		{
			
			//Create BlueBkg
			blueBkg = ea.animatedBlueBkg;
			
			//Position blue effect
			blueBkg.x = (logo.x - 340 > 0) ? 0 : logo.x - 340;
			blueBkg.y = 20;
			
			//createMask
			ea.SetBlueMask();
			var blueMask:MovieClip = ea.blueSpotlight;
			blueMask.x = blueBkg.x;
			blueMask.y = blueBkg.y;
			
			//Set up alpha masking
			blueBkg.cacheAsBitmap = true;
			blueMask.cacheAsBitmap = true;
			
			//Set mask
			blueBkg.mask = blueMask;
			
			//addChildren
			bkg.addChildAt(blueBkg, 1);
			bkg.addChildAt(blueMask, 2);
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