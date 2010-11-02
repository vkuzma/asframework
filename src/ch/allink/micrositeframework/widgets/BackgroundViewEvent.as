package ch.allink.micrositeframework.widgets
{
import ch.allink.micrositeframework.cmsview.ImageView;

import flash.events.Event;

public final class BackgroundViewEvent extends Event
{
	public static const COMPLETE:String = "complete"
		
	private var _imageView:ImageView
	
	public function BackgroundViewEvent(type:String, bubbles:Boolean=false, 
										cancelable:Boolean=false,
										imageView:ImageView = null)
	{
		super(type, bubbles, cancelable)
		_imageView = imageView
	}
	
	override public function clone():Event
	{
		var backgroundViewEvent:BackgroundViewEvent = new
			BackgroundViewEvent(COMPLETE, false, false, imageView)
		return backgroundViewEvent
	}
	
	public function get imageView():ImageView
	{
		return _imageView
	}
}
}