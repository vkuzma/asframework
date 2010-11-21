package ch.allink.microsite.sectionElement
{
import ch.allink.microsite.core.AbstractView;
import ch.allink.microsite.pageElement.SectionOperationFormat;

public class TextOperation implements ISectionOperation
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function TextOperation()
	{
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function set targetView(value:AbstractView):void
	{
	}
	
	public function get targetView():AbstractView
	{
		return null
	}
	
	public function get FORMAT():String
	{
		return SectionOperationFormat.TEXT_ONLY
	}
	
	public function get height():Number
	{
		return 0;
	}
}
}