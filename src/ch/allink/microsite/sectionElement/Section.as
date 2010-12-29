package ch.allink.microsite.sectionElement
{
import ch.allink.microsite.core.AbstractModel;
import ch.allink.microsite.imageElement.Image;

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
	public var type:String = ""
	public var extraFields:String
	public var ordering:String = ""
	public var text:String = ""
	public var region:String = ""
	
	private var _files:Array
	
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
	
	public function set files(values:Array):void
	{
			_files = fillCollection(Image, values)
	}
	
	public function get files():Array
	{
		return _files
	}
}
}