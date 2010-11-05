package ch.allink.micrositeframework.widgets
{
import flash.display.MovieClip;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Rectangle;

import spark.primitives.Rect;

public class ScrollPaneClipHolder extends Sprite
{
	//-------------------------------------------------------------------------
	//
	//	Global variables
	//
	//-------------------------------------------------------------------------
	
	private const SCROLL_BAR:String = "scrollBar"
	private const SCROLL_TOP:String = "scrollTop"
	private const SCROLL_BOTTOM:String = "scrollBottom"
	private const SCROLL_DRAGGER:String = "scrollDragger"
	private const SCROLL_BAR_BACKGROUND:String = "scrollBarBackground"
	
	//-------------------------------------------------------------------------
	//
	//	Global variables
	//
	//-------------------------------------------------------------------------
	
	private var scrollPaneClip:Sprite
	private var _useScrollButtons:Boolean
	private var _isNecessery:Boolean
	
	public var scrollBottom:Sprite
	public var scrollBar:Sprite
	public var scrollTop:Sprite
	public var scrollDragger:Sprite
	public var scrollBarBackground:Sprite
	public var scrollPaneMask:Shape
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function ScrollPaneClipHolder(scrollPaneClip:Sprite)
	{
		super()
		this.scrollPaneClip = scrollPaneClip
		this.addChild(scrollPaneClip)
		initializeScrollPaneClip()
	}
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function initializeScrollPaneClip():void
	{
		scrollBar = scrollPaneClip.getChildByName(SCROLL_BAR) as MovieClip
		scrollTop = scrollBar.getChildByName(SCROLL_TOP) as MovieClip
		scrollBottom = scrollBar.getChildByName(SCROLL_BOTTOM)
			as MovieClip
		scrollDragger = scrollBar.getChildByName(SCROLL_DRAGGER) 
			as MovieClip
		scrollBarBackground = scrollBar.getChildByName(
							  SCROLL_BAR_BACKGROUND) as MovieClip
		scrollPaneMask = buildMask()
		this.addChild(scrollPaneMask)
	}
	
	private function buildMask():Shape
	{
		var contentMask:Shape = new Shape()
		contentMask.graphics.beginFill(0xFF0000)
		contentMask.graphics.drawRect(0, 0, 1, 1)
		contentMask.graphics.endFill()
			
		return contentMask
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function set useScrollButtons(value:Boolean):void
	{
		_useScrollButtons = value
		if(_useScrollButtons)
		{
			scrollTop.visible = true
			scrollBottom.visible = true
		}
		else
		{
			scrollTop.visible = false
			scrollBottom.visible = false
		}
	}
	
	public function get useScrollButtons():Boolean
	{
		return _useScrollButtons
	}
	
	public function get scrollArea():Rectangle
	{
		var _scrollArea:Rectangle = new Rectangle(0, 
			scrollTop.x + scrollTop.height, 0,
			scrollBottom.y - scrollTop.height)
		return _scrollArea
	}
	
	/**
	 * Effektiver Schiebeweg des scrollDragger
	 **/
	public function get effectiveScrollArea():Rectangle
	{
		var _effectiveScrollArea:Rectangle = scrollArea
		_effectiveScrollArea.height -= scrollDragger.height
		return _effectiveScrollArea
	}
	
	public function get distanceInPercent():Number
	{
		var relativePositionY:Number = scrollDragger.y - effectiveScrollArea.y
		var _distanceInPercen:Number = relativePositionY 
			/ effectiveScrollArea.height * 100
		
		if(!_distanceInPercen)
			_distanceInPercen = 0
				
		return _distanceInPercen
	}
	
	public function get isNecessary():Boolean
	{
		if(effectiveScrollArea.height)
			_isNecessery = true
		else
			_isNecessery = false
		return _isNecessery
	}
}
}