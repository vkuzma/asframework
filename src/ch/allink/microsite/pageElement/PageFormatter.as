package ch.allink.microsite.pageElement
{
import ch.allink.microsite.core.AbstractModel;
import ch.allink.microsite.sectionElement.style.ISectionStyle;
import ch.allink.microsite.sectionElement.style.TextStyle;

import flash.text.StyleSheet;
import flash.text.TextFieldAutoSize;

public class PageFormatter extends AbstractModel
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var sectionStyles:Vector.<ISectionStyle>
	
	//---------------------------------
	//	Layout
	//---------------------------------
	public var sectionVerticalSpacing:Number = 10
	public var sectionHorizontalSpacing:Number = 10
	public var sectionWidth:Number = 500
	public var paddingLeft:Number = 0
	public var paddingTop:Number = 0
	public var styleSheet:StyleSheet
	public var enableEmbedFonts:Boolean = false
	public var textAlign:String = TextFieldAutoSize.LEFT
	public var titleContentSpacing:Number = 0
		
	//-------------------------------------------------------------------------
	//
	//	Constants
	//
	//-------------------------------------------------------------------------
	
	public function PageFormatter()
	{
		sectionStyles = new Vector.<ISectionStyle>
		sectionStyles.push(new TextStyle())
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
	
	public function getSectionStyleByContentType(contentType:String)
		:ISectionStyle
	{
		var sectionStyleByContentType:ISectionStyle
		for each(var sectionStyle:ISectionStyle in sectionStyles)
		{
			if(sectionStyle.contentType == contentType)
			{
				sectionStyleByContentType = sectionStyle
				break
			}
		}
		return sectionStyleByContentType
	}
	
	public function addSectionStyle(sectionStyle:ISectionStyle):void
	{
		sectionStyles.push(sectionStyle)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
}
}