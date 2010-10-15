package ch.allink.micrositeframework.cmsmodel
{
import ch.allink.micrositeframework.view.NavigationView;

import flash.events.Event;

public class NavigationViewEvent extends Event
{
	public static const NAVIGATION_CLICK:String = "navigationClick"
	public static const ACTIVATED:String = "activatedd"
	public static const DEACTIVATED:String = "deActivatedd"
	
	public var navigationView:NavigationView
	
	public function NavigationViewEvent(type:String, bubbles:Boolean=false, 
										cancelable:Boolean=false, 
										navigationView:NavigationView = null)
	{
		super(type, bubbles, cancelable)
		this.navigationView = navigationView
		
	}
	
	public override function clone():Event
	{
		return new NavigationViewEvent(type, bubbles, cancelable, 
			navigationView)
	}
}
}