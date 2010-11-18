package ch.allink.microsite.util
{
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;

public class SiteLoader extends Loader
{
	//-------------------------------------------------------------------------
	//
	//	Varibales
	//
	//-------------------------------------------------------------------------
	
	private var url:String
	private var loadAnimation:MovieClip
	private var version:String = Math.random().toString()

	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
		
	public function SiteLoader(loadAnimation:MovieClip, 
							   url:String, version:String = null)
	{
		version = Math.random().toString()
		this.url = url
		this.loadAnimation = loadAnimation
			
		if(version)
			this.version = version
	}
	
	//-------------------------------------------------------------------------
	//
	//	private methods
	//
	//-------------------------------------------------------------------------

	private function setupStage():void
	{
		stage.frameRate = 60
		stage.scaleMode = StageScaleMode.NO_SCALE
		stage.align = StageAlign.TOP_LEFT
	}
	
	private function handleIOError(e:IOErrorEvent):void
	{

	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------

	public function loadSite():void
	{
		setupStage()
		var urlRequest:URLRequest = new URLRequest(url + "?" + version)
		this.addEventListener(IOErrorEvent.IO_ERROR, handleIOError)
		load(urlRequest)
	}
}
}