package ch.allink.microsite.navigationElement
{
import ch.allink.microsite.events.NavigationViewEvent;
import ch.allink.microsite.util.DisplayFactory;

import com.greensock.TweenLite;

import flash.display.Shape;
import flash.events.EventDispatcher;
import ch.allink.microsite.navigationElement.NavigationView;
import ch.allink.microsite.navigationElement.NavigationTreeView;

public class AccordionNavigationOperation extends EventDispatcher
										  implements INavigationOperation
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _navigationTreeView:NavigationTreeView
	public var verticalSpacing:Number
	public var subMenuIndent:Number
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function AccordionNavigationOperation()
	{
		verticalSpacing = 5.0
		subMenuIndent = 10.0
	}
	
	//-------------------------------------------------------------------------
	//
	//	Protected methods
	//
	//-------------------------------------------------------------------------
	
	protected function initializeNavigationViews
		(navigationViews:Vector.<NavigationView>):void
	{
		for each(var navigationView:NavigationView in navigationViews)
		{
			navigationView.addEventListener(NavigationViewEvent.ACTIVATED,
				navigationView_activatedHandler)
			if(navigationView.navigationTreeView)
				initializeNavigationViews(
					navigationView.navigationTreeView.navigationViews)
			
			//Formatting subnavigations
			if(navigationView.navigationTreeView)
			{
				var mask:Shape = DisplayFactory.createMask()
				navigationView.navigationTreeView.addChild(mask)
				navigationView.navigationTreeView.mask = mask
			}
		}
	}
	
	protected function openMenu(navigationTreeView:NavigationTreeView):void
	{
		TweenLite.to(navigationTreeView.mask, 2, {height: navigationTreeView.height})
	}
	
	public function arrangeNavigationViews(
		navigationViews:Vector.<NavigationView>):void
	{
		var prevNavigationView:NavigationView
		for each(var navigationView:NavigationView in navigationViews)
		{
			if(navigationView.navigationTreeView)
				arrangeNavigationViews(
					navigationView.navigationTreeView.navigationViews)
			
			if(prevNavigationView)
			{
				navigationView.y = prevNavigationView.y + 
					prevNavigationView.height + verticalSpacing 
				if(prevNavigationView.navigationTreeView)
				{
					navigationView.y += 
						prevNavigationView.navigationTreeView.height + 
						verticalSpacing
				}
			}
			else
				navigationView.y = 0
			
			//Formatting subnavigations
			if(navigationView.navigationTreeView)
			{
				navigationView.navigationTreeView.y = navigationView.y + 
					navigationView.height +	verticalSpacing  
				navigationView.navigationTreeView.x = subMenuIndent
				
				navigationView.navigationTreeView.mask.width = 
					navigationView.navigationTreeView.width
				navigationView.navigationTreeView.mask.height = 
					navigationView.navigationTreeView.height
			}
			prevNavigationView = navigationView
		}
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function initialize():void
	{
		initializeNavigationViews(targetView.navigationViews)
		arrangeNavigationViews(targetView.navigationViews)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	protected function navigationView_activatedHandler(event:NavigationViewEvent):void
	{
		if(event.navigationView.navigationTreeView)
			openMenu(event.navigationView.navigationTreeView)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function set targetView(value:NavigationTreeView):void
	{
		_navigationTreeView	= value	
	}
	
	public function get targetView():NavigationTreeView
	{
		return _navigationTreeView
	}
}
}