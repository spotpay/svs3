package models
{
	import models.CrudModel;
	import models.Artist;

	public class Product extends CrudModel
	{
		public var artist:Artist = new Artist();
		public var album_title:String = "Album Album Album";
		public var title:String = "Blah Blah Blah";
		public var price:String  = "0.99";
		public var musicane_product_id:String ;
		public var img_url:String = "albumArt.jpg";
		
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