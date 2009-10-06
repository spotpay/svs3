//This class is used for UnmarshallOverrideTest do not alter this class - JB

package Tests.mock.models
{
	import models.Product;
	import models.CrudModel;
	import flash.events.Event;

	public class MockCrudModel extends CrudModel
	{
		protected override function handleSuccess(e:Event):void
		{
			Unmarshall(new Object());
		}

		public function HandleSuccess(e:Event):void
		{
			handleSuccess(e);
		}
	
		public function Unmarshall(model:Object):void
		{
			throw new Error("override not reached!");	
		}		
	}
}
