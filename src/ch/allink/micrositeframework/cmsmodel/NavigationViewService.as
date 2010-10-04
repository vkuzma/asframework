package ch.allink.micrositeframework.cmsmodel
{
import ch.allink.micrositeframework.view.NavigationView;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;

/** 
 * Verwaltet einen Navigationsbaum
 * 
 * @author Vladimir Kuzma
 */


public class NavigationViewService extends EventDispatcher
{
	
	public static const NAVIGATION_CLICKED:String = "navigationClicks"
		
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var languages:Array
	public var navigations:Vector.<Navigation>
	public var pageID:int
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function NavigationViewService(target:IEventDispatcher = null)
	{
		super(target)

	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	private function navigationForIDInNavigations(id:int,
							 		navigations:Vector.<Navigation>):Navigation
	{
		var targetNavigation:Navigation
		
		for each(var navigation:Navigation in navigations)
		{
			if(navigation.id == id)	
			{
				targetNavigation = navigation
				break
			}
			else if(navigation.children != null)
			{
				targetNavigation = navigationForIDInNavigations(id, 
														   navigation.children)
				break
			}
			else
			{
				targetNavigation = null
			}
		}
		return targetNavigation
	}
	
	private function navigationForIDInNavigationViews(id:int,
							navigationViews:Vector.<NavigationView>):Navigation
	{
		var targetNavigation:Navigation
		
		for each(var navigationView:NavigationView in navigationViews)
		{
			var navigation:Navigation = navigationView.navigation
			if(navigation.children)
			{
				targetNavigation = navigationForIDInNavigations(id, 
															navigation.children)
				break
			}	
			else if(navigation.id == id)
			{
				targetNavigation = navigation
				break
			}
			else
			{
				targetNavigation = null	
			}
		}
		return targetNavigation
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
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
	
	public function navigationByPageID(id:int):Navigation
	{
//		Könnte auch eine statische Methode sein
		var targetNavigation:Navigation
		if(navigations)
			targetNavigation = navigationForIDInNavigations(id, navigations)
		else if(navigationViews)
			targetNavigation = navigationForIDInNavigationViews(id, 
																navigationViews)
		else
			targetNavigation = null
				
			
		return targetNavigation
	}
	
	public function activate(activatedNavigationView:NavigationView):void
	{
		for each(var navigationView:NavigationView in _navigationViews)
		{
			if(activatedNavigationView == navigationView)
				navigationView.active = true
			else
				navigationView.active = false
		}
	}
	
	
//	public function openAnimation()
		
//	public function closeAnimation()
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function navigationView_clickHandler(event:MouseEvent):void
	{
		var navigationView:NavigationView = event.target as NavigationView
		activate(navigationView)
		pageID = navigationView.navigation.id
		dispatchEvent(new Event(NAVIGATION_CLICKED))
	}
	
	private function navigationView_activatedHandler(event:Event):void
	{
		if(_parentNavigationView)
			_parentNavigationView.requestActivate()
	}
	
	public function navigationView_requestActivatedHandler(event:Event):void
	{
		var navigationView:NavigationView = event.target as NavigationView
		activate(navigationView)
	}
	
	private function parentNavigationV_deactivateHandler(event:Event):void
	{
		activate(null)	
	}
	
	private function navigationView_subNavigationClicked(event:Event):void
	{
		var navigationView:NavigationView = event.target as NavigationView
		var navigationViewService:NavigationViewService = navigationView.
														  navigationService
		pageID = navigationViewService.pageID
		dispatchEvent(new Event(NAVIGATION_CLICKED))
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
//		Es ist nicht nötig die navigations und navigationViews zugleich 
//		zu speichern
		navigations = null
			
		for each(var navigationView:NavigationView in _navigationViews)
		{
			navigationView.addEventListener(MouseEvent.CLICK, 
											navigationView_clickHandler)
			navigationView.addEventListener(NavigationView.ACTIVATED,
											navigationView_activatedHandler)
			navigationView.addEventListener(NavigationView.REQUEST_ACTIVATE,
										navigationView_requestActivatedHandler)
			navigationView.addEventListener(NavigationView.
											SUB_NAVIGATION_CLICKED,
											navigationView_subNavigationClicked)
		}
	}

	public function get navigationViews():Vector.<NavigationView>
	{
		return _navigationViews
	}

	private var _parentNavigationView:NavigationView
	public function set parentNavigationView(value:NavigationView):void
	{
		_parentNavigationView = value
		_parentNavigationView.addEventListener(NavigationView.DEACTIVATED,
										    parentNavigationV_deactivateHandler)
	}
	
	public function get parentNavigationView():NavigationView
	{
		return _parentNavigationView
	}
}
}