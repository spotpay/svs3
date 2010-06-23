package Musicane.FlashRestUtils.Interfaces
{
	import flash.net.URLRequest;

	public interface IRequest
	{
		function Load():void;		
		function get ProtocolAndDomain():String;
		function get Path():String;
		function get Url():String;
		function get Request():URLRequest;		
		function get Response():Object;		
	}
}
