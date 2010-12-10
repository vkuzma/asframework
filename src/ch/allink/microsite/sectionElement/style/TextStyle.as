package ch.allink.microsite.sectionElement.style
{
import ch.allink.microsite.sectionElement.SectionContentTypes;

import flash.text.StyleSheet;
import flash.text.TextFieldAutoSize;

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
	
	public var textAlign:String = TextFieldAutoSize.LEFT
	public var enableEmbedFonts:Boolean = false
	public var sectionTitleUpperCase:Boolean = false
	public var styleSheet:StyleSheet
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function TextStyle() 
	{
	}
	
	public function get contentType():String
	{
		return SectionContentTypes.TEXT_ONLY
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
	
	
}
}