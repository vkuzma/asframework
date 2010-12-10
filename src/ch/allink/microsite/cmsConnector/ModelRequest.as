package ch.allink.microsite.cmsConnector
{
import ch.allink.microsite.core.AbstractModel;
import ch.allink.microsite.events.ResultEvent;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

[Event (name='dataLoaded', type='ch.allink.micrositeframework.net.ResultEvent')]

public class ModelRequest extends EventDispatcher 
{
	//-------------------------------------------------------------------------
	//
	//	Global variables
	//
	//-------------------------------------------------------------------------
	
	private var request:URLRequest
	private var loader:URLLoader
	private var _klass:Class
	private var modelFactory:ModelFactory
	private var requestType:String
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function ModelRequest(klass:Class, url:String, 
								 modelFactory:ModelFactory, 
								 requestType:String)
	{
		
		request = new URLRequest(url)
		loader = new URLLoader(request)
			
		this.requestType = requestType
			
		this.modelFactory = modelFactory
		_klass = klass
			
		loader.addEventListener(Event.COMPLETE,
			loader_completeHandler, false, 0)
		loader.addEventListener(IOErrorEvent.IO_ERROR,
			loader_errorHandler, false, 0, true)
		loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,
			loader_errorHandler, false, 0, true)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function dispose():void
	{
		if (loader)
		{
			try
			{
				loader.close()
			}
			catch (error:Error)
			{
				// Do nothing
			}
			finally
			{
				loader.removeEventListener(Event.COMPLETE,
					loader_completeHandler)
				loader.removeEventListener(IOErrorEvent.IO_ERROR,
					loader_errorHandler)
				loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,
					loader_errorHandler)
				loader = null
				request = null
			}
		}
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function loader_completeHandler(event:Event):void
	{
		var data:XML = XML(loader.data)
		//First Nodes is allway "response" (generated by Pistion)
		//The first level can be ignored.
		data = data.children()[0]
		var collection:Vector.<AbstractModel>
		var abstractModel:AbstractModel
		
		if(requestType == ModelFactory.TYPE_COLLECTION)
			collection = modelFactory.createCollection(_klass, data)
		else
			abstractModel = modelFactory.create(_klass, data) 
				
		event = new ResultEvent(ResultEvent.DATA_LOADED, false, false, this, 
								collection, abstractModel)
		dispatchEvent(event)
		dispose()
	}
	
	private function loader_errorHandler(event:Event):void
	{
		
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function get klass():Class
	{
		return _klass
	}
}
}