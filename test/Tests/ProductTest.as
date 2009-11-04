package Tests
{
	import flexunit.framework.TestCase;
	import flash.net.URLRequestMethod;
	import models.Product;
	import Musicane.FlashRestUtils.RestRequest;
	

	public class ProductTest extends TestCase
	{
		public function ProductTest()
		{
			
		}
		
		public function testShow():void{
			var product:Product = new Product();
			var req:RestRequest = product.Show("123");
						
			assertTrue("http method is GET", URLRequestMethod.GET, req.Request.method);
			assertTrue("Path will not be products/456", req.Path == "products/123");
		}
	}
}