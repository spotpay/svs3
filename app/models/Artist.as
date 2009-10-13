package models
{

	import mx.controls.Alert;
	import models.CrudModel;
		
	public class Artist extends CrudModel
	{
		public var name:String = "Yea Yea Yea" ;

		public function Artist()
		{
			restName = "artists" ;
		}
		
		public override function Unmarshall(model:Object):void{
			name = model.name ;
		
			/*
			var rawData:String = String(model) ;
			var campaignData = JSON.decode(rawData);
			name = campaignData.name ;
			*/
		}	
	}
}