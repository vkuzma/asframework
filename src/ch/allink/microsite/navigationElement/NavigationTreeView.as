package ch.allink.microsite.navigationElement
{
import ch.allink.microsite.core.AbstractView;
import ch.allink.microsite.events.NavigationViewEvent;

import flash.events.Event;
import flash.events.MouseEvent;

/** 
 * Verwaltet einen Navigationsbaum
 * 
 * @author Vladimir Kuzma
 **/
public class NavigationTreeView extends AbstractView
{
	
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _navigationViews:Vector.<NavigationView>
	private var _parentNavigationView:NavigationView
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function NavigationTreeView()
	{
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function majorActivate(navigationView:NavigationView):void
	{
		activate(navigationView)
		
		//Deactivates subnavigations
		if(navigationView.navigationTreeView != null)
			navigationView.navigationTreeView.activate(null)
		
		var bubbleEvent:NavigationViewEvent = new NavigationViewEvent(
			NavigationViewEvent.NAVIGATION_CLICK, false, false, navigationView)
		dispatchEvent(bubbleEvent)
	}
	
	private function initializeNavigation(navigationView:NavigationView):void
	{
		addChild(navigationView)
		navigationView.addEventListener(MouseEvent.CLICK, 
										navigationView_clickHandler)
		navigationView.addEventListener(NavigationViewEvent.ACTIVATED,
										navigationView_activatedHandler)
		navigationView.addEventListener(NavigationView.REQUEST_ACTIVATE,
										navigationView_requestActivatedHandler)
		navigationView.addEventListener(NavigationView.REQUEST_MAJOR_ACTIVATE,
										navigationView_requestMajorActivate)
		navigationView.addEventListener(NavigationViewEvent.NAVIGATION_CLICK,
										navigationView_subNavigationClicked)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Activates the given NavigationView instance and their parent NavigationView
	 * instances. Deactivates the rest.
	 **/
	public function activate(toActivateNavigationView:NavigationView):void
	{
		for each(var navigationView:NavigationView in navigationViews)
		{
			if(toActivateNavigationView == navigationView)
				navigationView.active = true
			else
				navigationView.active = false
		}
	}
	
	/**
	 * Deactivates all NavigationView instances.
	 **/
	public function resetAll():void
	{
		for each(var navigationView:NavigationView in navigationViews)
			navigationView.active = false
	}
	
	public function addNavigationView(navigationView:NavigationView):void
	{
		initializeNavigation(navigationView)
		navigationViews.push(navigationView)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function navigationView_clickHandler(event:MouseEvent):void
	{
		var navigationView:NavigationView = event.currentTarget 
											as NavigationView
		majorActivate(navigationView)
	}
	
	private function navigationView_activatedHandler(
		event:NavigationViewEvent):void
	{
		if(parentNavigationView) parentNavigationView.requestActivate()
	}
	
	public function navigationView_requestActivatedHandler(event:Event):void
	{
		var navigationView:NavigationView = event.target as NavigationView
		if(!navigationView.active) activate(navigationView)
	}
	
	private function parentNavigationV_deactivateHandler(
		event:NavigationViewEvent):void
	{
		activate(null)	
	}
	
	private function navigationView_subNavigationClicked(
		event:NavigationViewEvent):void
	{
		var navigationView:NavigationView = event.target as NavigationView
		var navigationViewService:NavigationTreeView = navigationView.
														  navigationTreeView
		dispatchEvent(event)
	}
	
	private function navigationView_requestMajorActivate(event:Event):void
	{
		var navigationView:NavigationView = event.currentTarget 
											as NavigationView
		majorActivate(navigationView)	
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function set navigationViews(value:Vector.<NavigationView>):void
	{
		_navigationViews = value
			
		for each(var navigationView:NavigationView in _navigationViews)
			initializeNavigation(navigationView)
	}

	public function get navigationViews():Vector.<NavigationView>
	{
		if(!_navigationViews) _navigationViews = new Vector.<NavigationView>()
		return _navigationViews
	}

	public function set parentNavigationView(value:NavigationView):void
	{
		_parentNavigationView = value
		_parentNavigationView.addEventListener(NavigationViewEvent.DEACTIVATED,
										    parentNavigationV_deactivateHandler)
	}
	
	public function get parentNavigationView():NavigationView
	{
		return _parentNavigationView
	}
}
}