package ch.allink.micrositeframework.cmsmodel
{

public class Page extends AllinkCMSBaseModel
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	public var title:String
	public var format:String
	public var extraFields:String
	public var fileid:int
	public var languageid:int
	public var visiblecontent:Boolean
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function Page()
	{
		super()
	}
	
	//-------------------------------------------------------------------------
	//
	//  Properties
	//
	//-------------------------------------------------------------------------
	
	public var _sections:Array
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