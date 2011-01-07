package ch.allink.microsite.cmsConnector
{
import flash.utils.Dictionary;

/**
 * @author vkuzma
 * @date Jan 5, 2011
 **/
public class ModelTypes
{
	//-------------------------------------------------------------------------
	//
	//	Constants
	//
	//-------------------------------------------------------------------------
	
	public static const PAGE_TYPE:String = "pageType"
	public static const TEXT_IMAGE_LEFT:String = "textimageleft"
	public static const IMAGE:String = "image"
	public static const GALLERY:String = "gallery"
	
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private static var modelTypes:Dictionary = new Dictionary()
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
		
	public function ModelTypes()
	{
	}
	//-------------------------------------------------------------------------
	//
	//	Static methods
	//
	//-------------------------------------------------------------------------
	
	public static function getModelByType(type:String):Class
	{
		return modelTypes[type] 
	}
	
	public static function addModel(value:Class, type:String):void
	{
		modelTypes[type] = value		
	}
}
}