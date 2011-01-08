package ch.allink.microsite.sectionElement
{
import ch.allink.microsite.core.AbstractView;
import ch.allink.microsite.sectionElement.operation.ISectionOperation;
import ch.allink.microsite.sectionElement.sectionType.Section;

public class SectionView extends AbstractView
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _operation:ISectionOperation
	public var section:Section
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function SectionView(section:Section = null)
	{
		super()
		this.section = section
	}
	
	//-------------------------------------------------------------------------
	//
	//	Overriden methods
	//
	//-------------------------------------------------------------------------
	
	public override function build():void
	{
		operation.build()
	}
	
	public override function dispose():void
	{
 	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function set operation(value:ISectionOperation):void
	{
		_operation = value
		_operation.targetView = this
	}
	
	public function get operation():ISectionOperation
	{
		return _operation
	}
}
}