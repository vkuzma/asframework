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
	
	public static const ACTIVATED:String = "activated"
		
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
			
		this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler)
		this.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------

	public function activate():void
	{
		pressed = true
		
		Tweener.addTween(textField, 
			{
				time: 1,
				_color: activeColor
			})
	}
	
	public function deactivate():void
	{
		pressed = false
		
		Tweener.addTween(textField, 
			{
				time: 1,
				_color: defaultColor
			})
	}
	
	public function reset():void
	{
		var newColor:uint
		if (pressed)
			newColor = activeColor
		else
			newColor= defaultColor
				
		Tweener.addTween(textField, 
			{
				time: 1,
				_color: newColor
			})
	}

	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	//---------------------------------
	//	User inputs
	//---------------------------------
	
	public function mouseOverHandler(event:MouseEvent):void
	{
		Tweener.addTween(textField,
			{
				time: 1,
				_color: rollOverColor
			})
	}
	
	public function mouseOutHandler(event:MouseEvent):void
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
		mouseOverHandler(null)
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_MouseMoveHandler)
	}
	
//	public function focusInHandler(event:FocusEvent):void
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
