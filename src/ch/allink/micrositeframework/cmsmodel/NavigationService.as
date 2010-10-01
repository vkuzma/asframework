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
				languages[navigation.languageid].push(navigation);
				for each (var parentNav:Navigation in collection)
				{
					if (navigation.parentid != 0 && navigation.parentid == parentNav.id && navigation.languageid == parentNav.languageid)
					{
						parentNav.addChild(navigation)
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