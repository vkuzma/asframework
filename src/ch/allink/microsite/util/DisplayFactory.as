package ch.allink.microsite.util
{
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.GradientType;
import flash.display.IBitmapDrawable;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Matrix;

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
	
	public static function createDummy(displayContainer:Sprite = null):Shape
	{
		var shape:Shape = new Shape()
		if(displayContainer) displayContainer.addChild(shape)
		shape.graphics.beginFill(0xFF0000)
		shape.graphics.drawRect(0, 0, 100, 100)
		shape.graphics.endFill()
			
		return shape
	}
	
	public static function flushSprite(sprite:Sprite):void
	{
		for(var i:int = sprite.numChildren - 1; i >= 0; i--)
			sprite.removeChildAt(i)
	}
	
}
}