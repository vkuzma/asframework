package ch.allink.microsite.util
{
import flash.external.ExternalInterface;

/**
 * @author vkuzma
 * @date Dec 30, 2010
 **/
public class GoogleAnalytics
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	public static var ACTIVATE_EXTERNAL_INTERFACE:Boolean = true
		
	private static var TRACK_EVENT:String = "trackEvent"
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function GoogleAnalytics()
	{
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	public static function trackAnalyticsEvent(category:String, action:String, 
											   optional_label:String = "", 
											   optional_value:int = 0):void
	{
		if (ACTIVATE_EXTERNAL_INTERFACE)
			ExternalInterface.call(TRACK_EVENT, category, action, 
								   optional_label, optional_value)
	}
	
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	
}
}