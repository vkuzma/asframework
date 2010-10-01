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
	private var _pages:String
	
	public static var languages:Array
	
	
	private var _children:Vector.<Navigation>
	
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
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function set pages(value:String):void
	{
		_pages = value
	}
	
	public function get pages():String	
	{
		return _pages
	}
	
	public function addChild(n:Navigation):void
	{
		_children.push(n)
	}
	
	public function get Children():Vector.<Navigation>
	{
		return _children
	}
}
}