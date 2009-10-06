package Tests
{
	import flexunit.framework.TestCase;
	
	import models.Artist;
	import Web.WebRequest;
	
	

	public class ArtistTest extends TestCase
	{
		public function ArtistTest()
		{
			
		}
		
		public function testShow():void{
			var artist:Artist = new Artist();
			var webReq:WebRequest = artist.Show("123");

			assertTrue("Path will be artists/123", webReq.Path == "artists/123");
			assertFalse("Path will not be artists/456",webReq.Path == "artists/456");
		}
		
		
		public function testUnmarshall():void{
			var artist:Artist = new Artist();
			
			var obj:Object = new Object() ;
			obj.name = "Artist 1" ;
			
			artist.Unmarshall(obj);
			
			assertTrue("artist name will be Artist 1", artist.name == "Artist 1");
			assertFalse("artist name will not be Artist 5", artist.name == "Artist 5");
			
			
		}		
		
		
	}
}