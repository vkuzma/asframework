package ch.allink.microsite.sectionElement
{
import ch.allink.microsite.core.AbstractModel;

import flash.utils.Dictionary;

public class SectionContentTypes
{
	public static const TEXT_ONLY:String = "RichTextContent"
	public static const TEXT_IMAGE_LEFT:String = "textimageleft"
	public static const IMAGE:String = "image"
	public static const GALLERY:String = "gallery"
		
	private static var contentTypeModels:Dictionary = new Dictionary()
		
	{
		contentTypeModels[TEXT_ONLY] = Section
	}
		
	public function SectionContentTypes()
	{
		
	}
	
	public static function getContentTypeModelByType(type:String):Class
	{
		return contentTypeModels[type] 
	}
	
	public static function addContentTypeModel(value:Class,
											   type:String):void
	{
		contentTypeModels[type] = value		
	}
}
}