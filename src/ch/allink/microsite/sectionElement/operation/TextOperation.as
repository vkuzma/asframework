package ch.allink.microsite.sectionElement.operation
{
import ch.allink.microsite.pageElement.PageFormatter;
import ch.allink.microsite.sectionElement.Section;
import ch.allink.microsite.sectionElement.SectionContentTypes;
import ch.allink.microsite.sectionElement.SectionView;
import ch.allink.microsite.sectionElement.style.TextStyle;
import ch.allink.microsite.widgets.TextFieldFactory;

import flash.text.TextField;

public class TextOperation implements ISectionOperation
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	public var titleField:TextField
	public var textField:TextField
	private var _targetView:SectionView
	private var _pageFormatter:PageFormatter
	private var _textStyle:TextStyle
	private var section:Section
	
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
	
	private function layOut():void
	{
		textField.y = titleField.y + titleField.height
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function build():void
	{
		titleField = new TextField()
		targetView.addChild(titleField)	
		setUpTextField(titleField)
		titleField.htmlText = "<h2>"+section.title+"</h2>"
			
		textField = new TextField()
		targetView.addChild(textField)
		setUpTextField(textField)
		textField.htmlText = "<body>"+section.text+"</body>"
			
		layOut()
	}
	
	/**
	 *	Resizes the title and text. 
	 */
	public function resize(sourceWidth:Number, 
									sourceHeight:Number):void
	{
		titleField.y = pageFormatter.paddingLeft
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
	
	public static function get FORMAT():String
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