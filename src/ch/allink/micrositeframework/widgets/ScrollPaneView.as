package ch.allink.micrositeframework.widgets
{

import caurina.transitions.Tweener;

import ch.allink.micrositeframework.view.AbstractView;

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
	//  Constants
	//
	//-------------------------------------------------------------------------
	
	
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
	
	//---------------------------------
	//	Layout
	//---------------------------------
	private var _contentScrollBarSpacing:Number = 0.0

	//-------------------------------------------------------------------------
	//
	//  Constructor
	//
	//-------------------------------------------------------------------------
	
	public function ScrollPaneView()
	{
		this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler)
			
		scrollStepHeight = 50
		contentArea = new Rectangle(0, 0, 100, 100)
		_scrollContainer = new Sprite()
		scrollTimer = {}

		scrolling = false
	}
	
	//-------------------------------------------------------------------------
	//
	//  Override methods
	//
	//-------------------------------------------------------------------------

	public override function build():void
	{
		this.addChild(scrollClipHolder)
		scrollClipHolder.scrollPaneMask.height = contentArea.height
		scrollClipHolder.scrollPaneMask.width = contentArea.width
		scrollClipHolder.scrollBottom.addEventListener(MouseEvent.MOUSE_DOWN, 
			scrollBottom_mouseDownHandler)
		scrollClipHolder.scrollTop.addEventListener(MouseEvent.MOUSE_DOWN, 
			scrollTop_mouseDownHanlder)
		scrollClipHolder.scrollBarBackground.addEventListener(
			MouseEvent.MOUSE_DOWN, scrollBarBackground_mouseDownHandler)
		scrollClipHolder.scrollDragger.addEventListener(MouseEvent.MOUSE_DOWN, 
			scrollDragger_mouseDownHandler)
			
		MacMouseWheel.addJSListener()
		scrollContainer.addEventListener(MouseEvent.MOUSE_WHEEL, 
			scrollContainer_mouseWheelHandler)
		setUpScrollBar()
	}

	//-------------------------------------------------------------------------
	//
	//  Private methods
	//
	//-------------------------------------------------------------------------
	
	private function scrollAStep():void
	{
		assingScrollPosition = -1
		moveContainer()
	}
	
	private function moveContainer():void
	{
		if(isNecessary)
			scrollContainer.y = -scrollClipHolder.currentScrollPosition 
				* (scrollContainer.height - contentArea.height)
				/ 100  + this.y
	}
	
	private function scroll(scrollStep:Number):void
	{
		assingScrollPosition = scrollStep
		moveContainer()
		if(scrolling)
			Tweener.addTween(scrollTimer,
				{
					time: 0.05,
					onComplete: scroll,
					onCompleteParams: [scrollStep]
				})
	}
	
	private function firstScroll(scrollStep:Number):void
	{
		scroll(scrollStep)
		scrolling = true
		Tweener.addTween(scrollTimer,
			{
				time: 1,
				onComplete: scroll,
				onCompleteParams: [scrollStep]
			})	
	}
	
	//-------------------------------------------------------------------------
	//
	//  Public methods
	//
	//-------------------------------------------------------------------------
	
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
		scrollClipHolder.scrollDragger.height = ratioContentMask 
			* scrollClipHolder.scrollArea.height / 100
		scrollClipHolder.scrollDragger.y = 
			scrollClipHolder.currentScrollPosition 
			* scrollClipHolder.effectiveScrollArea.height / 100
			+ scrollClipHolder.effectiveScrollArea.top
			
		moveContainer()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function addedToStageHandler(event:Event):void
	{
		stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler)
		MacMouseWheel.setup(stage)
	}
	
	private function scrollBottom_mouseDownHandler(event:MouseEvent):void
	{
		firstScroll(-stepHeightInPercent)	
	}
	
	private function scrollTop_mouseDownHanlder(event:MouseEvent):void
	{
		firstScroll(stepHeightInPercent)	
	}
	
	private function scrollBarBackground_mouseDownHandler(event:MouseEvent):void
	{
//		scroll(-5)
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
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler)
		scrollClipHolder.scrollDragger.stopDrag()
		Tweener.removeTweens(scrollTimer)
		scrolling = false
	}
	
	private function scrollContainer_mouseWheelHandler(event:MouseEvent):void
	{
		var delta:int = event.delta
		assingScrollPosition = delta
		moveContainer()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	/**
	 * ScrollClip aus dem assets.fla.
	 **/
	public function set scrollClip(value:Sprite):void
	{
		scrollClipHolder = new ScrollPaneClipHolder(value)
	}
	
	public function get scrollClip():Sprite
	{
		return scrollClipHolder
	}
	
	public function set useScrollButtons(value:Boolean):void
	{
		scrollClipHolder.useScrollButtons = value
		setUpScrollBar()
	}
	
	public function get useScrollButtons():Boolean
	{
		return scrollClipHolder.useScrollButtons
	}
	
	public function get contentMask():Shape
	{
		return scrollClipHolder.scrollPaneMask
	}
	
	/**
	 * Verhältniss der Höhe vom Content und der Höhe der Maske.
	 **/
	private function get ratioContentMask():Number
	{
		var _ratioContentMask:Number = contentArea.height 
			/ _scrollContainer.height * 100  
	
		if(_ratioContentMask > 100)
			_ratioContentMask = 100
		return _ratioContentMask
	}
	
	/**
	 * Container des zu Scrollenden Inhalts.
	 **/
	public function set scrollContainer(value:Sprite):void
	{
		_scrollContainer = value
		_scrollContainer.mask = scrollClipHolder.scrollPaneMask
	}
	
	public function get scrollContainer():Sprite
	{
		return _scrollContainer	
	}
	
	/**
	 * @copy ScrollPaneClipHolder#isNecessary
	 **/
	public function get isNecessary():Boolean
	{
		return scrollClipHolder.isNecessary
	}
	
	public function set contentScrollBarSpacing(value:Number):void
	{
		_contentScrollBarSpacing = value
		setUpScrollBar()
	}
	
	public function get contentScrollBarSpacing():Number
	{
		return _contentScrollBarSpacing
	}
	
	private function set assingScrollPosition(value:Number):void
	{
		if(scrollClipHolder.currentScrollPosition - value > 100)
			scrollClipHolder.currentScrollPosition = 100
		else if(scrollClipHolder.currentScrollPosition - value < 0)
			scrollClipHolder.currentScrollPosition = 0
		else
			scrollClipHolder.currentScrollPosition -= value
				
		scrollClipHolder.currentScrollPosition
	}
	
	private function get stepHeightInPercent():Number
	{
		var _stepHeightInPercent:Number = 
			scrollStepHeight / scrollContainer.height * 100
			
		return _stepHeightInPercent
	}
}
}