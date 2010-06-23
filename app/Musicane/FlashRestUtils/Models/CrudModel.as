package Musicane.FlashRestUtils.Models
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ErrorEvent;
	import Musicane.FlashRestUtils.RestRequest;
	import Musicane.FlashRestUtils.RestRequestConfig;	

	public class CrudModel extends EventDispatcher
	{
		protected var restName:String ;
		protected var restRequestConfig:RestRequestConfig;
		
		public function CrudModel()
		{
			
		}
		
		public function Show(id:String):RestRequest
		{
			var request:RestRequest = 
				new RestRequest(restName+"/"+id, "get", restRequestConfig);
			request.Load();
			request.addEventListener(Event.COMPLETE, handleSuccess) ;
			request.addEventListener(ErrorEvent.ERROR, handleFail) ;	
			
			return request;		
		}
		
		private function handleSuccess(e:Event):void
		{
			var jsonData:Object = RestRequest(e.target).Response ;
			Unmarshall(jsonData);
			dispatchEvent(new Event("complete"));
		}
		
		private function handleFail(e:Event):void
		{
			
		}		
		
		public function Unmarshall(model:Object):void
		{
			
		}
	}
}