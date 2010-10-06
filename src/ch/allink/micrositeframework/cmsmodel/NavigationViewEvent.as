package ch.allink.micrositeframework.cmsmodel
{
import ch.allink.micrositeframework.view.NavigationView;

import flash.events.Event;

public class NavigationViewEvent extends Event
{
	public static const NAVIGATION_CLICK:String = "navigationClick"
	
	public var navigationView:NavigationView
	
	public function NavigationViewEvent(type:String, bubbles:Boolean=false, 
										cancelable:Boolean=false, 
										navigationView:NavigationView = null)
	{
		super(type, bubbles, cancelable)
		this.navigationView = navigationView
		
	}
}
}