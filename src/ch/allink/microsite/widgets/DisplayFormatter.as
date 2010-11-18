package ch.allink.microsite.widgets
{
import ch.allink.microsite.core.AbstractModel;

import flash.text.StyleSheet;

public class DisplayFormatter extends AbstractModel
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
//	protected var bwImage:Boolean = false;
//	protected var textImageLeftSquare:Boolean = true;
//	protected var leftImagePasteOnSquare:Boolean = false;
	//protected var topMargin:int = 0;
//	protected var textImageLeftWidth:int = 80;
//	protected var leftImageTextSpacing:int = 5;
//	protected var galleryImageWidth:int = 50;
//	protected var galleryImagesInRow:int = 5;
//	protected var galleryImageSpacing:int = 5;
//	protected var galleryImageYSpacing:int = -99;
	public var sectionVerticalSpacing:Number = 8
	public var sectionHorizontalSpacing:Number = 8
//	protected var styleSheet:StyleSheet;
//	protected var imageHanlder:Function;
//	protected var imageOnOverHandler:Function;
//	protected var imageOnOutHandler:Function;
	protected var sectionTitleUpperCase:Boolean = false
	protected var titleTextSpacing:Number = 0
//	protected var imageTextSpacing:Number = 0;
//	protected var popupBorderW:Number = 10;
//	protected var imagesPressable:Boolean = true;
//	protected var displayPagingPopupButtons:Boolean = true;
//	protected var diplayPopupCloseBtnTopLeft:Boolean = false;
//	protected var sectionTextUpperCase:Boolean = false
//	protected var onPageChanged:Function = null
	//corretion between font start an top margint of image
//	protected var textImageLeftYOffset:Number = 0;
//	protected var textImageLeftXOffset:Number = 0;
//	private var gallerySquareImages:Boolean = true;
//	private var positionPopupButtonsOSConform:Boolean = true;
//	protected var handleTextImageLink:Boolean = true;
//	private var imageIndentLeft:Number = 0;
//	private var ignoreGallery:Boolean = false;
//	private var fixedVideoDimensions:Object;
//	private var indentAllSectionsLeft:Boolean = true;
//	protected var imageOnlyXOffset:Number = 0;
//	private var minWidthToOpen:Number = 200;
//	private var alignVideoLeft:Boolean = false;
//	private var videoStartedHandler:Function;
//	private var autoLoadVideo:Boolean = true;
//	private var alignImagesRight:Boolean = false;
	
	
	public var textFieldConfig:Function
	public var styleSheet:StyleSheet
	
	//-------------------------------------------------------------------------
	//
	//	Constants
	//
	//-------------------------------------------------------------------------
	
	public function DisplayFormatter()
	{
		super()
		
		styleSheet = new StyleSheet()
		styleSheet.setStyle("body", null)
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
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
}
}