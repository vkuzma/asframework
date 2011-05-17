package ch.allink.sandbox
{
import ch.allink.microsite.core.AbstractWebsiteView;
import ch.allink.microsite.events.NavigationViewEvent;

import com.asual.swfaddress.SWFAddress;
import com.asual.swfaddress.SWFAddressEvent;

import flash.events.Event;

public final class WebsiteView extends AbstractWebsiteView
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var pageNavigationView:PageNavigationView
	private var contentView:ContentView
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function WebsiteView()
	{
		super()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Overriden methods
	//
	//-------------------------------------------------------------------------
	
	public override function build():void
	{
		//Pagenavigation
		pageNavigationView = new PageNavigationView()
		addChild(pageNavigationView)
		pageNavigationView.build()
		pageNavigationView.addEventListener(NavigationViewEvent.CAPTURED_FIRST,
			pageNavigation_capturedFirstHandler)
		pageNavigationView.addEventListener(PageNavigationView.READY,
			pageNavigationView_readyHandler, false, 0, true)
		
		contentView = new ContentView()
		addChild(contentView)
		contentView.build()
		contentView.x = 100
			
		addEventListener(Event.RESIZE, resizeHandler)
		resizeHandler(null)
	}		
	
	public override function swfaddress_changeHandler(event:SWFAddressEvent):void
	{
		if(event.value != "/")
		{
			contentView.buildPageByURL(event.value)
			pageNavigationView.setActive(event.value)
		}
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
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function pageNavigation_capturedFirstHandler(event:NavigationViewEvent):void
	{
		var url:String = event.navigationView.navigation.url
		SWFAddress.setValue(url)
	}

	private function resizeHandler(event:Event):void
	{
		//Resize
	}
	
	private function pageNavigationView_readyHandler(event:Event):void
	{
		initializeHistoryManagement()
	}
}
}