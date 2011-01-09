package ch.allink.microsite.navigationElement
{
import ch.allink.microsite.core.AbstractView;
import ch.allink.microsite.events.NavigationViewEvent;
import ch.allink.microsite.util.TextFieldFactory;

import com.greensock.TweenLite;
import com.greensock.plugins.TintPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

{
	TweenPlugin.activate([TintPlugin])
}

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
	}
	
	//-------------------------------------------------------------------------
	//
	//	Override methods
	//
	//-------------------------------------------------------------------------
	
	public override function build():void
	{
		active = false
		defaultColor = 0x000000
		rollOverColor = 0x000000
		activeColor = 0xFFFFFF
		tweeningTime = 1
			
		this.addChild(textField)
		navigationText = navigation.title
			
		mouseChildren = false
		buttonMode = true
		useHandCursor = true
			
		addEventListener(MouseEvent.ROLL_OVER, rollOverHandler)
		addEventListener(MouseEvent.ROLL_OUT, rollOutHandler)
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
		if (active) newColor = activeColor
		else newColor = defaultColor
				
		TweenLite.to(textField, tweeningTime, {tint: newColor})
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
		TextFieldFactory.setDefaultFormats(textField)
		textField.textColor = defaultColor
		textField.autoSize = TextFieldAutoSize.LEFT
		textField.multiline = false
		textField.wordWrap = false
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
		TweenLite.to(textField, tweeningTime, {tint: rollOverColor})
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
	
	public function set active(value:Boolean):void
	{
		_active = value
			
		var newColor:uint 
		if(_active) newColor = activeColor
		else newColor = defaultColor
		TweenLite.to(textField, tweeningTime, {tint: newColor})
			
		var navViewEvent:NavigationViewEvent
		if(_active)
		{
			navViewEvent = new NavigationViewEvent(
				NavigationViewEvent.ACTIVATED, false, false, this)
			
		}
		else
		{
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
		if(!_textFormat) _textFormat = new TextFormat()
		return _textFormat
	}
	
	public function get textField():TextField
	{
		if(!_textField) _textField = new TextField()
		return _textField
	}
}
}
