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
	
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
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
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function navigationForIDInNavigations(id:int,
							 		navigations:Vector.<Navigation>):Navigation
	{
		var targetNavigation:Navigation
		
		for each(var navigation:Navigation in navigations)
		{
			if(navigation.indexPageID == id)	
			{
				targetNavigation = navigation
				break
			}
			else if(navigation.children)
			{
				targetNavigation = navigationForIDInNavigations(id, 
														   navigation.children)
				if(targetNavigation)
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
			if(navigation.indexPageID == id)
			{
				targetNavigation = navigation
				break
			}
			 else if(navigation.children)
			{
				targetNavigation = navigationForIDInNavigations(id, 
															navigation.children)
				if(targetNavigation)
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
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function navigationByPageID(id:int):Navigation
	{
		var targetNavigation:Navigation
		if(navigations)
			targetNavigation = navigationForIDInNavigations(id, navigations)
		else if(_navigationViews)
			targetNavigation = navigationForIDInNavigationViews(id, 
															_navigationViews)
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
	
	public function openAnimation():void
	{
		
	}
		
	public function closeAnimation():void
	{
		
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function navigationView_clickHandler(event:MouseEvent):void
	{
		var navigationView:NavigationView = event.currentTarget as 
												NavigationView
		activate(navigationView)
		pageID = navigationView.navigation.navigationid
			
		//Deaktiviert Unternavigationen
		if(navigationView.navigationService != null)
			navigationView.navigationService.activate(null)
			
		var bubbleEvent:NavigationViewEvent = new NavigationViewEvent(
			NavigationViewEvent.NAVIGATION_CLICK, false, false, navigationView)
		dispatchEvent(bubbleEvent)
		
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
		closeAnimation()
	}
	
	private function parentNavigationV_activateHandler(event:Event):void
	{
		openAnimation()
	}
	
	private function navigationView_subNavigationClicked(
		event:NavigationViewEvent):void
	{
		var navigationView:NavigationView = event.target as NavigationView
		var navigationViewService:NavigationViewService = navigationView.
														  navigationService
		pageID = navigationViewService.pageID
		dispatchEvent(event)
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
			navigationView.addEventListener(NavigationViewEvent.
											NAVIGATION_CLICK,
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
		_parentNavigationView.addEventListener(NavigationView.ACTIVATED,
										    parentNavigationV_activateHandler)
	}
	
	public function get parentNavigationView():NavigationView
	{
		return _parentNavigationView
	}
}
}