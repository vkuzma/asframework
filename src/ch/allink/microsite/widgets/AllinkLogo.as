package ch.allink.microsite.widgets
{
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.net.navigateToURL;

/**
 * @author Vladimir Kuzma
 * @date Dec 1, 2010
 **/
public final class AllinkLogo extends Sprite
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var allinkButton:SimpleButton
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function AllinkLogo(allinkButton:SimpleButton)
	{
		super()
		this.allinkButton = allinkButton
		addChild(allinkButton)
		allinkButton.addEventListener(MouseEvent.CLICK, clickHandler)
		allinkButton.rotation = -90
		addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler)
		addEventListener(Event.RESIZE, resizeHandler)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	public function resize():void
	{
		resizeHandler(null)
	}
	
	private function clickHandler(event:MouseEvent):void
	{
		navigateToURL(new URLRequest("http://www.allink.ch"), "_blank")
	}
	
	private function addedToStageHandler(event:Event):void
	{
		resizeHandler(null)
	}
	
	private function resizeHandler(event:MouseEvent):void
	{
		allinkButton.x = stage.stageWidth - 15
		allinkButton.y = height + 5
	}
}
}