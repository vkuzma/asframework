package ch.allink.microsite.events
{
import flash.events.Event;

/**
 * @author vkuzma
 * @date Jan 19, 2011
 **/
public class SoundPlayerEvent extends Event
{
	//-------------------------------------------------------------------------
	//
	//	Constants
	//
	//-------------------------------------------------------------------------
	
	public static const PLAY:String = "play"
	public static const PAUSE:String = "pause"
	public static const PLAYPAUSE:String = "playPause"
	public static const MODELS_LOADED:String = "modelLoaded"
	public static const SOUND_LOADED:String = "soundLoaded"
	public static const PROGRESS:String = "progress"
		
	private var _progress:Number
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function SoundPlayerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, 
									 progress:Number = 0.0)
	{
		super(type, bubbles, cancelable);
		_progress = progress
	}
	
	public override function clone():Event
	{
		return new SoundPlayerEvent(type, bubbles, cancelable, progress)
	}
	
	public function get progress():Number
	{
		return _progress
	}
}
}