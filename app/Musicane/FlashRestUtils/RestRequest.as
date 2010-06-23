package Musicane.FlashRestUtils
{
	import com.adobe.serialization.json.JSON;
	import flash.events.EventDispatcher;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import Musicane.FlashRestUtils.Interfaces.IRequest;
  import SpotPay.SVS3.Config;
  
	public class RestRequest extends EventDispatcher implements IRequest
	{
		private var response:Object;
		private var restPath:String;
		private var config:RestRequestConfig = 
			new RestRequestConfig(Config.Protocol, Config.Host, Config.Port);
		private var loader:URLLoader;		
		private var request:URLRequest;

		public function RestRequest(path:String, method:String = "get", config:RestRequestConfig = null):void
		{	
			loader = new URLLoader();
			request = new URLRequest();
			
			restPath = path;
			
			switch(method)
			{
				case "get":
					request.method = URLRequestMethod.GET;
				break;
				
				case "post":
					request.method = URLRequestMethod.POST;
				break;
			}
			this.config = (config == null) ? this.config : config;			
			

			request.requestHeaders.push(new URLRequestHeader("Content-Type", "application/json"));
		}
		
		public function Load():void
		{
			request.url = Url;
			loader.addEventListener(Event.COMPLETE, handleComplete);
			loader.load(request);
		}
		
		public function get ProtocolAndDomain():String
		{
			return config.Protocol + config.Host + ":" + config.Port.toString();
		}
		
		public function get Url():String
		{
			return (restPath.charAt(0) == "/") ? 
		     ProtocolAndDomain + restPath : ProtocolAndDomain + "/" + restPath;
		}

		private function handleComplete(e:Event):void
		{
			parseReturn(e.target.data);				    
		}
		
		protected function parseReturn(s:String):void
		{
			response = JSON.decode(s);
			dispatchEvent(new Event("complete"));
			//Determine what the rest api will return for errors and successes and write the parsing logic here
		}

		public function get Response():Object
		{
			return response;
		}
		
		public function get Request():URLRequest
		{
			return request;
		}
		
		public function get Path():String
		{
			return restPath;
		}
	}
}
