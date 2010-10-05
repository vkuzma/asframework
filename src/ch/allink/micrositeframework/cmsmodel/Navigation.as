package ch.allink.micrositeframework.cmsmodel
{
public class Navigation extends AllinkCMSBaseModel
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	public var id:int = 0
	public var navigationid:int = 0
	public var languageid:int = 0
	public var parentid:int = 0
	public var sortorder:int = 0
	public var visiblecontent:Boolean = false
	public var indexpagefileid:int = 0
	public var indexpagetitle:String = ""
	public var indexpageformats:String = ""
	public var title:String = ""
	public var format:String = ""

	
	public static var languages:Array
	
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function Navigation()
	{
		super()
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
	
	private var _pages:String
	public function set pages(value:String):void
	{
		_pages = value
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