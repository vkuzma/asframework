package ch.allink.microsite.util
{
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;

/**
 * @author vkuzma
 * @date Jan 8, 2011
 **/
public class DisplayFactory
{
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function DisplayFactory()
	{
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public static function createMask():Shape
	{
		var mask:Shape = new Shape()
		mask.graphics.beginFill(0xFF0000)
		mask.graphics.drawRect(0, 0, 1, 1)
		mask.graphics.endFill()
		return mask
	}
	
	public static function createDummy(displayContainer:Sprite):Shape
	{
		var shape:Shape = new Shape()
		displayContainer.addChild(shape)
		shape.graphics.beginFill(0xFF0000)
		shape.graphics.drawRect(0, 0, 100, 100)
		shape.graphics.endFill()
			
		return shape
	}
}
}