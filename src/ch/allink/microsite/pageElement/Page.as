package ch.allink.microsite.pageElement
{
import ch.allink.microsite.core.CMSAbstractModel;
import ch.allink.microsite.imageElement.Image;
import ch.allink.microsite.sectionElement.Section;

import flash.net.registerClassAlias;

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
	public var fileid:int
	public var languageid:int
	public var visiblecontent:Boolean
	
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
		_sections = fillCollection(Section, values)
	}
	
	public function get sections():Array
	{
		return _sections
	}
	
	/**
	 * A collection of Image instances.
	 **/
	public function get files():Vector.<Image>
	{
		var files:Vector.<Image> = new Vector.<Image>
		for each(var section:Section in _sections)
		{
			for each(var file:Image in section.files)
			{
				files.push(file)
			}
		}
		return files
	}
}
}