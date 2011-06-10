package ch.allink.microsite.cmsConnector
{

import ch.allink.microsite.core.AbstractModel;
import ch.allink.microsite.events.ResultEvent;

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
	//	Variables
	//
	//-------------------------------------------------------------------------
		
	private var _modelRequest:ModelRequest
		
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
		
	/**
	 * Creates a new ModelFactory instance.
	 **/
	public function ModelFactory(target:IEventDispatcher = null)
	{
		super(target)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------

	/**
	 * Loads a model from CMS.
	 **/
	public function load(klass:Class, url:String, type:String):void
	{
		_modelRequest =  new ModelRequest(klass, url, this, type)
		modelRequest.addEventListener(ResultEvent.DATA_LOADED, modelRequest_dataLoadedHandler)
		modelRequest.load()
	}
	
	/**
	 * Creates and fills a model.
	 * @param klass Class of the model
	 * @param xml Source of data
	 **/
	public function create(klass:Class, xml:XML):AbstractModel
	{
		var model:AbstractModel = new klass
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
//				trace(error)
			}
		}
		return model
	}
	
	/**
	 * Creates and fills a collection of models.
	 * @param klass Class of the model
	 * @param xml Source of data
	 **/
	public function createCollection(klass:Class, xml:XML):Vector.<AbstractModel>
	{
		var result:Vector.<AbstractModel> = new Vector.<AbstractModel>
		for each(var node:XML in xml.children())
			result.push(create(klass, node))
		
		return result
	}
	
	private function modelRequest_dataLoadedHandler(event:ResultEvent):void
	{
		dispatchEvent(event)
	}
	
	public function get modelRequest():ModelRequest
	{
		return _modelRequest
	}
}
}