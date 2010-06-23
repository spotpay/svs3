package Musicane.FlashRestUtils
{
	public class RestRequestConfig
	{
		private var host:String;
		private var port:int;
		private var protocol:String;		

		public function RestRequestConfig(protocol:String, host:String, port:int):void
		{	
			this.protocol = protocol;
			this.host = host;
			this.port = port;
		}
		
		public function get Host():String
		{
			return this.host;
		}
		
		public function get Port():int
		{
			return this.port;
		}
		
		public function get Protocol():String
		{
			return this.protocol;
		}
	}
}
