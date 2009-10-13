package models
{
	import models.CrudModel;
	
	public class Campaign extends CrudModel
	{
		
		public var start_date:String ;
		public var end_date:String ;
		public var asset_id:String ;
		public var product:Product = new Product() ;
		
		
		public function Campaign()
		{
			restName = "campaigns" ;
		}		
		
		public override function Unmarshall(model:Object):void{
			start_date = model.start_date ;
			end_date = model.end_date ;
			asset_id = model.asset_id ;
			
			product = new Product() ;
			product.Unmarshall(model.product);
			
		
			/*
			var rawData:String = String(model) ;
			var campaignData = JSON.decode(rawData);
			start_date = campaignData.start_date ;	
			end_date = campaignData.end_date ;	
			asset_id = campaignData.asset_id ;	
			product = campaignData.product ;	
			*/
		}			

	
		
		
	}
}