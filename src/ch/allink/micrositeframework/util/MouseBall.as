package ch.allink.micrositeframework.util
{
import flash.display.Sprite;
import flash.events.MouseEvent;

public class MouseBall
{
	
	private static var mouseContainer:Sprite;
	private static var mouseBallClip:Sprite;
	
	public static function setContainer(mouseCont:Sprite, mouseBall:Sprite):void{
		mouseContainer = mouseCont;
		mouseContainer.addEventListener(MouseEvent.MOUSE_MOVE, updatePos);
	//	mouseContainer.addChild(mouseBall);
		mouseBallClip = mouseBall;
		mouseBallClip.x = mouseContainer.stage.mouseX
		mouseBallClip.y = mouseContainer.stage.mouseY;
	}
	public static function getContainer():Sprite{
		return mouseContainer;
	}
	public static function getBall():Sprite{
		return mouseBallClip;
	}
	private static function updatePos(e:MouseEvent):void{
		mouseBallClip.x = e.stageX;
		mouseBallClip.y = e.stageY;
	}
	public static function display():void{
		mouseBallClip.visible = true;
		mouseContainer.addChild(mouseBallClip);
	}
	public static function hide():void{
		mouseBallClip.visible = false;
		if(mouseContainer.contains(mouseBallClip)){
			mouseContainer.removeChild(mouseBallClip);
		}
	}
}
}