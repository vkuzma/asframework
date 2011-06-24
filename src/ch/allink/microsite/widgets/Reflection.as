package ch.allink.microsite.widgets
{
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.GradientType;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.text.TextField;

/**
 * @author vkuzma
 * @date May 17, 2011
 **/
public class Reflection extends Sprite
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _reflection:Sprite = new Sprite()
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function Reflection()
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
	
	public function buildReflectionFrom(displayObject:DisplayObject):void
	{
		var reflection:Sprite = new Sprite()
			
		var matrix:Matrix = new Matrix()
		matrix.createGradientBox(displayObject.width, displayObject.height, 90)
		
		var gradiant:Shape = new Shape()
		gradiant.graphics.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xFFFFFF], [0.1, 0.3],
			[0, 255], matrix)
		gradiant.graphics.drawRect(0, 0, displayObject.width, displayObject.height)
		gradiant.graphics.endFill()
		
		var bitmapData1:BitmapData = new BitmapData(displayObject.width, displayObject.height, true,
			0x000000)
		bitmapData1.draw(displayObject)
		var bitmap:Bitmap = new Bitmap(bitmapData1)
		bitmap.smoothing = true
			
		displayObject.x = 0
		displayObject.y = 0
			
		_reflection = new Sprite()
		_reflection.addChild(displayObject)
		_reflection.addChild(gradiant)
			
		addChild(bitmap)
		addChild(_reflection)
		
		_reflection.y = _reflection.height * 2
		_reflection.scaleY = -1
		
		gradiant.mask = displayObject
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function get refelction():Sprite
	{
		return _reflection
	}
	
}
}