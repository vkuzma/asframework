package ch.allink.microsite.navigationElement
{
import ch.allink.microsite.core.AbstractView;
import ch.allink.microsite.events.NavigationViewEvent;
import ch.allink.microsite.util.Report;
import ch.allink.microsite.util.ReportService;

import flash.events.Event;
import flash.events.MouseEvent;

/** 
 * Verwaltet einen Navigationsbaum
 * 
 * @author Vladimir Kuzma
 **/
public class NavigationTreeView extends AbstractView
{
	
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _navigationViews:Vector.<NavigationView>
	private var _parentNavigationView:NavigationView
	public var report:Report
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function NavigationTreeView()
	{
		report = new Report(this)
		ReportService.addReport(report)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function initializeNavigation(navigationView:NavigationView):void
	{
		addChild(navigationView)
		navigationView.addEventListener(MouseEvent.CLICK, navigationView_clickHandler)
		navigationView.addEventListener(NavigationViewEvent.ACTIVATED,
										navigationView_activatedHandler)
		navigationView.addEventListener(NavigationViewEvent.REQUEST_ACTIVATE,
										navigationView_requestActivatedHandler)
		navigationView.addEventListener(NavigationViewEvent.CAPTURED_FIRST,
										navigationView_capturedFirstHandler)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Activates the given NavigationView instance and their parent NavigationView
	 * instances. Deactivates the rest.
	 **/
	public function activateNavigationView(
		toActivateNavigationView:NavigationView):void
	{
		report.print("Activate navigationView: " + toActivateNavigationView.name + 
					 ", deactivating the rest.")
		for each(var navigationView:NavigationView in navigationViews)
		{
			if(toActivateNavigationView == navigationView)
				navigationView.activate()
			else
				navigationView.deactivate()
		}
	}
	
	/**
	 * Deactivates all NavigationView instances.
	 **/
	public function resetAll():void
	{
		for each(var navigationView:NavigationView in navigationViews)
			navigationView.deactivate()
	}
	
	public function addNavigationView(navigationView:NavigationView):void
	{
		initializeNavigation(navigationView)
		navigationViews.push(navigationView)
	}
	
	public function activateNavigationViewByURL(url:String):void
	{
		var targetNavigationView:NavigationView = navigationViewByURL(url, this)
		if(targetNavigationView)
			targetNavigationView.requestActivate()
	}
	
	public function doOnAllNavigationViews(funktion:Function,
							navigationViews:Vector.<NavigationView> = null):void
	{
		if(!navigationViews) navigationViews = this.navigationViews
		for each(var navigationView:NavigationView in navigationViews)
		{
			funktion.call(null, navigationView)
			if(navigationView.navigationTreeView.navigationViews.length > 0)
				doOnAllNavigationViews(funktion, navigationView.navigationTreeView.navigationViews)
		}
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function navigationViewByURL(url:String,
		navigationTreeView:NavigationTreeView):NavigationView
	{
		var targetNavigationView:NavigationView
		for each(var navigationView:NavigationView in 
			navigationTreeView.navigationViews)
		{
			if(navigationView.navigation.url == url)
			{
				targetNavigationView = navigationView
				break
			}
			if(navigationView.navigationTreeView.navigationViews.length > 0)
			{
				targetNavigationView = 
					navigationViewByURL(url, navigationView.navigationTreeView)
				if(targetNavigationView != null)
					break
			}
		}
		return targetNavigationView
	}
	
	private function navigationView_clickHandler(event:MouseEvent):void
	{
		report.print(event.target.name + " has been clicked.")
		var navigationView:NavigationView = event.target as NavigationView
		navigationView.requestActivate()
	}
	
	private function navigationView_activatedHandler(
		event:NavigationViewEvent):void
	{
		report.print("Current navigationTreeView: " + name)
		if(parentNavigationView) 
			parentNavigationView.requestActivate(false)
	}
	
	public function navigationView_requestActivatedHandler(
		event:NavigationViewEvent):void
	{
		var navigationView:NavigationView = event.target as NavigationView
		if(!navigationView.active) activateNavigationView(navigationView)
	}
	
	private function parentNavigationV_deactivateHandler(
		event:NavigationViewEvent):void
	{
		resetAll()	
	}
	
	private function navigationView_capturedFirstHandler(
		event:NavigationViewEvent):void
	{
		dispatchEvent(event)
		if(parentNavigationView) parentNavigationView.dispatchEvent(event)
	}
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function set navigationViews(value:Vector.<NavigationView>):void
	{
		_navigationViews = value
			
		for each(var navigationView:NavigationView in _navigationViews)
			initializeNavigation(navigationView)
	}

	public function get navigationViews():Vector.<NavigationView>
	{
		if(!_navigationViews) _navigationViews = new Vector.<NavigationView>()
		return _navigationViews
	}

	public function set parentNavigationView(value:NavigationView):void
	{
		_parentNavigationView = value
		if(_parentNavigationView)
			_parentNavigationView.addEventListener(NavigationViewEvent.DEACTIVATED,
											    parentNavigationV_deactivateHandler)
	}
	
	public function get parentNavigationView():NavigationView
	{
		return _parentNavigationView
	}
}
}