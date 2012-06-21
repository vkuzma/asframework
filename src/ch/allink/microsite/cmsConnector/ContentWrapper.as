package ch.allink.microsite.cmsConnector
{
import ch.allink.microsite.sectionElement.SectionContentTypes;
import ch.allink.microsite.sectionElement.operation.WrapperOperation;
import ch.allink.microsite.sectionElement.sectionType.WrapperSection;

import com.greensock.events.LoaderEvent;
import com.greensock.loading.SWFLoader;

import flash.events.EventDispatcher;

/**
 * @author vkuzma
 * @date Jun 25, 2011
 **/
public class ContentWrapper extends EventDispatcher
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var Operation:Class
	private var Model:Class
	private var Style:Class
	private var swfPaths:Vector.<String>
	private var loadCounter:int
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function ContentWrapper()
	{
		swfPaths = new Vector.<String>()
		loadCounter = 0
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function assignClasses(swf:Object):void
	{
		Operation = swf.Operation
		WrapperOperation.addOperation(swf.type, Operation)
		SectionContentTypes.addContentType(swf.type, WrapperOperation, swf.Model)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function loadContentSWFs():void
	{
		for each(var path:String in swfPaths)
		{
			loadCounter++
			var swfLoader:SWFLoader = new SWFLoader(path)
			swfLoader.addEventListener(LoaderEvent.COMPLETE, swfLoader_completeHandler)
			swfLoader.load()
		}
	}
	
	public function addContentTypePath(pathToSwf:String):void
	{
		swfPaths.push(pathToSwf)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function swfLoader_completeHandler(event:LoaderEvent):void
	{
		loadCounter--
		var swfLoader:SWFLoader = event.target as SWFLoader
		assignClasses(swfLoader.rawContent)
		if(loadCounter == 0) dispatchEvent(event)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	
}
}