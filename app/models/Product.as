package models
{
	
	
	
	import models.CrudModel;
	import models.Artist;

	
		
	public class Product extends CrudModel
	{

		public var title:String ;
		public var price:String ;
		public var musicane_product_id:String ;
		public var img_url:String ;
		public var artist:Artist ;
		
		
		public function Product()
		{
			restName = "products" ;		
		}

		public override function Unmarshall(model:Object):void{
			title = model.title ;
			price = model.price ;
			musicane_product_id = model.musicane_product_id ;
			img_url = model.img_url ;
			
			artist = new Artist() ;
			artist.Unmarshall(model.artist);			
			
			
			
		
			/*
			var rawData:String = String(model) ;
			var campaignData = JSON.decode(rawData);
			title = campaignData.title ;
			price = campaignData.price ;
			musicane_product_id = campaignData.musicane_product_id ;
			img_url = campaignData.img_url ;
			artist = campaignData.artist ;
			*/
		}		
	}
}