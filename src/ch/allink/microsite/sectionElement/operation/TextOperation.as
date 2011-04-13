package ch.allink.microsite.sectionElement.operation
{
import ch.allink.microsite.pageElement.PageFormatter;
import ch.allink.microsite.sectionElement.SectionContentTypes;
import ch.allink.microsite.sectionElement.SectionView;
import ch.allink.microsite.sectionElement.sectionType.TextSection;
import ch.allink.microsite.sectionElement.style.TextStyle;
import ch.allink.microsite.util.TextFieldFactory;

import flash.text.TextField;

public class TextOperation implements ISectionOperation
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	public var textField:TextField
	private var _targetView:SectionView
	private var _pageFormatter:PageFormatter
	private var _textStyle:TextStyle
	private var section:TextSection
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Creates a new TextOperation instance.
	 */
	public function TextOperation()
	{
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function setUpTextField(textField:TextField):void
	{
		textField.width = pageFormatter.sectionWidth
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
		textField = new TextField()
		targetView.addChild(textField)
		setUpTextField(textField)
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
		section = _targetView.section
	}
	
	public function get targetView():SectionView
	{
		return _targetView
	}
	
	public function get contentType():String
	{
		return SectionContentTypes.TEXT_ONLY
	}
	
	public static function get TYPE():String
	{
		return SectionContentTypes.TEXT_ONLY
	}
	
	public  function set pageFormatter(value:PageFormatter):void
	{
		_pageFormatter = value
		_textStyle =
			_pageFormatter.getSectionStyleByContentType(contentType) 
			as TextStyle 
	}
	
	public function get pageFormatter():PageFormatter
	{
		return _pageFormatter	
	}
	
	public function get textStyle():TextStyle
	{
		return _textStyle
	}
}
}