package ch.allink.microsite.sectionElement.sectionType
{
import ch.allink.microsite.core.AbstractModel;
import ch.allink.microsite.imageElement.Image;
import ch.allink.microsite.sectionElement.sectionType.TextSection;

/**
 * @author vkuzma
 * @date Apr 1, 2011
 **/
public class TextImageSection extends TextSection
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _images:Array
	public var alignment:String
	public var title:String
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function TextImageSection()
	{
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function set images(values:Array):void
	{
		_images = fillCollection(Image, values)
	}
	
	public function get images():Array
	{
		return _images
	}
	
	public static function get TYPE():String
	{
		return "RichtTextWithImage"
	}
}
}