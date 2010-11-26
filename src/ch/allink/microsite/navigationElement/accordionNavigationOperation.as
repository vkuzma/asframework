package ch.allink.microsite.navigationElement
{
public class accordionNavigationOperation implements INavigationOperation
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _navigationTreeView:NavigationTreeView
	public var verticalSpacing:Number = 20.0
	
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
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function initialize():void
	{
		var prevNavigationView:NavigationView
		for each(var navigationView:NavigationView in 
				 targetView.navigationViews)
		{
			if(prevNavigationView)
				navigationView.y = prevNavigationView.y + 
								   prevNavigationView.height +
								   verticalSpacing
			else
				navigationView.y = 0
					
			prevNavigationView = navigationView
		}
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
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