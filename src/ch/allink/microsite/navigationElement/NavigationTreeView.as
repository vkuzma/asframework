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
	public var pageID:int
	
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
	
	private function navigationForIDInNavigations(id:int,
							 		navigations:Vector.<Navigation>,
									condition:Function):Navigation
	{
		var targetNavigation:Navigation
		
		for each(var navigation:Navigation in navigations)
		{
			if(condition(navigation, id))	
			{
				targetNavigation = navigation
				break
			}
			else if(navigation.children)
			{
				targetNavigation = navigationForIDInNavigations(id, 
												navigation.children, condition)
				if(targetNavigation)
					break
			}
		}
		return targetNavigation
	}
	
	private function navigationForIDInNavigationViews(id:int,
							navigationViews:Vector.<NavigationView>,
							condition:Function):Navigation
	{
		var targetNavigation:Navigation
		
		for each(var navigationView:NavigationView in navigationViews)
		{
			var navigation:Navigation = navigationView.navigation
			if(condition(navigation, id))
			{
				targetNavigation = navigation
				break
			}
			 else if(navigation.children)
			{
				targetNavigation = navigationForIDInNavigations(id, 
												navigation.children, condition)
				if(targetNavigation)
					break
			}	
		}
		return targetNavigation
	}
	
	private function checkNavigationID(navigation:Navigation, ID:int):Boolean
	{
		var value:Boolean
		if(navigation.navigationid == ID)
			value = true
		else
			value = false
				
		return value
	}
	
	private function checkIndexPageID(navigation:Navigation, ID:int):Boolean
	{
		var value:Boolean
		if(navigation.indexPageID == ID)
			value = true
		else
			value = false
				
		return value
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
			targetNavigation = navigationForIDInNavigations(id, navigations,
				checkIndexPageID)
		else if(_navigationViews)
			targetNavigation = navigationForIDInNavigationViews(id, 
										    _navigationViews, checkIndexPageID)
		return targetNavigation
	}
	
	public function navigationByNavigationID(id:int):Navigation
	{
		var targetNavigation:Navigation
		if(navigations)
			targetNavigation = navigationForIDInNavigations(id, navigations,
				checkNavigationID)
		else if(_navigationViews)
			targetNavigation = navigationForIDInNavigationViews(id, 
				_navigationViews,
				checkNavigationID)
		return targetNavigation
	}
	
	public function navigationViewByNavigationID(id:int, 
		navigationViews:Vector.<NavigationView> = null):NavigationView
	{
		var targetNavigationView:NavigationView
		if(!navigationViews)
			navigationViews = this.navigationViews
		
		for each(var navigationView:NavigationView in navigationViews)
		{
			var navigation:Navigation = navigationView.navigation
			if(navigation.navigationid == id)	
			{
				targetNavigationView = navigationView
				break
			}
			else if(navigationView.navigationService)
			{
				targetNavigationView = navigationViewByNavigationID(id, 
					navigationView.navigationService.navigationViews)
				if(targetNavigationView)
					break
			}
		}
		return targetNavigationView
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
		pageID = navigationView.navigation.navigationid
			
		//Deaktiviert Unternavigationen
		if(navigationView.navigationService != null)
			navigationView.navigationService.activate(null)
			
		var bubbleEvent:NavigationViewEvent = new NavigationViewEvent(
			NavigationViewEvent.NAVIGATION_CLICK, false, false, navigationView)
		dispatchEvent(bubbleEvent)
		
	}
	
	private function navigationView_activatedHandler(
		event:NavigationViewEvent):void
	{
		if(_parentNavigationView)
			_parentNavigationView.requestActivate()
				
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
														  navigationService
		pageID = navigationViewService.pageID
		dispatchEvent(event)
	}
	
	private function makeTree(navigationViews:Vector.<NavigationView>):void
	{
		for each(var navigationView:NavigationView in navigationViews)
		{
			var navigation:Navigation = navigationView.navigation
			var navigationURL:Array = navigation.url.
				substring(1, navigation.url.length - 1).split('/')
			if(navigationURL.length > 1)
			{
				var childNavigation:Navigation = 
					getNavigationByName(navigationURL.pop())
				var parentNavigation:Navigation = 
					getNavigationByName(navigationURL.pop())
				if(!parentNavigation.children)
					parentNavigation.children = new Vector.<Navigation>
				parentNavigation.children.push(childNavigation)
			}
		}
	}
	
	private function getNavigationByName(name:String):Navigation
	{
		var returnValue:Navigation
		for each(var navigationView:NavigationView in navigationViews)
		{
			var navigation:Navigation = navigationView.navigation
			if(navigation.slug == name)
			{
				returnValue = navigation
				break
			}
		}
		return returnValue
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function set navigationViews(value:Vector.<NavigationView>):void
	{
		_navigationViews = value
		makeTree(_navigationViews)
//		Es ist nicht nötig die navigations und navigationViews zugleich 
//		zu speichern
		navigations = null
			
		for each(var navigationView:NavigationView in _navigationViews)
		{
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