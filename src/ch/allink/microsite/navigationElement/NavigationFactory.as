package ch.allink.microsite.navigationElement
{
import ch.allink.microsite.cmsConnector.CMSXmlPath;
import ch.allink.microsite.cmsConnector.ModelFactory;
import ch.allink.microsite.cmsConnector.ModelRequest;
import ch.allink.microsite.events.ResultEvent;

import flash.events.EventDispatcher;

public final class NavigationFactory extends EventDispatcher
{
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	private var _navigationTreeView:NavigationTreeView
	private var _navigationOperation:INavigationOperation
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function NavigationFactory(
		navigationFormatter:INavigationOperation = null)
	{
		_navigationOperation = navigationFormatter
	}
	
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function buildNavigationViews(navigations:Vector.<Navigation>):void
	{
		var navigationViews:Vector.<NavigationView> = 
			new Vector.<NavigationView>
		for each(var navigation:Navigation in navigations)
		{
			var navigationView:NavigationView = new NavigationView(navigation)
			navigationTreeView.addChild(navigationView)
			navigationViews.push(navigationView)
			navigationView.build()
		}
		navigationTreeView.navigationViews = navigationViews
	}
	

	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function build():void
	{
		var modelFactory:ModelFactory = new ModelFactory()
		var modelReqeust:ModelRequest = modelFactory.load(Navigation,
			CMSXmlPath.NAVIGATION_PATH,
			ModelFactory.TYPE_COLLECTION)
		modelReqeust.addEventListener(ResultEvent.DATA_LOADED,
			modelRequest_dataLoadedHandler)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers 
	//
	//-------------------------------------------------------------------------
	
	private function modelRequest_dataLoadedHandler(event:ResultEvent):void
	{
		var navigations:Vector.<Navigation> = Vector.<Navigation>(
			event.collection)
		_navigationTreeView = new NavigationTreeView()
		buildNavigationViews(navigations)
		
		if(navigationOperation)
		{
			navigationOperation.targetView = navigationTreeView					
			navigationOperation.initialize()
		}
		
		dispatchEvent(event)
	}
	
	public function get navigationTreeView():NavigationTreeView
	{
		return _navigationTreeView
	}
	
	public function set navigationOperation(value:INavigationOperation):void
	{
		_navigationOperation = value
	}
	
	public function get navigationOperation():INavigationOperation
	{
		return _navigationOperation
	}
}
}