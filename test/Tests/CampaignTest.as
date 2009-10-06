package Tests
{
	import flexunit.framework.TestCase;
	
	import models.Campaign;
	import Web.WebRequest;
	
	

	public class CampaignTest extends TestCase
	{
		public function CampaignTest()
		{
			
		}
		
		public function testShow():void{
			var campaign:Campaign = new Campaign();
			var webReq:WebRequest = campaign.Show("123");
			assertTrue("Path will be campaigns/123", webReq.Path == "campaigns/123");
			assertFalse("Path will not be campaigns/456",webReq.Path == "campaigns/456");
		}
		
		
		public function testUnmarshall():void{
			var campaign:Campaign = new Campaign();
			
			var obj:Object = new Object() ;
			obj.start_date = "01/09/09" ;
			obj.end_date = "01/14/09" ;
			obj.asset_id = "asset01" ;

			obj.product = new Object() ;
			obj.product.title = "Title 01"
			obj.product.price = "$25"
			obj.product.musicane_product_id = "mp_id_01"
			obj.product.img_url = "images/product1.jpg"
			
			obj.product.artist = new Object() ;
			obj.product.artist.name = "Artist 1" ;
			
			
			campaign.Unmarshall(obj);
			
			assertTrue("campaign start date will be 01/09/09", campaign.start_date == "01/09/09");
			assertFalse("campaign start date will not be 01/10/09", campaign.start_date == "01/10/09");
			
			assertTrue("campaign end date will be 01/14/09", campaign.end_date == "01/14/09");
			assertFalse("campaign start date will not be 01/16/09", campaign.end_date == "01/16/09");			
			
			assertTrue("campaign asset id will be asset01", campaign.asset_id == "asset01");
			assertFalse("campaign asset id will not be asset03", campaign.asset_id == "asset03");
			
			assertTrue("campaign product title Title 01", campaign.product.title == "Title 01");
			assertFalse("campaign product title will not be Title 0002", campaign.product.title == "Title 0002");			
			
			assertTrue("campaign product price $25", campaign.product.price == "$25");
			assertFalse("campaign product price will not be $125", campaign.product.price == "$125");						
			
			assertTrue("campaign product image url will be images/product1.jpg", campaign.product.img_url == "images/product1.jpg");
			assertFalse("campaign product image url will not be images/product1111.jpg", campaign.product.img_url == "images/product1111.jpg");									
			assertTrue("campaign product Artist will be Artist 1", campaign.product.artist.name == "Artist 1");
			assertFalse("campaign product Artist will not be Artist 2", campaign.product.artist.name == "Artist 2");												
			
		}		
		
		
	}
}