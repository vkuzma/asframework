package ch.allink.micrositeframework.view
{
import caurina.transitions.Tweener;

import ch.allink.micrositeframework.cmsmodel.Navigation;
import ch.allink.micrositeframework.cmsmodel.NavigationViewEvent;
import ch.allink.micrositeframework.cmsmodel.NavigationViewService;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

/** 
 * Darstellung eines Navigationselement
 * 
 * @author Vladimir Kuzma
 */

public class NavigationView extends AbstractView
{
	//-------------------------------------------------------------------------
	//
	//	Constats
	//
	//-------------------------------------------------------------------------
	
	public static const ACTIVATED:String = "activated"
	public static const DEACTIVATED:String = "deActivated"
	public static const REQUEST_ACTIVATE:String = "requestActivate"
	
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------

	public var activeColor:uint
	public var rollOverColor:uint
	
	public var textField:TextField
	
	public var tweeningTime:Number
		
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
		
	public function NavigationView(navigation:Navigation)
	{
		model = navigation
		//init default values	
		_active = false
		_defaultColor = 0x000000
		rollOverColor = 0x000000
		activeColor = 0xFFFFFF
		tweeningTime = 1

		
		textField = new TextField()
		this.addChild(textField)
		textField.selectable = false
		textField.text = navigation.title
		textField.textColor = defaultColor
		textField.autoSize = TextFieldAutoSize.LEFT
			
		this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler)
		this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------

	public function reset():void
	{
		var newColor:uint
		if (_active)
			newColor = activeColor
		else
			newColor= defaultColor
				
		Tweener.addTween(textField, 
			{
				time: tweeningTime,
				_color: newColor
			})
	}
	
	public function requestActivate():void
	{
		dispatchEvent(new Event(REQUEST_ACTIVATE))
	}

	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	//---------------------------------
	//	User inputs
	//---------------------------------
	
	public function rollOverHandler(event:MouseEvent):void
	{
		Tweener.addTween(textField,
			{
				time: tweeningTime,
				_color: rollOverColor
			})
	}
	
	public function rollOutHandler(event:MouseEvent):void
	{
		reset()
	}
	
//	private function stage_KeyDownHandler(event:KeyboardEvent):void
//	{
//		if (event.keyCode == Keyboard.ENTER || event.keyCode == Keyboard.SPACE)
//			clickHandler(null)
//	}
	
	public function stage_MouseMoveHandler(event:MouseEvent):void
	{
		rollOverHandler(null)
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_MouseMoveHandler)
	}
	
	private function bubbleEvent(event:Event):void
	{
		dispatchEvent(event)
	}
	
//	public function 	(event:FocusEvent):void
//	{
//		stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_KeyDownHandler)
//		stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_MouseMoveHandler)
//		mouseOverHandler(null)
//	}
//	
//	public function focusOutHandler(event:FocusEvent):void
//	{
//		stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_MouseMoveHandler)
//		stage.removeEventListener(KeyboardEvent.KEY_DOWN, stage_KeyDownHandler)
//		mouseOutHandler(null)
//	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	private var _navigationService:NavigationViewService
	public function set navigationService(value:NavigationViewService):void
	{
		_navigationService = value
		_navigationService.parentNavigationView = this
		_navigationService.addEventListener(NavigationViewEvent.
											NAVIGATION_CLICK, bubbleEvent)
	}
	
	public function get navigationService():NavigationViewService
	{
		return _navigationService
	}
	
	private var _active:Boolean
	public function set active(value:Boolean):void
	{
		_active = value
			
		var newColor:uint 
		if(_active)
			newColor = activeColor
		else
			newColor = defaultColor
		Tweener.addTween(textField, 
			{
				time: tweeningTime,
				_color: newColor
				
			})
			
		var modelEvent:Event
		if(_active)
		{
			//Bedingte Animation zum öffnen der Unternavigation
			//zB. navigationservice.openAnimation()
			modelEvent = new Event(ACTIVATED)
		}
		else
		{
			//Bedingte Animation zum schliessen der Unternavigation
			//zB. navigationservice.closeAnimation()
			modelEvent = new Event(DEACTIVATED)
		}
		dispatchEvent(modelEvent)
	}
	
	public function get active():Boolean
	{
		return _active
	}
	
	private var _defaultColor:uint
	public function set defaultColor(value:uint):void
	{
		_defaultColor = value
		textField.textColor = _defaultColor
	}
	
	public function get defaultColor():uint
	{
		return _defaultColor		
	}
	
	//---------------------------------
	// TextField text
	//---------------------------------
	
	public function set navigationText(value:String):void
	{
		textField.text = value
		textField.embedFonts = true
		textField.autoSize = TextFieldAutoSize.LEFT
		textField.multiline = false
		textField.wordWrap = false
	}
	
	public function get navigationText():String
	{
		return textField.text
	}
}
}
