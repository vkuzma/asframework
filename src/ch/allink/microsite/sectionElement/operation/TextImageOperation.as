package ch.allink.microsite.sectionElement.operation
{
import ch.allink.microsite.core.AbstractView;
import ch.allink.microsite.imageElement.Image;
import ch.allink.microsite.imageElement.ImageView;
import ch.allink.microsite.pageElement.PageFormatter;
import ch.allink.microsite.sectionElement.Section;
import ch.allink.microsite.sectionElement.SectionContentTypes;
import ch.allink.microsite.sectionElement.SectionView;

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
	private var section:Section
	private var _pageFormatter:PageFormatter
	
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
	
	public function build():void
	{
		var image:Image = targetView.section.files[0] as Image
		content = new TextField()
			
		imageView = new ImageView(image)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	public function resize(sourceWidht:Number, sourceHeight:Number):void
	{
		
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function set targetView(value:SectionView):void
	{
	}
	
	public function get targetView():SectionView
	{
		return null
	}
	
	public function get contentType():String
	{
		return SectionContentTypes.TEXT_IMAGE_LEFT
	}
	
	public static function get FORMAT():String
	{
		return SectionContentTypes.TEXT_IMAGE_LEFT
	}
	
	public function get height():Number
	{
		return 0
	}
	
	public function set pageFormatter(value:PageFormatter):void
	{
		_pageFormatter = value
	}
	
	public function get pageFormatter():PageFormatter
	{
		return _pageFormatter	
	}
}
}