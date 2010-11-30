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
	private var navigationViews:Vector.<NavigationView>
	
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
	
	/**
	 * Creates a tree of navigations.
	 */
	private function makeNavigationTree(navigations:Vector.<Navigation>):
		Vector.<Navigation>
	{
		var topLevelNavigation:Vector.<Navigation> = new Vector.<Navigation>
		for each(var navigation:Navigation in navigations)
		{
			var navigationURL:Array = navigation.url.
				substring(1, navigation.url.length - 1).split('/')
			if(navigationURL.length > 1)
			{
				var childNavigation:Navigation = 
					getNavigationByName(navigationURL.pop(), navigations)
				var parentNavigation:Navigation = 
					getNavigationByName(navigationURL.pop(), navigations)
				if(!parentNavigation.children)
					parentNavigation.children = new Vector.<Navigation>
				parentNavigation.children.push(childNavigation)
			}
			
			if(!navigation.parentSlug)
				topLevelNavigation.push(navigation)
		}
		return topLevelNavigation
	}
	
	private function makeNavigationViewTree(navigations:Vector.<Navigation>,
		navigationTreeView:NavigationTreeView):Vector.<NavigationView>
	{
		var navigationChildren:Vector.<NavigationView> = 
			new Vector.<NavigationView>
		for each(var navigation:Navigation in navigations)
		{
			var navigationView:NavigationView = new NavigationView(navigation)
			navigationChildren.push(navigationView)
			if(navigation.children)
			{
				navigationView.navigationTreeView = new NavigationTreeView()
				navigationTreeView.addChild(navigationView.navigationTreeView)
				navigationView.navigationTreeView.navigationViews = 
					makeNavigationViewTree(navigation.children, 
						navigationView.navigationTreeView)
			}
		}
		return navigationChildren
	}
	
	private function getNavigationByName(name:String, 
									navigations:Vector.<Navigation>):Navigation
	{
		var returnValue:Navigation
		for each(var navigation:Navigation in navigations)
		{
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
		var topLevelNavigation:Vector.<Navigation> = 
			makeNavigationTree(navigations)
		_navigationTreeView.navigationViews = 
			makeNavigationViewTree(topLevelNavigation, _navigationTreeView)
		
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