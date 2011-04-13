package ch.allink.microsite.pageElement
{
import ch.allink.microsite.core.AbstractModel;
import ch.allink.microsite.sectionElement.SectionContentTypes;

/**
 * The Page class is a model for the PageView class.
 * @author Michael Walder
 * @date 7.11.2010
 * @see ch.allink.microsite.pageElement.PageView
 **/

public class Page extends AbstractModel
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
	public var visiblecontent:Boolean
	public var languagemenu:String = ""
	public var language:String = ""
	public var has_children:String = ""
	public var _cached_url:String
	public var template:String
	
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
}
}