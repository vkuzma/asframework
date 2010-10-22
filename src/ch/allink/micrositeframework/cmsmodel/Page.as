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
	
	private var _sections:Array
	public function set sections(values:Array):void
	{
		_sections = fillCollection(Section, values)
	}
	
	public function get sections():Array
	{
		return _sections
	}
	
	public function get files():Vector.<Image>
	{
		var files:Vector.<Image> = new Vector.<Image>
		for each(var section:Section in _sections)
		{
			for each(var file:Image in section.files)
			{
				files.push(file)
			}
		}
		
		return files
	}
}
}