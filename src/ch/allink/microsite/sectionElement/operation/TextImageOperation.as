package ch.allink.microsite.sectionElement.operation
{
import ch.allink.microsite.imageElement.Image;
import ch.allink.microsite.imageElement.ImageView;
import ch.allink.microsite.pageElement.PageFormatter;
import ch.allink.microsite.sectionElement.SectionView;
import ch.allink.microsite.sectionElement.sectionType.TextImageSection;
import ch.allink.microsite.sectionElement.style.TextImageStyle;
import ch.allink.microsite.util.TextFieldFactory;

import flash.text.TextField;

/**
 * @author vkuzma
 * @date Apr 1, 2011
 **/
public class TextImageOperation implements ISectionOperation
{
	//-------------------------------------------------------------------------
	//
	//	Constats
	//
	//-------------------------------------------------------------------------
	
	private const LEFT:String = "left"
	private const TOP:String  = "top"
	
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
		
	public var titleField:TextField
	public var textField:TextField
	public var imageView:ImageView
	public var image:Image
	private var _targetView:SectionView
	private var _pageFormatter:PageFormatter
	private var _textImageStyle:TextImageStyle
	private var section:TextImageSection
	
	
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
	
	private function setUpTextField(textField:TextField, widthSubtraction:Number):void
	{
		//causes scrollingproblems on windwos
		textField.width = pageFormatter.sectionWidth - widthSubtraction
		textField.styleSheet = pageFormatter.styleSheet
		textField.autoSize = pageFormatter.textAlign
		textField.condenseWhite = true
		TextFieldFactory.setDefaultFormats(textField, pageFormatter)
		textField.embedFonts = pageFormatter.enableEmbedFonts
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function build():void
	{
		//image
		if(image.url)
		{
			targetView.graphics.drawRect(0, 0, image.width, image.height)
			imageView = new ImageView(image)
			targetView.addChild(imageView)
			imageView.build()
		}
		
		//title
		var titleHeight:Number = 0
		if(section.title)
		{
			titleField = new TextField()
			targetView.addChild(titleField)
			setUpTextField(titleField, 0)
			if(textImageStyle.titleUpperCase) section.title = section.title.toUpperCase()
			titleField.htmlText = "<body><h2>" + section.title + "</h2></body>"
			titleHeight = titleField.height
			titleHeight += textImageStyle.titleTextVerticalSpacing
				
			titleField.x = textImageStyle.titleOffsetX
			titleField.y = textImageStyle.titleOffsetY
		}
		
		//text
		var widthSubtraction:Number = 0
		textField = new TextField()
		targetView.addChild(textField)
		
		switch(section.alignment)
		{
			case LEFT:
				{
					if(titleField)
					{
						titleField.y = textImageStyle.titleOffsetY
						titleHeight = titleField.y + titleField.height +
							textImageStyle.titleTextVerticalSpacing
					}
					
					widthSubtraction = image.width + textImageStyle.textImagehorizontalSpacing
					textField.x = pageFormatter.paddingLeft + widthSubtraction + 
						textImageStyle.textOffsetX
					textField.y = titleHeight + textImageStyle.textOffsetY
						
					imageView.y = titleHeight
						
				}
			break
			case TOP:
				{
					if(titleField)
					{
						titleField.y = section.images[0].height +
							textImageStyle.textImageVerticalSpacing
						titleHeight = titleField.y + titleField.height +
							textImageStyle.titleTextVerticalSpacing
					}
					textField.y = titleHeight + textImageStyle.textOffsetY
					textField.x = textImageStyle.textOffsetX
				}
			break
			default:
				{
					if(titleField)
						titleHeight = titleField.y + titleField.height + 
							textImageStyle.titleTextVerticalSpacing
							
					textField.y = titleHeight + textImageStyle.textOffsetY
					textField.x = textImageStyle.textOffsetX
				}
		}
		
		setUpTextField(textField, widthSubtraction)
		if(textImageStyle.textUpperCase) section.text = section.text.toUpperCase()
		textField.htmlText = "<body>" + section.text + "</body>"
	}
	
	/**
	 *	Resizes the title and text. 
	 */
	public function resize(sourceWidth:Number, 
						   sourceHeight:Number):void
	{
		textField.x = pageFormatter.paddingLeft 
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function set targetView(value:SectionView):void
	{
		_targetView = value
		section = _targetView.section as TextImageSection
		image = section.images[0]
	}
	
	public function get targetView():SectionView
	{
		return _targetView
	}
	
	public function get contentType():String
	{
		return TextImageSection.TYPE
	}
	
	public static function get TYPE():String
	{
		return TextImageSection.TYPE
	}
	
	public  function set pageFormatter(value:PageFormatter):void
	{
		_pageFormatter = value
		_textImageStyle = _pageFormatter.getSectionStyleByContentType(contentType) as TextImageStyle 
	}
	
	public function get pageFormatter():PageFormatter
	{
		return _pageFormatter	
	}
	
	public function get textImageStyle():TextImageStyle
	{
		return _textImageStyle
	}
	
}
}