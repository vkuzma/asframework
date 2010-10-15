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
	private var _textFormat:TextFormat
	private var _textFormatFunction:Function
	private var title:TextField
	
	private var imageViews:Vector.<ImageView>
	private var images:Array

	public var section:Section
	private var _displayFormatter:DisplayFormatter
	private var _enableBlendIn:Boolean
	
	
	
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
		_textFormat = new TextFormat()
		contentText = section.content
		enableBlendIn = false
	}
	
	//-------------------------------------------------------------------------
	//
	//	Overriden methods
	//
	//-------------------------------------------------------------------------
	
	final public override function build():void
	{
		if(_enableBlendIn)
			blendIn()
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
	
	public function setUpText():void
	{
		textField.selectable = false
		textField.autoSize = TextFieldAutoSize.LEFT
		textField.antiAliasType = AntiAliasType.ADVANCED
		textField.gridFitType = GridFitType.PIXEL
		textField.multiline = true
		textField.wordWrap = true
		if(_displayFormatter)
		{
			if(_displayFormatter.textFieldConfig != null)
				textField = _displayFormatter.textFieldConfig(textField)
			if(_displayFormatter.textFormatConfig != null)
				_textFormat = _displayFormatter.textFormatConfig(_textFormat)
		}
		
		if(_textFormat.font)
		{
			textField.setTextFormat(_textFormat) 
			textField.embedFonts = true
		}
		else
		{
			textField.setTextFormat(_textFormat)
		}
	}
	
	public function blendIn():void
	{
		Tweener.addTween(this,
			{
				time: 2,
				_autoAlpha: 1
			})
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function set contentText(value:String):void
	{
		textField.htmlText = value
		if(_displayFormatter)
			displayFormatter = _displayFormatter
		if(_enableBlendIn)
			blendIn()
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
	
	public function get textFormat():TextFormat
	{
		return _textFormat
	}
	
	public function set enableBlendIn(value:Boolean):void
	{
		_enableBlendIn = value
		if(value)
		{
			this.alpha = 0
			this.visible = false
		}
		else
		{
			this.alpha = 1
			this.visible = true
		}
	}
	
	public function get enableBlendIn():Boolean
	{
		return _enableBlendIn
	}
}
}