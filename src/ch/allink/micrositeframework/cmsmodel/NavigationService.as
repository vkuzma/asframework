package ch.allink.micrositeframework.cmsmodel
{
import ch.allink.micrositeframework.view.NavigationView;

import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;

public class NavigationService extends EventDispatcher
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var languages:Array
	public var navigations:Vector.<Navigation>
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function NavigationService(target:IEventDispatcher = null)
	{
		super(target)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	private function activate(activatedNavigationView:NavigationView):void
	{
		for each(var navigationView:NavigationView in _navigationViews)
		{
			if(activatedNavigationView == navigationView)
				navigationView.activate()
			else
				navigationView.deactivate()
		}
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function buildTree(collection:Vector.<Navigation>):void
	{
		var navigation:Navigation
		languages = []
		for each (navigation in collection)
		{
			var langID:Number = navigation.languageid
			if (!languages[langID])
				languages[langID] = new Vector.<Navigation>
		}
		
		for each (navigation in collection)
		{	
			languages[navigation.languageid].push(navigation)
			for each (var parentNavigation:Navigation in collection)
			{
				if (navigation.parentid != 0 
					&& navigation.parentid == parentNavigation.id 
					&& navigation.languageid == parentNavigation.languageid)
				{
					parentNavigation.addChild(navigation)
					break
				}
			}
		}
	}
	
	public function rootElements(languageID:Number):Vector.<Navigation>
	{
		var navigationsNew:Vector.<Navigation> = new Vector.<Navigation>;
		var navigations:Vector.<Navigation> = languages[languageID];
		for each (var navigation:Navigation in navigations)
		{
			if (navigation.parentid == 0)
				navigationsNew.push(navigation)
		}
		return navigationsNew
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function navigationView_clickHandler(event:MouseEvent):void
	{
		var navigationView:NavigationView = event.target as NavigationView
		activate(navigationView)
	}
	
	private function navigationView_activatedHandler(event:NavigationView):void
	{
		
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	private var _navigationViews:Vector.<NavigationView>
	public function set navigationViews(value:Vector.<NavigationView>):void
	{
		_navigationViews = value
		for each(var navigationView:NavigationView in _navigationViews)
		{
			navigationView.addEventListener(MouseEvent.CLICK, 
											navigationView_clickHandler)
			navigationView.addEventListener(NavigationView.ACTIVATED,
											navigationView_activatedHandler)
		}
	}
	
	public function get navigationViews():Vector.<NavigationView>
	{
		return _navigationViews
	}
}
}