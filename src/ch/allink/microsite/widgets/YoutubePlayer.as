package ch.allink.microsite.widgets
{
import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.net.URLRequest;
import flash.system.Security;

/**
 * @author vkuzma
 * @date Dec 1, 2010
 **/
public class YoutubePlayer extends Sprite
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var player:Object
	private var loader:Loader
	public var playerHeight:Number = 360
	public var playerWidth:Number = 480
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function YoutubePlayer()
	{
		super()
		Security.allowDomain("www.youtube.com")
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	public var videoToPlay:String
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function build():void
	{
		loader = new Loader()
		loader.contentLoaderInfo.addEventListener(Event.INIT, initHandler)
		loader.load(new URLRequest(
			"http://www.youtube.com/v/"+videoToPlay+"?version=3"))
	}
	
	public function destroy():void
	{
		player.destroy()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function initHandler(event:Event):void
	{
		addChild(loader)
		loader.content.addEventListener("onReady", onPlayerReady)
		loader.content.addEventListener("onError", onPlayerError)
		loader.content.addEventListener("onStateChange", onPlayerStateChange)
		loader.content.addEventListener("onPlaybackQualityChange", 
			onVideoPlaybackQualityChange)
	}
	
	private function onPlayerReady(event:Event):void 
	{
		player = loader.content
		player.playVideo()
		player.setSize(playerWidth, playerHeight)
	}
	
	private function onPlayerError(event:Event):void
	{
		// Event.data contains the event parameter, which is the error code
//		trace("player error:", Object(event).data)
	}
	
	private function onPlayerStateChange(event:Event):void 
	{
		// Event.data contains the event parameter, which is the new player state
//		trace("player state:", Object(event).data)
	}
	
	private function onVideoPlaybackQualityChange(event:Event):void 
	{
		// Event.data contains the event parameter, which is the new video quality
//		trace("video quality:", Object(event).data)
	}
}
}