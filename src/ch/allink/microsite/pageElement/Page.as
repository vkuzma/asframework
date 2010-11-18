package ch.allink.microsite.pageElement
{
import ch.allink.microsite.core.CMSAbstractModel;
import ch.allink.microsite.imageElement.Image;
import ch.allink.microsite.sectionElement.Section;

/**
 * Die Page Klasse dient als Model für eine PageView Instanz.
 * @author Michael Walder
 * @date 7.11.2010
 * @see ch.allink.micrositeframework.cmsview.PageView
 **/

public class Page extends CMSAbstractModel
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _sections:Array
	
	public var title:String
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
	
	public function set sections(values:Array):void
	{
		_sections = fillCollection(Section, values)
	}
	
	public function get sections():Array
	{
		return _sections
	}
	
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