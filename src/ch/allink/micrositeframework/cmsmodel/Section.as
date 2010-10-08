package ch.allink.micrositeframework.cmsmodel
{
	
	public class Section extends AllinkCMSBaseModel
	{
		public var title:String
		public var date:String
		public var content:String
		public var type:String
		public var format:String
		public var extraFields:String
		public var pageid:int
		
		private var _files:Array
		
		public function Section()
		{
			super();
		}
		
		public function set files(values:*):void
		{
			if(values != '')
				_files = fillCollection(Image, values);
		}
		
		public function get files():*
		{
			return _files
		}
		
	}
}