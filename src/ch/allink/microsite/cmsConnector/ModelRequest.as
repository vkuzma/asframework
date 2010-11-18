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
	
	private var _request:URLRequest
	private var _loader:URLLoader
	private var _klass:Class
	private var _modelFactory:ModelFactory
	private var _requestType:String
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function ModelRequest(klass:Class, url:String, 
								 modelFactory:ModelFactory, 
								 requestType:String)
	{
		
		_request = new URLRequest(url)
		_loader = new URLLoader(_request)
			
		_requestType = requestType
			
		_modelFactory = modelFactory
		_klass = klass
			
		_loader.addEventListener(Event.COMPLETE,
			loader_completeHandler, false, 0)
		_loader.addEventListener(IOErrorEvent.IO_ERROR,
			loader_errorHandler, false, 0, true)
		_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,
			loader_errorHandler, false, 0, true)
	}
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function loader_completeHandler(event:Event):void
	{
		var event:Event
		var data:XML = XML(_loader.data)
		var collection:Vector.<AbstractModel>
		var abstractModel:AbstractModel
		
		if(_requestType == ModelFactory.TYPE_COLLECTION)
			collection = _modelFactory.createCollection(_klass, data)
		else
			abstractModel = _modelFactory.create(_klass, data) 
				
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
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function dispose():void
	{
		if (_loader)
		{
			try
			{
				_loader.close()
			}
			catch (error:Error)
			{
				// Do nothing
			}
			finally
			{
				_loader.removeEventListener(Event.COMPLETE,
					loader_completeHandler)
				_loader.removeEventListener(IOErrorEvent.IO_ERROR,
					loader_errorHandler)
				_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,
					loader_errorHandler)
				_loader = null
				_request = null
			}
		}
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