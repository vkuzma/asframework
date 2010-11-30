package ch.allink.microsite.navigationElement
{
import ch.allink.microsite.events.NavigationViewEvent;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;

/** 
 * Verwaltet einen Navigationsbaum
 * 
 * @author Vladimir Kuzma
 **/
public class NavigationTreeView extends Sprite
{
	
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _navigationViews:Vector.<NavigationView>
	private var _parentNavigationView:NavigationView
	public var navigations:Vector.<Navigation>
	
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
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
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
	
	public function reset():void
	{
		for each(var navigationView:NavigationView in _navigationViews)
			navigationView.active = false
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
			
		//Deaktiviert Unternavigationen
		if(navigationView.navigationTreeView != null)
			navigationView.navigationTreeView.activate(null)
			
		var bubbleEvent:NavigationViewEvent = new NavigationViewEvent(
			NavigationViewEvent.NAVIGATION_CLICK, false, false, navigationView)
		dispatchEvent(bubbleEvent)
		
	}
	
	private function navigationView_activatedHandler(
		event:NavigationViewEvent):void
	{
		if(parentNavigationView)
			parentNavigationView.requestActivate()
				
	}
	
	public function navigationView_requestActivatedHandler(event:Event):void
	{
		var navigationView:NavigationView = event.target as NavigationView
		activate(navigationView)
	}
	
	private function parentNavigationV_deactivateHandler(
		event:NavigationViewEvent):void
	{
		activate(null)	
		closeAnimation()
	}
	
	private function parentNavigationV_activateHandler(
		event:NavigationViewEvent):void
	{
		openAnimation()
	}
	
	private function navigationView_subNavigationClicked(
		event:NavigationViewEvent):void
	{
		var navigationView:NavigationView = event.target as NavigationView
		var navigationViewService:NavigationTreeView = navigationView.
														  navigationTreeView
		dispatchEvent(event)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function set navigationViews(value:Vector.<NavigationView>):void
	{
		_navigationViews = value
//		Es ist nicht nötig die navigations und navigationViews zugleich 
//		zu speichern
		navigations = null
			
		for each(var navigationView:NavigationView in _navigationViews)
		{
			addChild(navigationView)
			navigationView.addEventListener(MouseEvent.CLICK, 
											navigationView_clickHandler)
			navigationView.addEventListener(NavigationViewEvent.ACTIVATED,
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

	public function set parentNavigationView(value:NavigationView):void
	{
		_parentNavigationView = value
		_parentNavigationView.addEventListener(NavigationViewEvent.DEACTIVATED,
										    parentNavigationV_deactivateHandler)
		_parentNavigationView.addEventListener(NavigationViewEvent.ACTIVATED,
										    parentNavigationV_activateHandler)
	}
	
	public function get parentNavigationView():NavigationView
	{
		return _parentNavigationView
	}
}
}