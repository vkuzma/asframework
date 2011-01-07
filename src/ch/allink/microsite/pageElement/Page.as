package ch.allink.microsite.pageElement
{
import ch.allink.microsite.cmsConnector.CMSXmlPath;
import ch.allink.microsite.core.AbstractModel;
import ch.allink.microsite.core.CMSAbstractModel;
import ch.allink.microsite.imageElement.Image;
import ch.allink.microsite.sectionElement.sectionType.Section;
import ch.allink.microsite.sectionElement.SectionContentTypes;

import flash.geom.ColorTransform;

import spark.effects.interpolation.RGBInterpolator;

/**
 * The Page class is a model for the PageView class.
 * @author Michael Walder
 * @date 7.11.2010
 * @see ch.allink.microsite.pageElement.PageView
 **/

public class Page extends CMSAbstractModel
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _sections:Array
	
	/**Title of the Page**/
	public var title:String
	/**Formats for special situations**/
	public var format:String
	public var extraFields:String
	public var visiblecontent:Boolean
	public var languagemenu:String = ""
	public var language:String = ""
	public var has_children:String = ""
	public var _cached_url:String
	public var appname:String = ""
	
	private var _color:uint	
	private var _verticalspacing:Boolean
	private var _backgroundImage:Array
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Creates a new Page instance.
	 **/
	public function Page()
	{
		super()
	}
	
	//-------------------------------------------------------------------------
	//
	//  Properties
	//
	//-------------------------------------------------------------------------
	
	/**
	 * A collection of Section instances.
	 **/
	public function set sections(values:Array):void
	{
		_sections = []
		for each(var xml:XML in values)
		{
			var sectionClass:Class = SectionContentTypes.
									 getContentTypeModelByType(xml.type)
			if(!sectionClass)
				trace("Allink warning: Model with type: " + xml.type + 
					  " doesn't exist")
			//TODO throw error, when sectionClass is null
			if(sectionClass && xml is XML)
				_sections.push(modelFactory.create(sectionClass, xml))
		}
	}
	
	public function get sections():Array
	{
		return _sections
	}
	
	/**
	 * A collection of Image instances.
	 **/
//	public function get files():Vector.<Image>
//	{
//		var files:Vector.<Image> = new Vector.<Image>
//		for each(var section:Section in _sections)
//		{
//			for each(var file:Image in section.files)
//				files.push(file)
//		}
//		return files
//	}
	
	public function set backgroundimage(values:Array):void
	{
		_backgroundImage = fillCollection(Image, values)
	}
	
	public function get backgroundimage():Array
	{
		return _backgroundImage 
	}
	
	
	public function set verticalspacing(value:Object):void
	{
		if(value == "False") _verticalspacing = false
		else if(value == "True") _verticalspacing = true
	}
	
	public function get verticalspacing():Object
	{
		return _verticalspacing
	}
	
	public function set color(value:Object):void
	{
		if(value) _color = uint(value)
	}
	
	public function get color():Object
	{
		return _color
	}
}
}