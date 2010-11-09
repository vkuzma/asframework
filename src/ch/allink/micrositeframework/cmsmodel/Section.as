package ch.allink.micrositeframework.cmsmodel
{

/**
 * Die Section Klasse dient als Model für eine SectionView Instanz.
 * @author Michael Walder
 * @date 7.11.2010
 * @see ch.allink.micrositeframework.cmsview.SectionView
 **/

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