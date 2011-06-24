package ch.allink.sandbox
{
import ch.allink.microsite.core.AbstractView;
import ch.allink.microsite.events.NavigationViewEvent;
import ch.allink.microsite.events.ResultEvent;
import ch.allink.microsite.navigationElement.AccordionNavigationOperation;
import ch.allink.microsite.navigationElement.NavigationFactory;
import ch.allink.microsite.navigationElement.NavigationTreeView;

import flash.events.Event;

public final class PageNavigationView extends AbstractView
{
	//-------------------------------------------------------------------------
	//
	//	Constants
	//
	//-------------------------------------------------------------------------
	
	public static const READY:String = "ready"
		
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var navigationFactory:NavigationFactory
	private var navigationTreeView:NavigationTreeView
	private var navigationOperation:AccordionNavigationOperation
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function PageNavigationView()
	{
		super()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Override methods
	//
	//-------------------------------------------------------------------------
	
	public override function build():void
	{
		navigationOperation = new AccordionNavigationOperation()
		navigationFactory = new NavigationFactory(navigationOperation)
		navigationFactory.addEventListener(ResultEvent.DATA_LOADED, 
			navigationFactory_dataLoadedHandler)
		navigationFactory.buildByLanguage(Config.defaultLanguage)
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
	
	public function setActive(url:String):void
	{
		navigationTreeView.activateNavigationViewByURL(url)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function navigationFactory_dataLoadedHandler(event:ResultEvent):void
	{
		var navigationFactory:NavigationFactory = event.currentTarget as NavigationFactory
		navigationTreeView = navigationFactory.navigationTreeView
		addChild(navigationTreeView)
		
		navigationTreeView.addEventListener(NavigationViewEvent.CAPTURED_FIRST, 
			navigationTreeView_activatedHandler)
		dispatchEvent(new Event(PageNavigationView.READY))
	}
	
	private function navigationTreeView_activatedHandler(
		event:NavigationViewEvent):void
	{
		dispatchEvent(event)	
	}
}
}