package ch.allink.micrositeframework.cmsmodel
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class NavigationService extends EventDispatcher
	{
		private var languages:Array
		
		public function NavigationService(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		
		public function buildTree(collection:Vector.<Navigation>):void
		{
			languages = []
			for each (var navigation:Navigation in collection)
			{
				var langID:Number = navigation.languageid
				if (!languages[langID])
					languages[langID] = new Vector.<Navigation>
			}
			
			for each (var navigation_l:Navigation in collection)
			{	
				languages[navigation.languageid].push(navigation_l);
				for each (var parentNav:Navigation in collection)
				{
					if (navigation_l.parentid != 0 && navigation_l.parentid == parentNav.id && navigation_l.languageid == parentNav.languageid)
					{
						parentNav.addChild(navigation_l)
						break;
					}
				}
			}
			
		}
		
		public function getRootElements(languageID:Number):Vector.<Navigation>
		{
			var ret:Vector.<Navigation> = new Vector.<Navigation>;
			var navs:Vector.<Navigation> = languages[languageID];
			for each (var n:Navigation in navs)
			{
				if (n.parentid == 0)
				{
					ret.push(n);
				}
			}
			return ret;
		}
	}
}