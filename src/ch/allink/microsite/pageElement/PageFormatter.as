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
	
	public var sectionStyleClasses:Vector.<Class>
	public var sectionStyles:Vector.<ISectionStyle>
	
	//---------------------------------
	//	Layout
	//---------------------------------
	public var sectionVerticalSpacing:Number = 10
	public var sectionHorizontalSpacing:Number = 10
	public var sectionWidth:Number = 500
	public var paddingLeft:Number = 0
	public var paddingTop:Number = 0
		
	//-------------------------------------------------------------------------
	//
	//	Constants
	//
	//-------------------------------------------------------------------------
	
	public function PageFormatter()
	{
		sectionStyleClasses = new Vector.<Class>
		sectionStyleClasses.push(TextStyle)
			
		sectionStyles = new Vector.<ISectionStyle>
			
		createStyleInstances()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function createStyleInstances():void
	{
		for each(var klass:Class in sectionStyleClasses)
		{
			var sectionStyle:Object = new klass()
			sectionStyles.push(sectionStyle)
		}
	}
	
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
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
}
}