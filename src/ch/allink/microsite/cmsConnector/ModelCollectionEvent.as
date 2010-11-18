package ch.allink.microsite.cmsConnector
{
import ch.allink.microsite.core.AbstractModel;

import flash.events.Event;

public class ModelCollectionEvent extends Event
{
	
	public static const MODEL_COLLECTION_LOADED:String = "modelCollectionLoaded"
	
	public var collection:Vector.<AbstractModel>
	public var klass:Class
	
	public function ModelCollectionEvent(type:String, bubbles:Boolean=false,
										 cancelable:Boolean=false)
	{
		super(type, bubbles, cancelable)
	}
	
}
}