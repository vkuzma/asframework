package ch.allink.microsite.sectionElement.operation
{
import ch.allink.microsite.imageElement.Image;
import ch.allink.microsite.imageElement.ImageView;
import ch.allink.microsite.pageElement.PageFormatter;
import ch.allink.microsite.sectionElement.SectionContentTypes;
import ch.allink.microsite.sectionElement.SectionView;
import ch.allink.microsite.sectionElement.sectionType.ImageSection;

/**
 * @author vkuzma
 * @date Jan 6, 2011
 **/
public class ImageContentOperation implements ISectionOperation
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _targetView:SectionView
	private var _pageFormatter:PageFormatter
	public var imageView:ImageView
	public var image:Image
	public var imageSection:ImageSection
	public var region:String
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function ImageContentOperation()
	{
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function build():void
	{
		targetView.graphics.drawRect(0,0,image.width, image.height)
		imageView = new ImageView(image)
		targetView.addChild(imageView)
		imageView.build()
	}
	
	public function resize(sourceWidth:Number, sourceHeight:Number):void
	{
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function set targetView(value:SectionView):void
	{
		_targetView = value
		imageSection = _targetView.section as ImageSection
		image = imageSection.images[0]
	}
	
	public function get targetView():SectionView
	{
		return _targetView 
	}
	
	public function get contentType():String
	{
		return SectionContentTypes.IMAGE
	}
	
	public function set pageFormatter(value:PageFormatter):void
	{
		_pageFormatter = value
	}
	
	public function get pageFormatter():PageFormatter
	{
		return _pageFormatter
	}
	
	public static function get TYPE():String
	{
		return SectionContentTypes.IMAGE
	}
}
}