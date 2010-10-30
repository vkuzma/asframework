package ch.allink.micrositeframework.view
{
import caurina.transitions.Tweener;

import ch.allink.micrositeframework.cmsmodel.Navigation;
import ch.allink.micrositeframework.cmsmodel.NavigationViewEvent;
import ch.allink.micrositeframework.cmsmodel.NavigationViewService;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.AntiAliasType;
import flash.text.GridFitType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

/** 
 * Darstellungsobjekt eines Navigationselements
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
	
	public static const REQUEST_ACTIVATE:String = "requestActivate"
	
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------

	private var _navigationService:NavigationViewService
	private var _defaultColor:uint
		
	public var activeColor:uint
	public var rollOverColor:uint
	public var tweeningTime:Number
	
	public var textFieldConfig:Function
	public var textFormatConfig:Function
	public var customRollOutAction:Function
	public var customRollOverAction:Function
	
	private var _textField:TextField
	private var _textFormat:TextFormat
	private var _active:Boolean
	
	public var navigation:Navigation
	 
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
		
	public function NavigationView(navigation:Navigation)
	{
		this.navigation = navigation
		this.model = navigation
		build()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Override methods
	//
	//-------------------------------------------------------------------------
	
	public override function build():void
	{
		_textFormat = new TextFormat()
		_active = false
		_defaultColor = 0x000000
		rollOverColor = 0x000000
		activeColor = 0xFFFFFF
		tweeningTime = 1
			
		_textField = new TextField()
		this.addChild(_textField)
		navigationText = navigation.title
			
		this.mouseChildren = false
		this.buttonMode = true
		this.useHandCursor = true
			
		this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler)
		this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler)
	}
	
	public override function dispose():void
	{
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
				
		Tweener.addTween(_textField, 
			{
				time: tweeningTime,
				_color: newColor
			})
	}
	
	public function requestActivate():void
	{
		dispatchEvent(new Event(REQUEST_ACTIVATE))
	}

	public function setUpText():void
	{
		_textField.textColor = defaultColor
		_textField.selectable = false
		_textField.autoSize = TextFieldAutoSize.LEFT
		_textField.multiline = false
		_textField.wordWrap = false
		_textField.antiAliasType = AntiAliasType.ADVANCED
		_textField.gridFitType = GridFitType.PIXEL
		
		
		//Individuelle Einstellungen setzen
		if(textFieldConfig != null)
			_textField = textFieldConfig(_textField)
		if(textFormatConfig != null)
			_textFormat = textFormatConfig(_textFormat)
		_textField.setTextFormat(_textFormat)
		//Nur bei gesetzem Font soll das Textfeld embedded werden
		if(_textFormat.font != null)
			_textField.embedFonts = true
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
		Tweener.addTween(_textField,
			{
				time: tweeningTime,
				_color: rollOverColor
			})
			
		if(customRollOverAction != null)
			customRollOverAction(event.currentTarget)
	}
	
	public function rollOutHandler(event:MouseEvent):void
	{
		reset()
		if(customRollOutAction != null)
			customRollOutAction(event.currentTarget)
	}
	
//	private function stage_KeyDownHandler(event:KeyboardEvent):void
//	{
//		if (event.keyCode == Keyboard.ENTER || event.keyCode == Keyboard.SPACE)
//			clickHandler(null)
//	}
	
	private function stage_MouseMoveHandler(event:MouseEvent):void
	{
		rollOverHandler(null)
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_MouseMoveHandler)
	}
	
	private function bubbleEvent(event:NavigationViewEvent):void
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
	
	public function set active(value:Boolean):void
	{
		_active = value
			
		var newColor:uint 
		if(_active)
			newColor = activeColor
		else
			newColor = defaultColor
		Tweener.addTween(_textField, 
			{
				time: tweeningTime,
				_color: newColor
				
			})
			
		var navViewEvent:NavigationViewEvent
		if(_active)
		{
			//Bedingte Animation zum öffnen der Unternavigation
			//zB. navigationservice.openAnimation()
			navViewEvent = new NavigationViewEvent(
				NavigationViewEvent.ACTIVATED, false, false, this)
			
		}
		else
		{
			//Bedingte Animation zum schliessen der Unternavigation
			//zB. navigationservice.closeAnimation()
			navViewEvent = new NavigationViewEvent(
				NavigationViewEvent.DEACTIVATED, false, false, this)
		}
		dispatchEvent(navViewEvent)
	}
	
	public function get active():Boolean
	{
		return _active
	}
	
	public function set defaultColor(value:uint):void
	{
		_defaultColor = value
		_textField.textColor = _defaultColor
	}
	
	public function get defaultColor():uint
	{
		return _defaultColor		
	}
	
	//---------------------------------
	// TextField
	//---------------------------------
	
	public function set navigationText(value:String):void
	{
		_textField.text = value
		setUpText()
	}
	
	public function get navigationText():String
	{
		return _textField.text
	}
	
	public function set textFormat(value:TextFormat):void
	{
		_textFormat = value
		navigationText = _textField.text
	}
	
	public function get textFormat():TextFormat
	{
		return _textFormat
	}
	
	public function get textField():TextField
	{
		return _textField
	}
}
}
