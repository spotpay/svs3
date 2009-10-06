package Tests 
{	
	import flexunit.framework.TestCase;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.facade.FabricationFacade;
	import flash.events.Event;
	import Tests.mock.models.MockProduct;
	
	public class UnmarshallOverrideTest extends TestCase
	{
		public function UnmarshallOverrideTest():void
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
		 
		public function testUnmarshallOverride():void
		{
			var prod:MockProduct = new MockProduct();
			prod.HandleSuccess(new Event("complete"));
		}
	}		 	
}