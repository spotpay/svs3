package Tests
{
	import flexunit.framework.TestCase;
	import flash.net.URLRequestMethod;
	import models.Campaign;
	import Musicane.FlashRestUtils.RestRequest;

	public class CampaignTest extends TestCase
	{
		public function CampaignTest()
		{
			
		}
		
		public function testShow():void
		{
			var campaign:Campaign = new Campaign();
			var req:RestRequest = campaign.Show("123");
			assertTrue("http method is GET", URLRequestMethod.GET, req.Request.method);
			assertTrue("Path will be campaigns/123", req.Path == "campaigns/123");
		}
		
		
		public function testUnmarshall():void
		{
			var campaign:Campaign = new Campaign();
			
			var obj:Object = new Object() ;
			obj.start_date = "01/09/09" ;
			obj.end_date = "01/14/09" ;
			obj.asset_id = "asset01" ;

			var product = new Object() ;
			product.title = "Title 01";
			product.price = 2500;
			product.currency = "USD";
			product.musicane_product_id = "mp_id_01";
			product.img_url = "images/product1.jpg";
			product.artist = "Artist 1";
			product.album_title = "Album Title";
			obj.products=[];
			obj.products.push(product);
			campaign.Unmarshall(obj);
		
			assertTrue("campaign start date will be 01/09/09", campaign.start_date == "01/09/09");
			assertTrue("campaign end date will be 01/14/09", campaign.end_date == "01/14/09");
			assertTrue("campaign product title Title 01", campaign.product.title == "Title 01");
			assertTrue("campaign product price $25", campaign.product.PriceDisplay == "$25");
			assertTrue("campaign product image url will be images/product1.jpg", campaign.product.img_url == "images/product1.jpg");
			assertTrue("campaign product Artist will be Artist 1", campaign.product.artist == "Artist 1");			
			assertTrue("campaign product album_title will be Album Title", campaign.product.album_title == "Album Title");			
		}		
		
		
	}
}