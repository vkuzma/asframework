package ch.allink.micrositeframework.widgets
{
import caurina.transitions.Tweener;

import ch.allink.micrositeframework.view.AbstractView;

import com.pixelbreaker.ui.osx.MacMouseWheel;

import flash.display.MovieClip;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.filters.BitmapFilterQuality;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Timer;

import mx.rpc.mxml.Concurrency;
import mx.skins.halo.ScrollArrowSkin;

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
	public var contentArea:Rectangle
	private var _scrollContainer:Sprite
	
	
	//---------------------------------
	//	Layout
	//---------------------------------
	private var contentScrollBarSpacing:Number = 0.0

	//-------------------------------------------------------------------------
	//
	//  Constructor
	//
	//-------------------------------------------------------------------------
	
	public function ScrollPaneView()
	{
		this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler)
			
		contentArea = new Rectangle(0, 0, 100, 100)
		_scrollContainer = new Sprite()
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
		setUpScrollBar()
	}

	//-------------------------------------------------------------------------
	//
	//  Private methods
	//
	//-------------------------------------------------------------------------
	
	
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
			+ contentScrollBarSpacing
		scrollClipHolder.scrollTop.y = contentArea.top
		scrollClipHolder.scrollBottom.y = contentArea.bottom
			- scrollClipHolder.scrollBottom.height
		scrollClipHolder.scrollBarBackground.height = contentArea.height
		scrollClipHolder.scrollDragger.y = scrollClipHolder.scrollTop.y 
			+ scrollClipHolder.scrollTop.height
		scrollClipHolder.scrollDragger.height = ratioContentMask 
			* scrollClipHolder.scrollArea.height / 100
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function addedToStageHandler(event:Event):void
	{
//		MacMouseWheel.setup(stage)
	}
	
	private function scrollBottom_mouseDownHandler(event:MouseEvent):void
	{
		
	}
	private function scrollTop_mouseDownHanlder(event:MouseEvent):void
	{
		
	}
	private function scrollBarBackground_mouseDownHandler(event:MouseEvent):void
	{
		
	}
	
	private function scrollDragger_mouseDownHandler(event:MouseEvent):void
	{
		scrollClipHolder.scrollDragger.startDrag(false, 
			scrollClipHolder.effectiveScrollArea)
		stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler)
		stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler)
	}
	
	private function mouseMoveHandler(event:MouseEvent):void
	{
		_scrollContainer.y = -scrollClipHolder.distanceInPercent 
			* (_scrollContainer.height - contentArea.height)
			/ 100  + this.y
	}
	
	private function mouseUpHandler(event:MouseEvent):void
	{
		stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler)
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler)
		scrollClipHolder.scrollDragger.stopDrag()
			
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
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
	}
	
	public function get useScrollButtons():Boolean
	{
		return scrollClipHolder.useScrollButtons
	}
	
	public function get contentMask():Shape
	{
		return scrollClipHolder.scrollPaneMask
	}
	
	private function get ratioContentMask():Number
	{
		var _ratioContentMask:Number = contentArea.height 
			/ _scrollContainer.height * 100  
	
		if(_ratioContentMask > 100)
			_ratioContentMask = 100
		return _ratioContentMask
	}
	
	public function set scrollContainer(value:Sprite):void
	{
		_scrollContainer = value
		_scrollContainer.mask = scrollClipHolder.scrollPaneMask
	}
	
	public function get scrollCantainer():Sprite
	{
		return _scrollContainer	
	}
	
	public function get isNecessary():Boolean
	{
		return scrollClipHolder.isNecessary
	}
}
}