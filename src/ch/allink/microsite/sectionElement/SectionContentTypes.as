package ch.allink.microsite.sectionElement
{
import ch.allink.microsite.sectionElement.sectionType.ImageSection;
import ch.allink.microsite.sectionElement.sectionType.TextImageSection;
import ch.allink.microsite.sectionElement.sectionType.TextSection;

import flash.utils.Dictionary;

public class SectionContentTypes
{
	//---------------------------------
	//	Standard section models
	//---------------------------------
	{
		contentTypeModels[TEXT_ONLY] = TextSection
		contentTypeModels[IMAGE] = ImageSection
		contentTypeModels[TEXT_IMAGE] = TextImageSection
		contentTypeModels[TEXT_IMAGE] = TextImageSection
		
	}
	
	//-------------------------------------------------------------------------
	//
	//	Constants
	//
	//-------------------------------------------------------------------------
	
	public static const TEXT_ONLY:String = "RichTextContent"
	public static const TEXT_IMAGE:String = "RichtTextWithImage"
	public static const IMAGE:String = "ImageContentType"
	public static const GALLERY:String = "gallery"
	
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
		
	private static var contentTypeModels:Dictionary = new Dictionary()
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
		
	public function SectionContentTypes()
	{
	}
	
	//-------------------------------------------------------------------------
	//
	//	Static methods
	//
	//-------------------------------------------------------------------------
	
	public static function getContentTypeModelByType(type:String):Class
	{
		return contentTypeModels[type] 
	}
	
	public static function addContentTypeModel(value:Class):void
	{
		contentTypeModels[value.TYPE] = value		
	}
}
}