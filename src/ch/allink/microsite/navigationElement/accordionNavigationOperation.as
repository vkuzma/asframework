package ch.allink.microsite.navigationElement
{
import ch.allink.microsite.events.NavigationViewEvent;

import com.greensock.TweenLite;

import flash.display.Shape;

public class accordionNavigationOperation implements INavigationOperation
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _navigationTreeView:NavigationTreeView
	public var verticalSpacing:Number = 5.0
	public var subMenuIndent:Number = 10.0
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function accordionNavigationOperation()
	{
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
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
				var mask:Shape = createMask()
				navigationView.navigationTreeView.addChild(mask)
				navigationView.navigationTreeView.mask = mask
			}
		}
	}
	
	private function createMask():Shape
	{
		var mask:Shape = new Shape()
		mask.graphics.beginFill(0xFF0000)
		mask.graphics.drawRect(0, 0, 1, 1)
		mask.graphics.endFill()
		return mask
	}
	
	protected function openMenu(navigationTreeView:NavigationTreeView):void
	{
		TweenLite.to(navigationTreeView.mask, 2, 
			{height: navigationTreeView.height})
	}
	
	protected function arrangeNavigationViews(
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
	
	protected function navigationView_activatedHandler(
		event:NavigationViewEvent):void
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