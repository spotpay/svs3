package 
{
	import fl.motion.easing.Sine;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Loader;
	import flash.display.MovieClip;	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.net.URLRequest;	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import gs.TweenLite;
	import models.Campaign;
	import Web.WebConfig;
	import flash.text.TextFieldAutoSize;
	import Musicane.Events.AnimationCompleteEvent;

	public class SVS3 extends MovieClip
	{
		//Embedded class
		var ea:EmbeddedAssets;

		//Model class
		var campaign:Campaign;

		//View Classes
		// -- Parent
		var inState:MovieClip;
		var inMask:MovieClip;
		var showMask:MovieClip;

		// -- Background
		var bkg:MovieClip;
		var blueBkg:MovieClip;
		var blackBkg:MovieClip;
		var bkgMask:MovieClip;

		// -- Meta
		var coverArt:MovieClip;
		var textMC:MovieClip;
		var artistField:TextField;
		var albumField:TextField;
		var titleField:TextField;
		var textMask:MovieClip;
		var priceField:TextField;		

		// -- Actions
		var closeAd;
		var buy;
		var logo;

		

		// -- Pill
		var pill:MovieClip;
		var playButton;
		var buySong;		

		var widgetPayApiUrl:String = WebConfig.Get().ServiceUrl+"/WidgetPayApi.swf";
		var widgetPayApi:MovieClip = null;
		var addedToStage:Boolean = false;

		public function SVS3():void
		{
			addEventListener(Event.ADDED_TO_STAGE, handleAdded);
			loadWidgetPayApi();
		}
		
		public function onVideoComplete():void
		{
			quickHide();
		}

		private function loadWidgetPayApi():void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadWidgetPayApiComplete);
			loader.load(new URLRequest(widgetPayApiUrl));
		}

		private function loadWidgetPayApiComplete(e:Event):void
		{
			widgetPayApi = e.target.loader.content;
			
			widgetPayApi.addEventListener(Event.CANCEL, handleApiCancel);
			widgetPayApi.addEventListener(Event.COMPLETE, handleApiComplete);
			widgetPayApi.addEventListener(Event.INIT, handleApiInit);
			widgetPayApi.addEventListener(AnimationCompleteEvent.ANIMATION_COMPLETE, animationComplete);
			addChild(widgetPayApi);

			if(addedToStage)
			{
				build();
			}
		}
		
		private function handleApiInit(e:Event):void
		{
			dispatchEvent(new Event("init"));
		}		
	
		private function handleApiCancel(e:Event):void
		{
			quickShow();
			dispatchCompleteEvent();
		}

		private function handleApiComplete(e:Event):void
		{
			dispatchCompleteEvent();
		}
		
		private function dispatchCompleteEvent():void
		{
			dispatchEvent(new Event("complete"));
		}

		private function handleAdded(e:Event):void
		{
			if(widgetPayApi != null)
			{
				build();
			}
			else
			{
				addedToStage = true;
			}
		}

		//Build fluid interface
		private function build():void
		{
			ea = new EmbeddedAssets();
			
			//Setup the container for the in state
			inState = new MovieClip();
			inState.name = "svs3_in_state";
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
			closeAd.name = "svs3_close";
			closeAd.x = stage.stageWidth - closeAd.width - 10;
			closeAd.y = 12;
			closeAd.alpha = 0;
			inState.addChild(closeAd);
			
			//Position Buy button
			buy = ea.buyButton;
			buy.name = "svs3_buy";
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
			inMask.name = "svs3_in_mask";
			inMask.graphics.beginFill(0x000000);
			inMask.graphics.drawRect(0,0,stage.stageWidth, 85);
			
			addChild(inMask);
			inState.mask = inMask;
			
			//Build Pill
			pill = new MovieClip();
			pill.name = "svs3_pill";
			
			playButton = ea.playButton;
			playButton.name = "svs3_pill_play";
			playButton.x = 92;
			playButton.y = 5;
			playButton.addEventListener(MouseEvent.CLICK, showAd);
		
			buySong = ea.buySong;
			buySong.name = "svs3_pill_buy";
			buySong.x = 15;
			buySong.y = 5;
			buySong.addEventListener(MouseEvent.CLICK, addToCart);

			pill.addChild(ea.pill);
			pill.addChild(buySong);
			pill.addChild(playButton);
		
			pill.x = -(pill.width);
			pill.y = 40;
		
			addChild(pill);

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
			textWidth = titleField.width = artistField.width = albumField.width = (buy.x - 10) - (coverArt.x + coverArt.width + 10);

			//Price textField
			var priceFormat:TextFormat = new TextFormat();
			priceFormat.font = "Arial";
			priceFormat.color = 0xFFFFFF;
			priceFormat.size = 14;
			priceFormat.align = "right";
			
			priceField = new TextField() ;
			priceField.defaultTextFormat = priceFormat;
			priceField.width = 100;
			priceField.x = buy.x - priceField.width - 10 - textMC.x;
			priceField.y = -2;
			priceField.text = "$" + campaign.product.price;

			textMask = new MovieClip();
			textMask.graphics.beginFill(0x000000);
			textMask.graphics.drawRect(0,0, textWidth, 100);
			textMask.x = textMC.x;
			textMask.y = textMC.y;
			textMask.alpha = 0;

			textMC.addChild(titleField);
			textMC.addChild(albumField);
			textMC.addChild(artistField);
			textMC.addChild(priceField);
			
			inState.addChild(textMC);
			inState.addChild(textMask);
			
			textMask.cacheAsBitmap = true;
			textMC.cacheAsBitmap = true;
	
			textMC.mask = textMask;

			playIntro();
		}
		
		private function quickHide():void
		{
			inState.cacheAsBitmap = true;
			inMask.cacheAsBitmap = true;

			TweenLite.to(inMask, .2, {alpha:0});
		}
		
		private function quickShow():void
		{			
			inState.cacheAsBitmap = true;
			inMask.cacheAsBitmap = true;

			TweenLite.to(inMask, .2, {alpha:1});
		}

		private function hideAd(e:MouseEvent):void
		{
			playHide();
		}
		
		// VARIOUS SHOW ANIMATION LOGIC STARTS HERE
		
		//Fade in + Wipe with Feathered Edge
		public function showAd(e:Event = null):void
		{			
			bkgMask.height = 65;
			bkgMask.y = 20;
		
			inMask.y = 0;
			inMask.visible = false;

			var rad:Number = 270*Math.PI/180;
			var what_is_the_matrix:Matrix = new Matrix()
			what_is_the_matrix.createGradientBox(bkgMask.width, 85, rad);

			showMask = new MovieClip();
			showMask.graphics.beginGradientFill(GradientType.LINEAR, [0x000000, 0x000000, 0x000000], [1,1,0], [0,220,255], what_is_the_matrix);
			showMask.graphics.drawRect(0,0, bkgMask.width, 100);
			
			var yVal:int = (this.parent is Loader) ? this.parent.y : this.y;

			showMask.y = yVal + 60;
			showMask.alpha = 0;

			inState.addChild(showMask);			
			
			inState.cacheAsBitmap = true;
			showMask.cacheAsBitmap = true;
			
			//inState.mask = null;
			inState.mask = showMask;

			TweenLite.to(pill, .25, {x:-(pill.width), ease:Sine.easeIn});
			TweenLite.to(showMask, .5, {y:yVal, alpha:1, delay:.2, ease:Sine.easeOut, onComplete:resetMask});
		}
		
		/*
		
		//Feathered wipe, no fade
		public function showAd(e:Event = null):void
		{			
			bkgMask.height = 65;
			bkgMask.y = 20;
			
			inMask.y = 0;
			inMask.visible = false;

			var rad:Number = 270*Math.PI/180;
			var what_is_the_matrix:Matrix = new Matrix()
			what_is_the_matrix.createGradientBox(bkgMask.width, 85, rad);

			showMask = new MovieClip();
			showMask.graphics.beginGradientFill(GradientType.LINEAR, [0x000000, 0x000000, 0x000000], [1,1,0], [0,220,255], what_is_the_matrix);
			showMask.graphics.drawRect(0,0, bkgMask.width, 85);
			
			var yVal:int = (this.parent is Loader) ? this.parent.y : this.y;
			showMask.y = yVal + 85;

			inState.addChild(showMask);			
			inState.cacheAsBitmap = true;
			showMask.cacheAsBitmap = true;
			
			inState.mask = showMask;

			TweenLite.to(pill, .25, {x:-(pill.width), ease:Sine.easeIn});
			TweenLite.to(showMask, .5, {y:yVal, delay:.2, ease:Sine.easeOut, onComplete:resetMask});
		}

		
		//Fade in + wipe with Hard Edge
		public function showAd(e:Event = null):void
		{			
			bkgMask.height = 65;
			bkgMask.y = 20;
			
			inMask.y = 85;
			inMask.alpha = 0;
			
			inState.cacheAsBitmap = true;
			inMask.cacheAsBitmap = true;
			
			TweenLite.to(pill, .25, {x:-(pill.width), ease:Sine.easeIn});
			TweenLite.to(inMask, .5, {y:0, alpha:1, delay:.4});
		}
		
		//Fade in no wipe
		public function showAd(e:Event = null):void
		{			
			bkgMask.height = 65;
			bkgMask.y = 20;
			
			inMask.y = 0;
			inMask.alpha = 0;
			
			inState.cacheAsBitmap = true;
			inMask.cacheAsBitmap = true;
			
			TweenLite.to(pill, .25, {x:-(pill.width), ease:Sine.easeIn});
			TweenLite.to(inMask, .5, {alpha:1, delay:.4});
		}
			
		
		//Straight wipe, no fade
		public function showAd(e:Event = null):void
		{			
			bkgMask.height = 65;
			bkgMask.y = 20;
			
			inMask.y = 85;
			
			TweenLite.to(pill, .25, {x:-(pill.width), ease:Sine.easeIn});
			TweenLite.to(inMask, .5, {y:0, delay:.4});
		}
		*/
		
		private function resetMask():void
		{
			showMask.visible = false;
			inMask.visible = true;
	
			inState.mask = null;
			inState.mask = inMask;
			animationComplete();
		}

		private function playIntro():void
		{
			//Scripted Intro animation queue
			TweenLite.to(blackBkg, .5, {x:-245, onComplete:playBlue});		
			TweenLite.to(coverArt, .3, {y:10, delay:1, ease:coverEase});
			TweenLite.to(textMask, .5, {alpha:1, delay:1.3});		
			TweenLite.to(buy, .3, {alpha:1, delay:1.6});
			TweenLite.to(closeAd, .2, {alpha:1, delay:1.9, onComplete:finalizeInterface});
		}

		private function playHide():void
		{				
			//Scripted Hide animation queue
			TweenLite.to(bkgMask, .4, {y:5, height:80});
			TweenLite.to(inMask, .2, {y:85, delay:.3, ease:Sine.easeIn});
			TweenLite.to(pill, .3, {x:0, delay:.6, ease:Sine.easeOut, onComplete:animationComplete});		
		}
		
		private function animationComplete(e:Event = null):void
		{
			dispatchEvent(new AnimationCompleteEvent("animationComplete"));
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
			
			//Create Mirrored blue
			var mirrorBlue:MovieClip = blueFlipVertical();
			mirrorBlue.y = 20;
			mirrorBlue.x = blueBkg.x;

			//addChildren
			bkg.addChildAt(blueBkg, 1);
			bkg.addChildAt(mirrorBlue, 2);
			bkg.addChildAt(blueMask, 3);
		}
		
		function blueFlipVertical():MovieClip
		{
			var dsp:MovieClip = new ea.AnimatedBlueBkg as MovieClip;
			var matrix:Matrix = dsp.transform.matrix;
			matrix.transformPoint(new Point(dsp.width/2,dsp.height/2));
			if(matrix.d>0){
				matrix.d=-1*matrix.d;
				matrix.ty=dsp.y+dsp.height;
			}
			else
			{
				matrix.d=-1*matrix.d;
				matrix.ty=dsp.y-dsp.height;
			}
			dsp.transform.matrix=matrix;
			return dsp;
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
			quickHide();
			var obj:Object = {a:"hi"};
			Object(widgetPayApi).AddToCartAndCheckout(obj);
		}
	}
}