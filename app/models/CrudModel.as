package models
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ErrorEvent;
	import Web.WebRequest;	
	
	public class CrudModel extends EventDispatcher
	{
		protected var restName:String ;
		
		
		public function CrudModel()
		{
			
		}
		
		public function Show(id:String):WebRequest{
			
			var webReq:WebRequest = new WebRequest("post",restName+"/"+id);
			webReq.Load();
			webReq.addEventListener(Event.COMPLETE, handleSuccess) ;
			webReq.addEventListener(ErrorEvent.ERROR, handleFail) ;	
			
			return webReq ;		
		}
		
		private function handleSuccess(e:Event):void{
			var jsonData:Object = WebRequest(e.target).Response ;
			Unmarshall(jsonData);
		}
		
		private function handleFail(e:Event):void{
			
		}		
		
		public function Unmarshall(model:Object):void{
			
		}
		
		
		
	}
}