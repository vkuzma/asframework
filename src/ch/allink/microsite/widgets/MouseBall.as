package ch.allink.microsite.widgets
{
import flash.display.Sprite;
import flash.events.MouseEvent;

public class MouseBall
{
	
	private static var _mouseContainer:Sprite
	private static var mouseBallClip:Sprite
	
	public static function setContainer(mouseContainer:Sprite, mouseBall:Sprite):void
	{
		_mouseContainer = mouseContainer;
		_mouseContainer.stage.addEventListener(MouseEvent.MOUSE_MOVE, 
			mouseContainer_mouseMoveHandler)
		mouseBallClip = mouseBall
	}
	
	public static function getContainer():Sprite
	{
		return _mouseContainer
	}
	
	public static function getBall():Sprite
	{
		return mouseBallClip
	}
	
	private static function mouseContainer_mouseMoveHandler(event:MouseEvent):void
	{
		mouseBallClip.x = event.stageX
		mouseBallClip.y = event.stageY
	}
	public static function display():void
	{
		mouseBallClip.visible = true
		_mouseContainer.addChild(mouseBallClip)
	}
	
	public static function hide():void
	{
		mouseBallClip.visible = false
		if(_mouseContainer.contains(mouseBallClip))
			_mouseContainer.removeChild(mouseBallClip)
	}
}
}