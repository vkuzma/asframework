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
	
	public var title:String
	public var url:String
	public var slug:String
	private var _children:Vector.<Navigation>
	private var _parentNavigation:Navigation
	
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
		children.push(navigation)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function set children(value:Vector.<Navigation>):void
	{
		_children = value
	}
	
	public function get children():Vector.<Navigation>
	{
		if(!_children) _children = new Vector.<Navigation>()
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
		if(children.length) hasChildren = true
			
		return hasChildren
	}
}
}