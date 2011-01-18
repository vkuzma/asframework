package ch.allink.microsite.navigationElement.remake
{
import ch.allink.microsite.core.AbstractView;
import ch.allink.microsite.events.remake.NavigationViewEvent;
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
		navigationView.addEventListener(MouseEvent.CLICK, 
										navigationView_clickHandler)
		navigationView.addEventListener(NavigationViewEvent.ACTIVATED,
										navigationView_activatedHandler)
		navigationView.addEventListener(NavigationViewEvent.REQUEST_ACTIVATE,
										navigationView_requestActivatedHandler)
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
		report.print("Activate navigationView: " + 
					 toActivateNavigationView.name + 
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
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function navigationView_clickHandler(event:MouseEvent):void
	{
		report.print(event.target.name + " has been clicked.")
		var navigationView:NavigationView = event.target as NavigationView
		activateNavigationView(navigationView)
	}
	
	private function navigationView_activatedHandler(
		event:NavigationViewEvent):void
	{
		report.print("Current navigationTreeView: " + name)
		if(parentNavigationView) parentNavigationView.requestActivate(
			event.navigationView)
	}
	
	public function navigationView_requestActivatedHandler(event:Event):void
	{
		var navigationView:NavigationView = event.target as NavigationView
		if(!navigationView.active) activateNavigationView(navigationView)
	}
	
	private function parentNavigationV_deactivateHandler(
		event:NavigationViewEvent):void
	{
		resetAll()	
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
		_parentNavigationView.addEventListener(NavigationViewEvent.DEACTIVATED,
										    parentNavigationV_deactivateHandler)
	}
	
	public function get parentNavigationView():NavigationView
	{
		return _parentNavigationView
	}
}
}