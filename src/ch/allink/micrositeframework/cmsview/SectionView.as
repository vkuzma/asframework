package ch.allink.micrositeframework.cmsview
{
import caurina.transitions.Tweener;

import ch.allink.micrositeframework.cmsmodel.DisplayFormatter;
import ch.allink.micrositeframework.cmsmodel.Image;
import ch.allink.micrositeframework.cmsmodel.Section;
import ch.allink.micrositeframework.view.AbstractView;

import flash.events.Event;
import flash.text.AntiAliasType;
import flash.text.Font;
import flash.text.GridFitType;
import flash.text.StyleSheet;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.TextFormat;

import mx.formatters.DateFormatter;

public class SectionView extends AbstractView
{
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public var textField:TextField
	private var title:TextField
	private var rawText:String
	
	private var imageViews:Vector.<ImageView>
	private var images:Array

	public var section:Section
	private var _displayFormatter:DisplayFormatter
	
	
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function SectionView(section:Section = null)
	{
		
		super()
		this.section = section
		textField = new TextField()
		this.addChild(textField)
		contentText = section.content
	}
	
	//-------------------------------------------------------------------------
	//
	//	Overriden methods
	//
	//-------------------------------------------------------------------------
	
	final public override function build():void
	{
		if(section.files != null)
		{
			images = section.files
			imageViews = buildImageViews(images)
		}
	}
	
	public override function dispose():void
	{
		textField = null
		title = null
		imageViews = null
		images = null
 	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function buildImageViews(images:Array):Vector.<ImageView>
	{
		var imageViews:Vector.<ImageView> = new Vector.<ImageView>
		for each(var image:Image in images)
		{
			var imageView:ImageView = new  ImageView(image)
			imageViews.push(imageView)
		}
		return imageViews
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	private function setUpText():void
	{
		if(_displayFormatter.textFieldConfig != null)
			textField = _displayFormatter.textFieldConfig(textField)
				
		textField.wordWrap = true
		textField.autoSize = TextFieldAutoSize.LEFT
		textField.antiAliasType = AntiAliasType.ADVANCED
		textField.gridFitType = GridFitType.PIXEL
		textField.selectable = false
			
		textField.styleSheet = displayFormatter.styleSheet
		contentText = rawText
		if(textField.styleSheet.getStyle("body").fontFamily)
			textField.embedFonts = true
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function set contentText(value:String):void
	{
		rawText = value
		textField.multiline = true		//wegen <br /> Tag
		textField.htmlText = "<body>"+rawText+"</body>"
	}
	
	public function get contentText():String
	{
		return textField.htmlText
	}
	
	public function set displayFormatter(value:DisplayFormatter):void
	{
		_displayFormatter = value
		setUpText()
	}
	
	public function get displayFormatter():DisplayFormatter
	{
		return _displayFormatter
	}
}
}