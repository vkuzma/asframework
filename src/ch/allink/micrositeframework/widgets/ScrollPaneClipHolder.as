package ch.allink.micrositeframework.widgets
{
import flash.display.MovieClip;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Rectangle;

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
	
	/**
	 * Bei True werden die Scroll Buttons eingeblendet, ansonsten ausgeblendet. 
	 **/
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
	
	/**
	 * Gesammte Scrollbereich des Inahlts.
	 **/
	public function get scrollArea():Rectangle
	{
		var _scrollArea:Rectangle
		if(useScrollButtons)
		{
			_scrollArea = new Rectangle(0, 
			scrollTop.x, 0, 
			scrollBottom.y - scrollTop.height)
			_scrollArea.y += scrollTop.height 
		}
		else
		{
			_scrollArea = new Rectangle(0, 
			scrollTop.x, 0, scrollBottom.y + scrollBottom.height)
		}
			
		return _scrollArea
	}
	
	/**
	 * Effektiver Schiebeweg des scrollDragger.
	 **/
	public function get effectiveScrollArea():Rectangle
	{
		var _effectiveScrollArea:Rectangle = scrollArea
		_effectiveScrollArea.height -= scrollDragger.height
		return _effectiveScrollArea
	}
	 
	/**
	 * Aktuelle Position des scrollDragger in Prozent. 
	 **/
	public function set currentScrollPosition(value:Number):void
	{
		var relativePositionY:Number = effectiveScrollArea.height * value / 100
		scrollDragger.y = effectiveScrollArea.y + relativePositionY
	}
	
	public function get currentScrollPosition():Number
	{
		var relativePositionY:Number = scrollDragger.y - effectiveScrollArea.y
		var _currentScrollPosition:Number = relativePositionY 
			/ effectiveScrollArea.height * 100
		
		if(_currentScrollPosition < 0)
			_currentScrollPosition = 0
				
		if(_currentScrollPosition > 100)
			_currentScrollPosition = 100
				
		return _currentScrollPosition
	}
	
	/**
	 * Ist True, falls der scrollDragger einen positiven Schiebeweg aufweist. 
	 **/
	public function get isNecessary():Boolean
	{
		if(effectiveScrollArea.height > 0)
			_isNecessery = true
		else
			_isNecessery = false
				
		return _isNecessery
	}
}
}