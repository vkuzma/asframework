package ch.allink.micrositeframework.view
{
import caurina.transitions.Tweener;

import ch.allink.micrositeframework.cmsmodel.Navigation;
import ch.allink.micrositeframework.model.ModelEvent;

import flash.events.FocusEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.text.TextColorType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.ui.Keyboard;

public class NavigationView extends AbstractView
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------

	public var defaultColor:uint
	public var activeColor:uint
	public var rollOverColor:uint
	public var active:Boolean
	public var textField:TextField
	public var navigation:Navigation
	
	public var tweeningTime:Number
		
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
		
	public function NavigationView(navigation:Navigation)
	{
		this.navigation = navigation
		//init default values	
		active = false
		defaultColor = 0x000000
		rollOverColor = 0x000000
		activeColor = 0xFFFFFF
		tweeningTime = 1
		
		textField = new TextField()
		textField.textColor = defaultColor
			
		this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler)
		this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------

	public function activate():void
	{
		active = true
		
		Tweener.addTween(textField, 
			{
				time: tweeningTime,
				textColor: activeColor
				
			})
	}
	
	public function deactivate():void
	{
		active = false
		
		Tweener.addTween(textField, 
			{
				time: tweeningTime,
				textColor: defaultColor
			})
	}
	
	public function reset():void
	{
		var newColor:uint
		if (active)
			newColor = activeColor
		else
			newColor= defaultColor
				
		Tweener.addTween(textField, 
			{
				time: tweeningTime,
				textColor: newColor
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
	
	public function rollOverHandler(event:MouseEvent):void
	{
		Tweener.addTween(textField,
			{
				time: tweeningTime,
				textColor: rollOverColor
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
