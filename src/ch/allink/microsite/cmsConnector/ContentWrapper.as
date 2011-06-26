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
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function ContentWrapper()
	{
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
		SectionContentTypes.addContentType(swf.type, WrapperOperation, WrapperSection)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function loadContentSWF(pathToSWF:String):void
	{
		var swfLoader:SWFLoader = new SWFLoader(pathToSWF)
		swfLoader.addEventListener(LoaderEvent.COMPLETE, swfLoader_completeHandler)
		swfLoader.load()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function swfLoader_completeHandler(event:LoaderEvent):void
	{
		var swfLoader:SWFLoader = event.target as SWFLoader
		assignClasses(swfLoader.rawContent)
		dispatchEvent(event)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	
}
}