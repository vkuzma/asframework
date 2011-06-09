package ch.allink.microsite.navigationElement
{
import ch.allink.microsite.cmsConnector.CMSXmlPath;
import ch.allink.microsite.cmsConnector.ModelFactory;
import ch.allink.microsite.cmsConnector.ModelRequest;
import ch.allink.microsite.events.ResultEvent;

import flash.events.EventDispatcher;
import ch.allink.microsite.navigationElement.NavigationView;
import ch.allink.microsite.navigationElement.NavigationTreeView;

/**
 * Create a Navigation from the FeinCMS.
 * @author Vladimir Kuzma
 */
public class NavigationFactory extends EventDispatcher
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
		navigationOperation:INavigationOperation = null)
	{
		_navigationOperation = navigationOperation
		navigationViews = new Vector.<NavigationView>
	}
	
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Creates a tree of Navigation instances.
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
					getNavigationByURL(navigation.url, navigations)
				navigationURL.pop()
				var parentNavigation:Navigation = 
					getNavigationByURL(cleanUrl(navigationURL), navigations)
				parentNavigation.children.push(childNavigation)
				childNavigation.parentNavigation = parentNavigation
			}
			
			if(!navigation.parentNavigation)
				topLevelNavigation.push(navigation)
		}
		return topLevelNavigation
	}
	
	/**
	 * Creates a tree of NavigationView instances.
	 */
	private function makeNavigationViewTree(navigations:Vector.<Navigation>,
		navigationTreeView:NavigationTreeView):Vector.<NavigationView>
	{
		var navigationChildren:Vector.<NavigationView> = new Vector.<NavigationView>
		for each(var navigation:Navigation in navigations)
		{
			var navigationView:NavigationView = new NavigationView(navigation)
			navigationView.build()
			navigationViews.push(navigationView)
			navigationChildren.push(navigationView)
			if(navigation.hasChildren())
			{
				navigationView.navigationTreeView = new NavigationTreeView()
				navigationTreeView.addChild(navigationView.navigationTreeView)
				navigationView.navigationTreeView.navigationViews = 
					makeNavigationViewTree(navigation.children, navigationView.navigationTreeView)
			}
		}
		return navigationChildren
	}
	
	/**
	 * Returns a Navigation instance by URL.
	 * @url The URL of the desired Navigation instance.
	 * @navigations A Vector of Navigation instances, where the
	 *  quested Navigation instance should be.
	 */
	private function getNavigationByURL(url:String, 
									navigations:Vector.<Navigation>):Navigation
	{
		var returnValue:Navigation
		for each(var navigation:Navigation in navigations)
		{
			if(navigation.url == url)
			{
				returnValue = navigation
				break
			}
		}
		return returnValue
	}
	
	/**
	 * Makes an URL from an array with paths. (Django-conform)
	 */
	private function cleanUrl(path:Array):String
	{
		var hash:String = "/"
		var numPath:int = path.length
		for (var i:int = 0; i < numPath; i++)
		{
			hash += path[i]
			hash += "/"
		}
		return hash
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Builds a Navigation 
	 **/
	public function buildByLanguage(language:String, modelClass:Class = null):void
	{
		if(!modelClass) modelClass = Navigation
		var modelFactory:ModelFactory = new ModelFactory()
		modelFactory.addEventListener(ResultEvent.DATA_LOADED, modelRequest_dataLoadedHandler)
		modelFactory.load(modelClass, CMSXmlPath.getNavigationPathByLanguage(language),
			ModelFactory.TYPE_COLLECTION)
	}
	
	/**
	 * Return a NavigationView instance by url.
	 */
	public function getNavigationViewByURL(url:String):NavigationView
	{
		var navigationViewByURL:NavigationView
		for each(var navigationView:NavigationView in navigationViews)
		{
			if(navigationView.navigation.url == url+"/")
			{
				navigationViewByURL = navigationView
				break
			}
		}
		return navigationViewByURL
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers 
	//
	//-------------------------------------------------------------------------
	
	protected function modelRequest_dataLoadedHandler(event:ResultEvent):void
	{
		trace("navigation got")
		var navigations:Vector.<Navigation> = Vector.<Navigation>(event.collection)
		_navigationTreeView = new NavigationTreeView()
		var topLevelNavigation:Vector.<Navigation> = makeNavigationTree(navigations)
		navigationTreeView.navigationViews = 
			makeNavigationViewTree(topLevelNavigation, navigationTreeView)
		if(navigationOperation)
		{
			navigationOperation.targetView = navigationTreeView					
			navigationOperation.initialize()
		}
		dispatchEvent(event)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	/**
	 * The Topelevel NavigationTreeView instance. 
	 */
	public function get navigationTreeView():NavigationTreeView
	{
		return _navigationTreeView
	}
	
	/**
	 * NavigationOperation
	 */
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