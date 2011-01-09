package ch.allink.microsite.cmsConnector
{
import ch.allink.microsite.core.AbstractModel;

import flash.events.Event;

public class ModelCollectionEvent extends Event
{
	//-------------------------------------------------------------------------
	//
	//	Constants
	//
	//-------------------------------------------------------------------------
	
	public static const MODEL_COLLECTION_LOADED:String = "modelCollectionLoaded"
	
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	public var collection:Vector.<AbstractModel>
	public var klass:Class
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function ModelCollectionEvent(type:String, bubbles:Boolean = false,
										 cancelable:Boolean = false)
	{
		super(type, bubbles, cancelable)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Overriden methods
	//
	//-------------------------------------------------------------------------
	
	public override function clone():Event
	{
		return new ModelCollectionEvent(type, bubbles, cancelable)
	}
}
}