package ch.allink.microsite.scrollPaneElement
{
import ch.allink.microsite.core.AbstractView;

import com.greensock.TweenLite;
import com.osx.MacMouseWheel;

import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

/**
 * Darstellung eines Scrollbalken aus dem *_assets.fla
 * @date 4.11.2010
 * @author Vladimir Kuzma
 */
public class ScrollPaneView extends AbstractView
{
	//-------------------------------------------------------------------------
	//
	//  Global Variables
	//
	//-------------------------------------------------------------------------

	private var scrollClipHolder:ScrollPaneClipHolder
	private var _scrollContainer:Sprite
	private var scrolling:Boolean
	private var scrollTimer:Object
	public var contentArea:Rectangle
	public var scrollStepHeight:Number
	public var fixedDraggerSize:Boolean
	public var extraHeight:Number
	
	//---------------------------------
	//	Layout
	//---------------------------------
	private var _contentScrollBarSpacing:Number = 0.0

	//-------------------------------------------------------------------------
	//
	//  Constructor
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Creates a ScrollPaneView instance.
	 **/
	public function ScrollPaneView()
	{
		this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler)
			
		fixedDraggerSize = false
		scrollStepHeight = 50
		contentArea = new Rectangle(0, 0, 100, 100)
		_scrollContainer = new Sprite()
		scrollTimer = {}
		extraHeight = 0

		scrolling = false
	}
	
	//-------------------------------------------------------------------------
	//
	//  Override methods
	//
	//-------------------------------------------------------------------------

	/**
	 * Build the scrollbar and sets all mouseactions.
	 **/ 
	public override function build():void
	{
		this.addChild(scrollClipHolder)
		scrollClipHolder.scrollPaneMask.height = contentArea.height
		scrollClipHolder.scrollPaneMask.width = contentArea.width
		scrollClipHolder.scrollBottom.addEventListener(MouseEvent.MOUSE_DOWN, 
			scrollBottom_mouseDownHandler)
		scrollClipHolder.scrollTop.addEventListener(MouseEvent.MOUSE_DOWN, 
			scrollTop_mouseDownHanlder)
		scrollClipHolder.scrollDragger.addEventListener(MouseEvent.MOUSE_DOWN, 
			scrollDragger_mouseDownHandler)
			
		setUpScrollBar()
	}

	//-------------------------------------------------------------------------
	//
	//  Private methods
	//
	//-------------------------------------------------------------------------
	
	private function scrollAStep():void
	{
		scrollPosition = -1
		moveContainer()
	}
	
	private function moveContainer():void
	{
		if(isNecessary)
			scrollContainer.y = -scrollClipHolder.currentScrollPosition 
				* (scrollContainer.height - contentArea.height)
				/ 100  + y
		else 
			scrollContainer.y = y
	}
	
	private function scroll(scrollStep:Number):void
	{
		scrollPosition = scrollStep
		moveContainer()
		if(scrolling)
			TweenLite.to(scrollTimer, 0.05,
				{
					onComplete: scroll,
					onCompleteParams: [scrollStep]
				})
	}
	
	private function firstScroll(scrollStep:Number):void
	{
		scroll(scrollStep)
		scrolling = true
		TweenLite.to(scrollTimer, 1,
			{
				onComplete: scroll,
				onCompleteParams: [scrollStep]
			})	
	}
	
	//-------------------------------------------------------------------------
	//
	//  Public methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Positions all visual elements of the scrollbar. Sets the contentcontainer
	 * position in relation to the scrollbarproperties.
	 **/
	public function setUpScrollBar():void
	{
		scrollClipHolder.scrollPaneMask.height = contentArea.height
		scrollClipHolder.scrollPaneMask.width = contentArea.width
			
		scrollClipHolder.scrollBar.x = contentArea.right
			+ _contentScrollBarSpacing
		scrollClipHolder.scrollTop.y = contentArea.top
		scrollClipHolder.scrollBottom.y = contentArea.bottom
			- scrollClipHolder.scrollBottom.height
		scrollClipHolder.scrollBarBackground.height = contentArea.height
			
		scrollClipHolder.scrollDraggerNominal = ratioContentMask 
									* scrollClipHolder.scrollArea.height / 100
		if(!fixedDraggerSize)
			scrollClipHolder.scrollDragger.height = scrollClipHolder.
													scrollDraggerNominal
				
		scrollClipHolder.scrollDragger.y = 
			scrollClipHolder.currentScrollPosition 
			* scrollClipHolder.effectiveScrollArea.height / 100
			+ scrollClipHolder.effectiveScrollArea.top
			
		moveContainer()
	}
	
	public function resetScrollDragger():void
	{
		scrollClipHolder.scrollDragger.y = 0
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function addedToStageHandler(event:Event):void
	{
		MacMouseWheel.setup(stage)
		stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler)
	}
	
	private function scrollBottom_mouseDownHandler(event:MouseEvent):void
	{
		firstScroll(-stepHeightInPercent)	
	}
	
	private function scrollTop_mouseDownHanlder(event:MouseEvent):void
	{
		firstScroll(stepHeightInPercent)	
	}
	
	private function scrollDragger_mouseDownHandler(event:MouseEvent):void
	{
		scrollClipHolder.scrollDragger.startDrag(false, 
			scrollClipHolder.effectiveScrollArea)
		
		stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler)
	}
	
	private function stage_mouseMoveHandler(event:MouseEvent):void
	{
		moveContainer()
	}
	
	private function stage_mouseUpHandler(event:MouseEvent):void
	{
		scrollClipHolder.scrollDragger.stopDrag()
		TweenLite.killTweensOf(scrollTimer)
		scrolling = false
	}
	
	private function scrollContainer_mouseWheelHandler(event:MouseEvent):void
	{
		var delta:int = event.delta
		scrollPosition = delta
		moveContainer()
	}
	
	private function scrollContainer_mouseOverHandler(event:MouseEvent):void
	{
		MacMouseWheel.addJSListener()	
	}
	
	private function scrollContainer_mouseOutHandler(event:MouseEvent):void
	{
		MacMouseWheel.removeJSListener()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	/**
	 * ScrollClip from assets.fla.
	 **/
	public function set scrollClip(value:Sprite):void
	{
		scrollClipHolder = new ScrollPaneClipHolder(value)
		value.addEventListener(MouseEvent.MOUSE_WHEEL, 
			scrollContainer_mouseWheelHandler)
	}
	
	/**
	 * Visual elements of the ScrollPaneView.
	 **/
	public function get scrollClip():Sprite
	{
		return scrollClipHolder
	}
	
	/**
	 * Hides or make the scrollbuttons visible, by setting false or true.
	 **/
	public function set useScrollButtons(value:Boolean):void
	{
		scrollClipHolder.useScrollButtons = value
	}
	
	public function get useScrollButtons():Boolean
	{
		return scrollClipHolder.useScrollButtons
	}
	
	/**
	 * The maks of the to scrolled content.
	 **/
	public function get contentMask():Shape
	{
		return scrollClipHolder.scrollPaneMask
	}
	
	/**
	 * Ratio between the heigth of the content and the height of the mask.
	 **/
	private function get ratioContentMask():Number
	{
		var _ratioContentMask:Number = contentArea.height 
			/ (_scrollContainer.height + extraHeight) * 100
	
		if(_ratioContentMask > 100)
			_ratioContentMask = 100
		return _ratioContentMask
	}
	
	/**
	 * Container of the to scrolled content.
	 **/
	public function set scrollContainer(value:Sprite):void
	{
		_scrollContainer = value
		_scrollContainer.mask = scrollClipHolder.scrollPaneMask
		_scrollContainer.addEventListener(MouseEvent.MOUSE_WHEEL, 
										  scrollContainer_mouseWheelHandler)
		_scrollContainer.addEventListener(MouseEvent.MOUSE_OVER,
										  scrollContainer_mouseOverHandler)
		_scrollContainer.addEventListener(MouseEvent.MOUSE_OUT,
										  scrollContainer_mouseOutHandler)
	}
	
	public function get scrollContainer():Sprite
	{
		return _scrollContainer	
	}
	
	/**
	 * 
	 **/
	public function get isNecessary():Boolean
	{
		return scrollClipHolder.isNecessary
	}
	
	/**
	 * Space between the content and scrollbar.
	 **/
	public function set contentScrollBarSpacing(value:Number):void
	{
		_contentScrollBarSpacing = value
		setUpScrollBar()
	}
	
	public function get contentScrollBarSpacing():Number
	{
		return _contentScrollBarSpacing
	}
	
	/**
	 * Current scrollposition of the scrolldragger in percent.
	 **/
	public function set scrollPosition(value:Number):void
	{
		if(scrollClipHolder.currentScrollPosition - value > 100)
			scrollClipHolder.currentScrollPosition = 100
		else if(scrollClipHolder.currentScrollPosition - value < 0)
			scrollClipHolder.currentScrollPosition = 0
		else
			scrollClipHolder.currentScrollPosition -= value
	}
	
	public function get scrollPosition():Number
	{
		return scrollClipHolder.currentScrollPosition
	}
	
	//TODO: formel korrigieren
	private function get stepHeightInPercent():Number
	{
		var _stepHeightInPercent:Number = 
			scrollStepHeight / scrollContainer.height * 100
			
		return _stepHeightInPercent
	}
}
}