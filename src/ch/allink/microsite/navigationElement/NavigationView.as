package ch.allink.microsite.navigationElement
{
import ch.allink.microsite.core.AbstractView;
import ch.allink.microsite.events.NavigationViewEvent;
import ch.allink.microsite.util.Report;
import ch.allink.microsite.util.ReportService;
import ch.allink.microsite.util.TextFieldFactory;

import com.greensock.TweenLite;
import com.greensock.plugins.TintPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

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
	private var _active:Boolean
	
	public var navigation:Navigation
	public var report:Report
	 
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
		
	public function NavigationView(navigation:Navigation)
	{
		this.navigation = navigation
		report = new Report(this)
		ReportService.addReport(report)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Override methods
	//
	//-------------------------------------------------------------------------
	
	public override function build():void
	{
		_active = false
		defaultColor = 0x000000
		rollOverColor = 0x000000
		activeColor = 0xFFFFFF
		tweeningTime = 1
			
		addChild(textField)
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
		report.print(name + " will be display as reset.")
		var newColor:uint
		if (active) newColor = activeColor
		else newColor = defaultColor
				
		TweenLite.to(textField, tweeningTime, {tint: newColor})
	}
	
	/**
	 * 
	 **/
	public function requestActivate(capture:Boolean = true):void
	{
		if(capture) report.print(name + " will be captured first.")
		report.print(name + " want to be activated.")
		var requestActivatedEvent:NavigationViewEvent =
			new NavigationViewEvent(NavigationViewEvent.REQUEST_ACTIVATE, false,
				false, this)
		if(capture)
		{
			if(navigationTreeView) navigationTreeView.resetAll()
			
			var captureFirstEvent:NavigationViewEvent = new NavigationViewEvent(
				NavigationViewEvent.CAPTURED_FIRST, false, false, this)
			dispatchEvent(captureFirstEvent)
		}
			
		dispatchEvent(requestActivatedEvent)
	}
	
	public function setUpText():void
	{
		TextFieldFactory.setDefaultFormats(textField)
		textField.textColor = defaultColor
		textField.autoSize = TextFieldAutoSize.LEFT
		textField.multiline = false
		textField.wordWrap = false
	}
	
	/**
	 * Adds a NavigationView instance to the navigationTreeView navigaitionViews
	 * collection.
	 **/
	public function addChildNavigationView(navigationView:NavigationView):void
	{
		navigationTreeView.addNavigationView(navigationView)
	}
	
	public function activate(first:Boolean = false):void
	{
		report.print(name + " has been activated.")
		if(!_active) TweenLite.to(textField, tweeningTime, {tint: activeColor})
		_active = true
		var activatedEvent:NavigationViewEvent = new NavigationViewEvent(
			NavigationViewEvent.ACTIVATED, false, false, this)
		dispatchEvent(activatedEvent)
	}
	
	public function deactivate():void
	{
		report.print(name + " has been deactivated.")
		if(_active) TweenLite.to(textField, tweeningTime, {tint: defaultColor})
		_active = false
		var deActivatedEvent:NavigationViewEvent = new NavigationViewEvent(
			NavigationViewEvent.DEACTIVATED, false, false, this)
		dispatchEvent(deActivatedEvent)
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
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------

	public function set navigationTreeView(value:NavigationTreeView):void
	{
		_navigationTreeView = value
		_navigationTreeView.parentNavigationView = this
	}
	
	public function get navigationTreeView():NavigationTreeView
	{
		if(!_navigationTreeView) navigationTreeView = new NavigationTreeView()
			
		return _navigationTreeView
	}
	
	public function get active():Boolean
	{
		return _active
	}
	
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
	// TextField
	//---------------------------------
	
	public function set navigationText(value:String):void
	{
		textField.text = value
		setUpText()
	}
	
	public function get navigationText():String
	{
		return _textField.text
	}
	
	public function get textField():TextField
	{
		if(!_textField) _textField = new TextField()
		return _textField
	}
}
}
