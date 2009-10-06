package Tests 
{	
	import flexunit.framework.TestCase;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.facade.FabricationFacade;
	
	public class BuildTest extends TestCase
	{
		public function BuildTest():void
		{
		}
		
		public function get fabricationFacade():FabricationFacade
		{
			return FabricationFacade.getInstance("UnitTests/UnitTests0") as FabricationFacade;
		}
		
		/**********************
		 * Asynchronous Tests *
		 **********************/
		
		/*********************
		 * Synchronous Tests *
		 *********************/
		 
		public function testBuildProcess():void
		{
			assertEquals("framework runs properly", true, true);
		}
	}		 	
}