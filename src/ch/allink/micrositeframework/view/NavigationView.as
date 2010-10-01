package ch.allink.micrositeframework.view
{
import caurina.transitions.Tweener;

import ch.allink.micrositeframework.cmsmodel.Navigation;
import ch.allink.micrositeframework.model.ModelEvent;

import flash.events.FocusEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.ui.Keyboard;

public class NavigationView extends AbstractView
{
	//-------------------------------------------------------------------------
	//
	//	Constants
	//
	//-------------------------------------------------------------------------
	
	public static const EVENT_NAVIGATION_CLICKED:String = "EVENT_NAVIGATION_CLICKED"
	public static const EVENT_NAVIGATION_ACTIVATED:String = "EVENT_NAVIGATION_ACTIVATED"
	public static const EVENT_NAVIGATION_ROLLOVER:String = "EVENT_NAVIGATION_ROLLOVER"
	public static const EVENT_NAVIGATION_ROLLOUT:String = "EVENT_NAVIGATION_ROLLOUT"
	public static const EVENT_NAVIGATION_RESET:String = "EVENT_NAVIGATION_RESET"
		
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------

	public var defaultColor:uint
	public var activeColor:uint
	public var rollOverColor:uint
	public var pressed:Boolean
	public var textField:TextField
		
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
		
	public function NavigationView(navigation:Navigation)
	{
		//init default values	
		pressed = false
		defaultColor = 0x000000
		rollOverColor = 0x000000
		activeColor = 0x000000
		
		this.addChild(textField)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------

	public function reset():void
	{
		var newColor:uint = defaultColor
		if (pressed)
			newColor = activeColor
				
		Tweener.addTween(textField, 
			{
				time: 1,
				_color: newColor
			})
		dispatchEvent(new ModelEvent(EVENT_NAVIGATION_RESET))
	}

	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	//---------------------------------
	//	User inputs
	//---------------------------------
	
	private function stage_KeyDownHandler(event:KeyboardEvent):void
	{
		if (event.keyCode == Keyboard.ENTER || event.keyCode == Keyboard.SPACE)
			clickHandler(null)
	}
	
	public function rollOverHandler(event:MouseEvent):void
	{
		Tweener.addTween(textField,
			{
				time: 1,
				_color: rollOverColor
			})
		dispatchEvent(new ModelEvent(EVENT_NAVIGATION_ROLLOVER))
	}
	
	public function rollOutHandler(event:MouseEvent):void
	{
		reset()
		dispatchEvent(new ModelEvent(EVENT_NAVIGATION_ROLLOUT))
	}
	
	public function clickHandler(event:MouseEvent):void
	{
		pressed = true
		dispatchEvent(new ModelEvent(EVENT_NAVIGATION_CLICKED))
	}
	
	public function stage_MouseMoveHandler(event:MouseEvent):void
	{
		rollOutHandler(null)
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_MouseMoveHandler)
	}
	
	public function focusInHandler(event:FocusEvent):void
	{
		stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_KeyDownHandler)
		stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_MouseMoveHandler)
		rollOverHandler(null)
	}
	
	public function focusOutHandler(event:FocusEvent):void
	{
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_MouseMoveHandler)
		stage.removeEventListener(KeyboardEvent.KEY_DOWN, stage_KeyDownHandler)
		rollOutHandler(null)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
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
