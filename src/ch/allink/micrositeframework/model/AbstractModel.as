package ch.allink.micrositeframework.model
{
	
	import mx.events.CollectionEvent;

	public class AbstractModel extends Object
	{
		protected var mf:ModelFactory = new ModelFactory;
		
		public function AbstractModel()
		{
			
		}
		
		protected function fillCollection(klass:Class, values:Array):Array
		{
			/**
			 * 
			 * TODO: update method so it can distinguish between xml an array of objects
			 * 
			 * */
			if(values[0] is XML)
			{
				var collection:Array = [ ]
				for each(var s:XML in values)
				{
					collection.push(mf.create(klass, s))
				}
			}	
			return collection;
		}		
	}
}