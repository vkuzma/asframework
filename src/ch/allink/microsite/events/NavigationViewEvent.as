package ch.allink.microsite.events
{

import ch.allink.microsite.navigationElement.NavigationView;

import flash.events.Event;

public class NavigationViewEvent extends Event
{
	public static const CLICK:String = "navigationClick"
	public static const ACTIVATED:String = "navigationActivatedd"
	public static const DEACTIVATED:String = "navigationDeActivatedd"
	public static const REQUEST_ACTIVATE:String = "navigationRequestActivate"
	public static const CAPTURED_FIRST:String = "capturedFirst"
	
	private var _navigationView:NavigationView
	public var capture:Boolean
	
	public function NavigationViewEvent(type:String, bubbles:Boolean = false, 
										cancelable:Boolean = false, 
										navigationView:NavigationView = null)
	{
		super(type, bubbles, cancelable)
		_navigationView = navigationView
	}
	
	public override function clone():Event
	{
		return new NavigationViewEvent(type, bubbles, cancelable, 
			navigationView)
	}
	
	public function get navigationView():NavigationView
	{
		return _navigationView
	}
		
}
}