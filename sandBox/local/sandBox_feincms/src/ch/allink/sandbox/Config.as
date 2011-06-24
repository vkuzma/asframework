package ch.allink.sandbox
{
import ch.allink.microsite.pageElement.PageFormatter;
import ch.allink.microsite.sectionElement.SectionContentTypes;
import ch.allink.microsite.sectionElement.style.TextStyle;

import flash.text.StyleSheet;
import flash.text.TextFieldAutoSize;

/**
 * @author vkuzma
 * @date Jan 11, 2011
 **/
public class Config
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
	
	public function Config()
	{
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public static function get pageFormatter():PageFormatter
	{
		var body:Object = {body: "fontSize: 32px; color: #000000"}
			
		var styleSheet:StyleSheet = new StyleSheet()
		styleSheet.setStyle("body", body)
			
		var pageFormatter:PageFormatter = new PageFormatter()
		pageFormatter.textAlign = TextFieldAutoSize.RIGHT
		pageFormatter.styleSheet = styleSheet
			
		return pageFormatter
	}
	
	public static function get defaultLanguage():String
	{
		return "en"
	}
}
}