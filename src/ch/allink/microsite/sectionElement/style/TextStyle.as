package ch.allink.microsite.sectionElement.style
{
import ch.allink.microsite.sectionElement.SectionContentTypes;

/**
 * @author vkuzma
 * @date Dec 9, 2010
 **/
public class TextStyle implements ISectionStyle
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function TextStyle() 
	{
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function get CONTENT_TYPE():String
	{
		return SectionContentTypes.TEXT_ONLY
	}
}
}