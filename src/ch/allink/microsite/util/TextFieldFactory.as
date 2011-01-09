package ch.allink.microsite.util
{
import ch.allink.microsite.pageElement.PageFormatter;

import flash.text.AntiAliasType;
import flash.text.GridFitType;
import flash.text.TextField;

/**
 * @author vkuzma
 * @date Dec 9, 2010
 **/
public class TextFieldFactory
{
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function TextFieldFactory()
	{
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Sets a default set of properties.
	 */
	public static function setDefaultFormats(textField:TextField, 
										pageFormatter:PageFormatter = null):void
	{
		if(!pageFormatter) pageFormatter = new PageFormatter()
		textField.antiAliasType = AntiAliasType.ADVANCED
		textField.gridFitType = GridFitType.PIXEL
		textField.selectable = false
		textField.wordWrap = true
		textField.multiline = true
	}
	
	public static function createTextField():TextField
	{
		var textField:TextField = new TextField()
		setDefaultFormats(textField)
		return textField
	}
}
}