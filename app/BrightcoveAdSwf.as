package{
	import com.brightcove.fl.advertising.adSwf.AdSwf;
	import com.brightcove.fl.advertising.adSwf.AdSwfContext;
	import com.brightcove.fl.advertising.adSwf.AdSwfMediaEvent;

	import flash.system.Security;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class BrightcoveAdSwf extends AdSwf
	{
		//widgetpayapi reference
		public var widgetPayApi:MovieClip = null;
		
			// whether to pause the video while the ad is playing
        private var pauseVideo:Boolean = false;

        // whether to disable all Lists when an ad is playing and pauseVideo is true.  This can 
        // be used to make sure that no other video can be clicked on when an ad is playing
        private var disableLists:Boolean = false;

        // timer for deciding when the ad should end
        private var timer:Timer;

        // information about the player and functions for the ad SWF
        private var adContext:AdSwfContext;

        // videoPlayer API module.  See the API documentation for more information on its use
        private var videoPlayer:Object;

        // advertising API module.  See the API documentation for more information on its use
        private var advertising:Object;

        // experience API module.  See the API documentation for more information on its use
        private var experience:Object;

        // the ad duration  
        private var adDuration:Number;        

        // element that can be put in ad XML to set pauseVideo
        private static const PAUSE_VIDEO:String = "pauseVideo";

        // element that can be put in ad XML to set adDuration
        private static const AD_SWF_DURATION:String = "adSWFDuration";

        // element that can be put in ad XML to set disableLists
        private static const DISABLE_LISTS:String = "disableLists";

		public function FlexAdSwf():void
		{
			Security.allowDomain("admin.brightcove.com");     
			config.pauseVideoPlayer = false;

            // The rest of the AdSwfConfig values aren't really needed in here, as they are set to the
            // defaults, but we include this to show where you could set them. 
            config.completeOnVideoComplete = true;
            config.completeOnVideoChange = true;
            config.resizeOnMenuOpen = true;
            config.resizeOnFullScreen = true;
            config.keepVisibleAfterComplete = false;
		}

		override public function configureAd(pAdContext:AdSwfContext):void {

            // Set the pauseVideoPlayer value in AdSwfConfig as determined by the pauseVideo
            // settings.  If set to true, this will pause the main video and enable some 
            // events to listen to

            // make sure to call configAdComplete() when you are done with your configuration.  You must 
            // call this function if you override configureAd() otherwise the ad will never play.
            configureAdComplete();
        }

        /**
         * Called when a new ad should be displayed
         */
        override public function displayAd(adContext:AdSwfContext):void {

            this.adContext = adContext;

            trace("Beginning the display of the example SWF ad");

            // before we do anything else, we load the API modules for potential use
            adContext.moduleLoader.addEventListener(Event.COMPLETE, modulesLoaded);
            adContext.moduleLoader.loadModules();
        }

        /**
         * Called when the API modules have been loaded
         */
        private function modulesLoaded(event:Event):void {

            adContext.moduleLoader.removeEventListener(Event.COMPLETE, modulesLoaded);

            // Now we can get a reference to a module we'd like to use.  We can grab 
            // more modules if they are needed, as the ad SWF can use any of the modules 
            // that can normally be used for player API development.
            videoPlayer = adContext.moduleLoader.getModule("videoPlayer");
            advertising = adContext.moduleLoader.getModule("advertising");
            experience = adContext.moduleLoader.getModule("experience");
			loadAd();
            // Normally you wouldn't call a function like adLoaded directly.  Instead, you would
            // be using the Loader class, which loads the real ad and then call adLoaded() functionality
            // after the result has been returned
        }
		
		private function loadAd():void
		{
			// Get our fake ad instead of getting it from a Loader
            //var ad:Sprite = new FakeAd(0x000000, 0xf0ff00," I'm an Ad SWF!");
			var ad:MovieClip = new SVS3();
            //ad.addEventListener(MouseEvent.CLICK, launchWp);
			x = 0;//videoPlayer.getX() + 15;
            y = videoPlayer.getHeight() - 130;

            // add the ad to the display
            addChild(ad);
			//loadWidgetPayApi();

			//var ac:ArrayCollection = new ArrayCollection(["1"]);
			//var something_else = ac[0];
		}
	}
}