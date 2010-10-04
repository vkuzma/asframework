package ch.allink.micrositeframework.util
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

//	public function buildBackground(BackGround:Class):void
//	{
//		var w:Number = flash.system.Capabilities.screenResolutionX
//		var h:Number = flash.system.Capabilities.screenResolutionY
//		var backGround:Sprite = new BackGround()
//		var tileW:Number = backGround.width
//		var tileH:Number = backGround.height
//		var xtiles:Number = Math.ceil(w / tileW)
//		var ytiles:Number = Math.ceil(h / tileH)
//			
//		for (var i:int = 0; i < ytiles; i++)
//		{
//			for (var i:int = 0; i < xtiles; i++)
//			{
//				var backGroundObject:Sprite = new BackGround
//				backGroundObject.x = (i * tileW)
//				backGroundObject.y = (i * tileH)
//				addChild(backGroundObject)
//			}
//		}
//	}
}
}