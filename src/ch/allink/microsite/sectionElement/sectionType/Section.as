package ch.allink.microsite.sectionElement.sectionType
{
import ch.allink.microsite.core.AbstractModel;
import ch.allink.microsite.sectionElement.SectionContentTypes;

/**
 * Die Section Klasse dient als Model für eine SectionView Instanz.
 * @author Michael Walder
 * @date 7.11.2010
 * @see ch.allink.micrositeframework.cmsview.SectionView
 **/

public class Section extends AbstractModel
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	public var title:String
	public var date:String
	public var type:String
	public var ordering:String
	public var text:String
	public var region:String
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function Section()
	{
		super()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public static function get TYPE():String
	{
		return SectionContentTypes.TEXT_ONLY
	}
}
}