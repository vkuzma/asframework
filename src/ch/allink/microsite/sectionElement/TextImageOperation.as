package ch.allink.microsite.sectionElement
{
import ch.allink.microsite.core.AbstractView;
import ch.allink.microsite.imageElement.Image;
import ch.allink.microsite.imageElement.ImageView;
import ch.allink.microsite.pageElement.SectionOperationFormat;

import flash.text.TextField;

public class TextImageOperation implements ISectionOperation
{
	
	//-------------------------------------------------------------------------
	//
	//	Constants
	//
	//-------------------------------------------------------------------------
	
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var content:TextField
	private var imageView:ImageView
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function TextImageOperation()
	{
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	public function build(section:Section):void
	{
		var image:Image = section.files[0] as Image
		content = new TextField()
			
		imageView = new ImageView(image)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
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
		return SectionOperationFormat.TEXT_IMAGE_LEFT
	}
	
	
	
	public function get height():Number
	{
		return 0
	}
}
}