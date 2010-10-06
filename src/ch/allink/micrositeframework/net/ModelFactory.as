package ch.allink.micrositeframework.net
{


import ch.allink.micrositeframework.model.AbstractModel;
import ch.allink.micrositeframework.model.ModelCollectionEvent;
import ch.allink.micrositeframework.model.ModelLoader;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

import mx.events.Request;

public class ModelFactory extends EventDispatcher
{
	
	public static const TYPE_COLLECTION:String = "typeCollection"
	public static const TYPE_MODEL:String = "typeModel"
	
	public function ModelFactory(target:IEventDispatcher=null)
	{
		super(target)
	}
	
	//TODO: type sollte keinen Standartwert haben
	public function load(klass:Class, url:String, type:String = ModelFactory.TYPE_COLLECTION):ModelRequest
	{
		return new ModelRequest(klass, url, this, type)
	}
	
	public function create(klass:Class, xml:XML):AbstractModel
	{
		var model:AbstractModel = new klass
		
		try{
			var attributes:XMLList = xml.attributes()
			for each (var attribute:XML in attributes)
			{
				model[attribute.name().toString()] = attribute.toString()
			}
			var nodes:XMLList = xml.children()
			for each(var node:XML in nodes)
			{
				var value:Object;
				if (node.hasComplexContent())
				{
					var collection:Array = new Array()
					var children:XMLList = node.children()
					for each (var subnode:XML in children)
					{
						collection.push(subnode)
					}
					value = collection
				}
				else
				{
					value = node.toString()
				}
				model[node.name()] = value
			}
		}
		catch(e:Error)
		{
			throw e
		}
		return model;
	}
	
	public function createCollection(klass:Class, xml:XML):Vector.<AbstractModel>
	{
		var result:Vector.<AbstractModel> = new Vector.<AbstractModel>
		for each(var node:XML in xml.children())
		{
			result.push(create(klass, node))
		}
		
		return result
	}
}
}