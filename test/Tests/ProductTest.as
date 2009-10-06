package Tests
{
	import flexunit.framework.TestCase;
	
	import models.Product;
	import Web.WebRequest;
	
	

	public class ProductTest extends TestCase
	{
		public function ProductTest()
		{
			
		}
		
		public function testShow():void{
			var product:Product = new Product();
			var webReq:WebRequest = product.Show("123");
			
			assertTrue("Path will be products/123", webReq.Path == "products/123");
			assertFalse("Path will not be products/456",webReq.Path == "products/456");
		}
		
		
		public function testUnmarshall():void{
			var product:Product = new Product();
			
			var obj:Object = new Object() ;
			obj.title = "Title 1" ;
			obj.price = "$250" ;
			obj.musicane_product_id = "mp123" ;
			obj.img_url = "image/prod123.jpg" ;
			
			obj.artist = new Object() ;
			obj.artist.name = "Artist 1" ;

			
			
			product.Unmarshall(obj);
			
			assertTrue("product title will be Title 1", product.title == "Title 1");
			assertFalse("product title will not be Title 5", product.title == "Title 5");
			
			assertTrue("product price will be $250", product.price == "$250");
			assertFalse("product price will not be $50", product.price == "$50");			
			
			assertTrue("product musicane product id will be mp123", product.musicane_product_id == "mp123");
			assertFalse("product musicane product id will not be mp456", product.musicane_product_id == "mp456");						
			
			assertTrue("product image url will be image/prod123.jpg", product.img_url == "image/prod123.jpg");
			assertFalse("product image url will not be image/prod456.jpg", product.img_url == "image/prod456.jpg");									
			
			assertTrue("product artist will be Artist 1", product.artist.name == "Artist 1");
			assertFalse("product artist will not be Artist 234", product.artist.name == "Artist 234");												
			
		}		
		
		
	}
}