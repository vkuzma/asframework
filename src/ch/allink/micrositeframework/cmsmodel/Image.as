package ch.allink.micrositeframework.cmsmodel
{
	
	public class Image extends AllinkCMSBaseModel
	{
		
		public var width:Number = 0
		public var height:Number = 0
		public var mimetype:String = ""
		public var imglink:String = ""
		public var extraFields:String = ""
		
		private var _description:String = ""
		
		public function Image()
		{
			super()
		}
		
		public function set description(value:String):void
		{
			_description = value
		}
		
		public function get description():String{
			
			return _description
		}
	}
}