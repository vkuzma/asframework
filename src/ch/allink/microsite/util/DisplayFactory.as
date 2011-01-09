package ch.allink.microsite.util
{
import flash.display.Shape;

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
}
}