package ch.allink.micrositeframework.cmsmodel
{
public class NavigationTreeService
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	public var languages:Array
	public var currentLanguageID:int
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function NavigationTreeService()
	{
		currentLanguageID = 1
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function navigationByPageIDInNavigations(id:int, 
							navigations:Vector.<Navigation> = null):Navigation
	{
		var targetNavigation:Navigation
		for each(var navigation:Navigation in navigations)
		{
			if(navigation.indexPageID == id)	
			{
				targetNavigation = navigation
				break
			}
			else if(navigation.children)
			{
				targetNavigation = navigationByPageIDInNavigations(id,
					navigation.children)
				if(targetNavigation)
					break
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
			else if(navigation.children)
			{
				targetNavigation = firstNavigationByFormat(format, 
					navigation.children)
				if(targetNavigation)
					break
			}
		}
		return targetNavigation
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function build(collection:Vector.<Navigation>):void
	{
		languages = []
		for each (var navigation:Navigation in collection)
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
					&& navigation.parentid == parentNavigation.navigationid 
					&& navigation.languageid == parentNavigation.languageid)
				{
					parentNavigation.addChild(navigation)
					break
				}
			}
		}
	}
	
	public function rootElements():Vector.<Navigation>
	{
		var navigationsNew:Vector.<Navigation> = new Vector.<Navigation>
		var navigations:Vector.<Navigation> = languages[currentLanguageID]
		for each (var navigation:Navigation in navigations)
		{
			if (navigation.parentid == 0)
				navigationsNew.push(navigation)
		}
		return navigationsNew
	}
	
	//Gibt einen Referenz auf die gesuchte Navigation
	public function navigationByPageID(indexPageID:int)
		:Navigation
	{
		var targetNavigation:Navigation
		var numlanguages:int = languages.length
		for(var i:int; i < numlanguages; i++)
		{
			targetNavigation = navigationByPageIDInNavigations(indexPageID,
				languages[i] as Vector.<Navigation>)
			if(targetNavigation)
				break
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