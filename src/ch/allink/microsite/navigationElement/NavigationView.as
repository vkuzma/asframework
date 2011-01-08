package ch.allink.microsite.navigationElement
{
import caurina.transitions.Tweener;

import ch.allink.microsite.core.AbstractView;
import ch.allink.microsite.events.NavigationViewEvent;
import ch.allink.microsite.widgets.TextFieldFactory;

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
	public static const REQUEST_MAJOR_ACTIVATE:String = "majorRequestActivate"
	
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------

	private var _navigationTreeView:NavigationTreeView
	private var _defaultColor:uint
		
	public var activeColor:uint
	public var rollOverColor:uint
	public var tweeningTime:Number
	
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
	
	public function requestMajorActivate():void
	{
		dispatchEvent(new Event(REQUEST_MAJOR_ACTIVATE))
	}

	public function setUpText():void
	{
		TextFieldFactory.setDefaultFormats(_textField)
		_textField.textColor = defaultColor
		_textField.autoSize = TextFieldAutoSize.LEFT
		_textField.multiline = false
		_textField.wordWrap = false
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
	}
	
	public function rollOutHandler(event:MouseEvent):void
	{
		reset()
	}
	
	private function stage_MouseMoveHandler(event:MouseEvent):void
	{
		rollOverHandler(null)
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_MouseMoveHandler)
	}
	
	private function bubbleEvent(event:NavigationViewEvent):void
	{
		dispatchEvent(event)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	

	public function set navigationTreeView(value:NavigationTreeView):void
	{
		_navigationTreeView = value
		_navigationTreeView.parentNavigationView = this
		_navigationTreeView.addEventListener(NavigationViewEvent.
											NAVIGATION_CLICK, bubbleEvent)
	}
	
	public function get navigationTreeView():NavigationTreeView
	{
		return _navigationTreeView
	}
	
	public function signAsActive():void
	{
		
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
