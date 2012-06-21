package ch.allink.microsite.sectionElement
{
import ch.allink.microsite.sectionElement.operation.ImageContentOperation;
import ch.allink.microsite.sectionElement.operation.TextImageOperation;
import ch.allink.microsite.sectionElement.operation.TextOperation;
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
		contentTypes[TEXT_ONLY] = {contentOperation: TextOperation, contentSection: TextSection}
		contentTypes[IMAGE] = {contentOperation: ImageContentOperation, contentSection: ImageSection}
		contentTypes[TEXT_IMAGE] = {contentOperation: TextImageOperation, contentSection: TextImageSection}
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
		
	private static var contentTypes:Dictionary = new Dictionary()
	
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
	
	public static function getContentTypeByType(type:String):Object
	{
		return contentTypes[type]
	}
	
	public static function addContentType(type:String, contentOperation:Class, 
										  contentSection:Class):void
	{
		contentTypes[type] = {contentOperation: contentOperation, contentSection: contentSection}
	}
	
}
}