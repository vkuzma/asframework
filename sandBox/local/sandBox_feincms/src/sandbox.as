package
{
import ch.allink.sandbox.WebsiteView;

import flash.display.Sprite;
import flash.events.Event;

public final class sandbox extends Sprite
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var websiteView:WebsiteView
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function sandbox()
	{
		websiteView = new WebsiteView()
		addChild(websiteView)
		
		if(stage) websiteView.build()
		else addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function addedToStageHandler(event:Event):void
	{
		websiteView.build()
	}
}
}