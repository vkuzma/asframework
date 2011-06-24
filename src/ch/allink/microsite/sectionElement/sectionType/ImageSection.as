package ch.allink.microsite.sectionElement.sectionType
{
import ch.allink.microsite.imageElement.Image;
import ch.allink.microsite.sectionElement.SectionContentTypes;

/**
 * @author vkuzma
 * @date Jan 6, 2011
 **/
public class ImageSection extends TextSection
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _images:Array
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function ImageSection()
	{
		super()
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
		return SectionContentTypes.IMAGE
	}
}
}