package ch.allink.micrositeframework.cmsmodel
{
public class NavigationTreeService
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var languages:Array
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function NavigationTreeService()
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
	
	public function buildTree(collection:Vector.<Navigation>):void
	{
		var navigation:Navigation
		languages = []
		for each (navigation in collection)
		{
			var langID:Number = navigation.languageid
			if (!languages[langID])
				languages[langID] = new Vector.<Navigation>
		}
		
		for each (navigation in collection)
		{	
			languages[navigation.languageid].push(navigation)
			for each (var parentNavigation:Navigation in collection)
			{
				if (navigation.parentid != 0 
					&& navigation.parentid == parentNavigation.id 
					&& navigation.languageid == parentNavigation.languageid)
				{
					parentNavigation.addChild(navigation)
					break
				}
			}
		}
	}
	
	public function rootElements(languageID:Number):Vector.<Navigation>
	{
		var navigationsNew:Vector.<Navigation> = new Vector.<Navigation>;
		var navigations:Vector.<Navigation> = languages[languageID];
		for each (var navigation:Navigation in navigations)
		{
			if (navigation.parentid == 0)
				navigationsNew.push(navigation)
		}
		return navigationsNew
	}
	
	private function navigationByPageID(id:int, 
									navigations:Vector.<Navigation>) :Navigation
	{
		var targetNavigation:Navigation
		
		for each(var navigation:Navigation in navigations)
		{
			if(navigation.id == id)	
			{
				targetNavigation = navigation
				break
			}
			else if(navigation.children != null)
			{
				targetNavigation = navigationByPageID(id, navigation.children)
				break
			}
			else
			{
				targetNavigation = null
			}
		}
		return targetNavigation
	}
	
	private function firstNavigationByFormat(format:String, 
								navigations:Vector.<Navigation>):Navigation
	{
		var targetNavigation:Navigation
		
		for each(var navigation:Navigation in navigations)
		{
			if(navigation.format == format)	
			{
				targetNavigation = navigation
				break
			}
			else if(navigation.children != null)
			{
				targetNavigation = firstNavigationByFormat(format, 
														    navigation.children)
				break
			}
			else
			{
				targetNavigation = null
			}
		}
		return targetNavigation
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event Handlers
	//
	//-------------------------------------------------------------------------
}
}