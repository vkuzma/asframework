package ch.allink.microsite.scrollPaneElement
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
	
	/**Scrollbar with all elements.**/
	public var scrollBar:Sprite
	/**An element of the scrollBar**/
	public var scrollBottom:Sprite
	/**@copy ScrollPaneClipHolder#scrollBottom**/
	public var scrollTop:Sprite
	/**@copy ScrollPaneClipHolder#scrollBottom**/
	public var scrollDragger:Sprite     
	/**The needed height for the scrollDragger**/
	public var scrollDraggerNominal:Number
	/**@copy ScrollPaneClipHolder#scrollBottom**/
	public var scrollBarBackground:Sprite
	/**@copy ScrollPaneClipHolder#scrollBottom**/
	public var scrollPaneMask:Shape
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Creates a ScrollPaneClipHolder instance.
	 * @param scrollPaneClip A scrollBare from the asset.fla.
	 **/
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
	 * Hides or make the scrollbuttons visible, by setting false or true.
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
	 * Whole scrolldinstance of the content.
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
	 * Effektive slidedistance of the scrolldragger.
	 **/
	public function get effectiveScrollArea():Rectangle
	{
		var _effectiveScrollArea:Rectangle = scrollArea
		_effectiveScrollArea.height -= scrollDragger.height
		return _effectiveScrollArea
	}
	 
	/**
	 * Current scrollposition of the scrolldragge in percent.
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
	 * State of the necessitative use of the scrollbar. 
	 * Is true when the content can be scrolled, otherwise false.
	 **/
	public function get isNecessary():Boolean
	{
		if(effectiveScrollArea.height - scrollDraggerNominal > 0)
			_isNecessery = true
		else
			_isNecessery = false
				
		return _isNecessery
	}
}
}