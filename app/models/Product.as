package models
{
	import Musicane.FlashRestUtils.Models.CrudModel;

	public class Product extends CrudModel
	{
		public var artist:String = "Yea Yea Yea";
		public var album_title:String = "Album Album Album";
		public var title:String = "Blah Blah Blah";
		public var price:Number  = 99;
		public var currency:String = "USD";
		public var musicane_product_id:String ;
		public var img_url:String = "albumArt.jpg";
		
		public function Product()
		{
			restName = "products" ;		
		}

		public override function Unmarshall(model:Object):void{
			title = model.title;
			price = model.price;
			currency = model.currency;
			musicane_product_id = model.musicane_product_id ;
			img_url = model.img_url ;
			artist = model.artist;
			album_title=model.album_title;
		}
		
		public function get PriceDisplay():String
		{
			return "$" + price/100;
		}		
	}
}