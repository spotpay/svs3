package models
{
	import Musicane.FlashRestUtils.Models.CrudModel;
	import flash.events.Event;
	public class Campaign extends CrudModel
	{
		
		public var start_date:String ;
		public var end_date:String ;
		public var product:Product = new Product() ;
		
		
		public function Campaign()
		{
			restName = "campaigns" ;
		}		
		
		public override function Unmarshall(model:Object):void{
			start_date = model.start_date ;
			end_date = model.end_date ;
	
			product = new Product() ;
			product.Unmarshall(model.products[0]);
		}			
	}
}