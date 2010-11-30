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
	
	private function position(navigationViews:Vector.<NavigationView>):void
	{
		var prevNavigationView:NavigationView
		for each(var navigationView:NavigationView in navigationViews)
		{
			navigationView.addEventListener(NavigationViewEvent.ACTIVATED,
				navigationView_activatedHandler)
			if(navigationView.navigationTreeView)
				position(navigationView.navigationTreeView.navigationViews)
			
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
					
				var mask:Shape = createMask()
				navigationView.navigationTreeView.addChild(mask)
				navigationView.navigationTreeView.mask = mask
				mask.width = navigationView.navigationTreeView.width
				mask.height = navigationView.navigationTreeView.height
			}
			
			prevNavigationView = navigationView
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
	
	private function openMenu(navigationTreeView:NavigationTreeView):void
	{
		TweenLite.to(navigationTreeView.mask, 2, 
			{height: navigationTreeView.height})
	}
	
	private function arrangeNavigationViews(
		navigationViews:Vector.<NavigationView>):void
	{
		for each(var navigationView:NavigationView in navigationViews)
		{
			
		}
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function initialize():void
	{
		position(targetView.navigationViews)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function navigationView_activatedHandler(
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