package ch.allink.micrositeframework.cmsmodel
{
public class Navigation extends AllinkCMSBaseModel
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	public var navigationid:int = 0
	public var languageid:int = 0
	public var parentid:int = 0
	public var sortorder:int = 0
	public var visiblecontent:Boolean = false
	public var indexpagefileid:int = 0
	public var indexpagetitle:String = ""
	public var indexpageformats:String = ""
	public var title:String = ""
	private var _pages:String
	public var indexPageID:int

	
	public static var languages:Array
	
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	// 
	//-------------------------------------------------------------------------
	
	public function Navigation()
	{
		super()
		_children = new Vector.<Navigation>
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function addChild(navigation:Navigation):void
	{
		_children.push(navigation)
	}
	
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function set pages(value:String):void
	{
		_pages = value
		indexPageID = _pages.split(',')[0]
	}
	
	public function get pages():String	
	{
		return _pages
	}
	
	private var _children:Vector.<Navigation>
	public function set children(value:Vector.<Navigation>):void
	{
		_children = value
	}
	
	public function get children():Vector.<Navigation>
	{
		return _children
	}
}
}