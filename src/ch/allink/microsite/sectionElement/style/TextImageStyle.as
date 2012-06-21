package ch.allink.microsite.sectionElement.style
{
import ch.allink.microsite.sectionElement.SectionContentTypes;

/**
 * @author vkuzma
 * @date Apr 5, 2011
 **/
public class TextImageStyle implements ISectionStyle
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	public var imageOffsetX:Number
	public var imageOffsetY:Number
	public var textOffsetX:Number
	public var textOffsetY:Number
	public var titleOffsetX:Number
	public var titleOffsetY:Number
	public var titleTextVerticalSpacing:Number
	
	public var textImagehorizontalSpacing:Number
	public var textImageVerticalSpacing:Number
	
	public var titleUpperCase:Boolean
	public var textUpperCase:Boolean
	
	public var enableTitle:Boolean
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function TextImageStyle()
	{
		init()
	}
	
	public function get CONTENT_TYPE():String
	{
		return SectionContentTypes.TEXT_IMAGE;
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function init():void
	{
		imageOffsetX = 0
		imageOffsetY = 0
		textOffsetX = 0
		textOffsetY = 0
		titleOffsetX = 0
		titleOffsetY = 0
			
		textImagehorizontalSpacing = 0
			
		textImageVerticalSpacing = 0
		titleTextVerticalSpacing = 0
		titleUpperCase = false
		textUpperCase = false
			
		enableTitle = true
	}
	
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