package ch.allink.microsite.allinkWebsite
{
import com.greensock.events.LoaderEvent;
import com.greensock.loading.SWFLoader;
import com.greensock.loading.display.ContentDisplay;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;

/**
 * The SiteLoader class is an example of how to load a mainsite. It can be used
 * as a basetemplate.
 * @author vkuzma
 * @date Jan 11, 2011
 **/
public class SiteLoader extends Sprite
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Path of the main swfsite.
	 **/
	protected var websiteFileName:String = "/media/flash/sandbox.swf"
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function SiteLoader()
	{
		super()
		
		build()
		addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler)
		loadWebsite()
	}
	
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	protected function build():void
	{
	}
	
	private function loadWebsite():void
	{
		var swfLoader:SWFLoader = new SWFLoader(websiteFileName)
		swfLoader.addEventListener(LoaderEvent.PROGRESS, 
								   swfLoader_progressHandler)
		swfLoader.addEventListener(LoaderEvent.COMPLETE, 
								   swfLoader_completeHandler)
		swfLoader.load()
	}
	
	protected function setupStage():void
	{
		stage.frameRate = 40
		stage.scaleMode = StageScaleMode.NO_SCALE
		stage.align = StageAlign.TOP_LEFT
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	protected function addedToStageHandler(event:Event):void
	{
		stage.addEventListener(Event.RESIZE, resizeHandler)
		setupStage()
		resizeHandler(null)
	}
	
	protected function resizeHandler(event:Event):void
	{
		//Resize something
	}
	
	protected function swfLoader_progressHandler(event:LoaderEvent):void
	{
	}
	
	protected function swfLoader_completeHandler(event:LoaderEvent):void
	{
		var swfLoader:SWFLoader = event.target as SWFLoader
		var websiteContent:ContentDisplay = swfLoader.content
		addChild(websiteContent)
	}
}
}