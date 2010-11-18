package ch.allink.microsite.cmsConnector
{

import ch.allink.microsite.core.AbstractModel;

import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

public class ModelFactory extends EventDispatcher
{
	//-------------------------------------------------------------------------
	//
	//	Constants
	//
	//-------------------------------------------------------------------------
	
	public static const TYPE_COLLECTION:String = "typeCollection"
	public static const TYPE_MODEL:String = "typeModel"
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
		
	public function ModelFactory(target:IEventDispatcher = null)
	{
		super(target)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------

	public function load(klass:Class, url:String, type:String):ModelRequest
	{
		return new ModelRequest(klass, url, this, type)
	}
	
	public function create(klass:Class, xml:XML):AbstractModel
	{
		var model:AbstractModel = new klass
		var attributes:XMLList = xml.attributes()
		for each (var attribute:XML in attributes)
			model[attribute.name().toString()] = attribute.toString()
				
		var nodes:XMLList = xml.children()
		for each(var node:XML in nodes)
		{
			var value:Object
			if (node.hasComplexContent())
			{
				var collection:Array = new Array()
				var children:XMLList = node.children()
				for each (var subnode:XML in children)
					collection.push(subnode)
						
				value = collection
			}
			else
			{
				value = node.toString()
			}
			try
			{
				model[node.name()] = value
			}
			catch(error:TypeError)
			{
				trace(error)
			}
		}
		return model
	}
	
	public function createCollection(klass:Class, 
									 xml:XML):Vector.<AbstractModel>
	{
		var result:Vector.<AbstractModel> = new Vector.<AbstractModel>
		for each(var node:XML in xml.children())
			result.push(create(klass, node))
		
		return result
	}
}
}