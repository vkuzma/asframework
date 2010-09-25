package ch.allink.micrositeframework.model
{
	import flash.events.Event;
	
	public class ModelEvent extends Event
	{
		
		public static const MODEL_LOADED:String = "modelLoaded"
		
		public var model:AbstractModel
		public var klass:Class
		
		public function ModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}