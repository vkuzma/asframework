package ch.allink.micrositeframework.cmsmodel
{
	
public class Section extends AllinkCMSBaseModel
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	public var title:String
	public var date:String
	public var content:String
	public var type:String
	public var format:String
	public var extraFields:String
	public var pageid:int
	
	private var _files:Array
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function Section()
	{
		super()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function set files(values:Array):void
	{
			_files = fillCollection(Image, values)
	}
	
	public function get files():Array
	{
		return _files
	}
}
}