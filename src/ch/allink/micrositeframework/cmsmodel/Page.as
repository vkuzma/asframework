package ch.allink.micrositeframework.cmsmodel
{
	import ch.allink.micrositeframework.model.ModelFactory;
	
	import mx.core.UIComponent;
	
	public class Page extends AllinkCMSBaseModel
	{
		public var title:String
		public var format:String
		public var extraFields:String
		public var _sections:Array
		public var fileid:int
		public var languageid:int
		public var visiblecontent:Boolean
		
		
		public function Page()
		{
			super();
		}
		
		public function set sections(values:Array):void
		{
			_sections = fillCollection(Section, values)
		}
		
		public function get sections():Array
		{
			return _sections
		}
	}
}