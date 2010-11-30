package ch.allink.microsite.navigationElement
{
import ch.allink.microsite.core.AbstractModel;

public class Navigation extends AbstractModel
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
	public var url:String = ""
	public var slug:String = ""
	private var _pages:String
	private var _children:Vector.<Navigation> = new Vector.<Navigation>
	public var indexPageID:int
	private var _parentNavigation:Navigation

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
	
	public function set pages(value:String):void
	{
		_pages = value
		indexPageID = _pages.split(',')[0]
	}
	
	public function get pages():String	
	{
		return _pages
	}
	
	public function set children(value:Vector.<Navigation>):void
	{
		_children = value
	}
	
	public function get children():Vector.<Navigation>
	{
		return _children
	}
	
	public function set parentNavigation(value:Navigation):void
	{
		_parentNavigation = value
	}
	
	public function get parentNavigation():Navigation
	{
		return _parentNavigation
	}
	
	public function hasChildren():Boolean
	{
		var hasChildren:Boolean = false
		if(_children.length)
			hasChildren = true
			
		return hasChildren
	}
}
}