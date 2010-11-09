package ch.allink.micrositeframework.view
{
import caurina.transitions.properties.ColorShortcuts;
import caurina.transitions.properties.DisplayShortcuts;
import caurina.transitions.properties.FilterShortcuts;

import ch.allink.micrositeframework.model.AbstractModel;

import flash.display.Sprite;

{
	ColorShortcuts.init()
	DisplayShortcuts.init()
	FilterShortcuts.init()
}

public class AbstractView extends Sprite implements IView
{
	//-------------------------------------------------------------------------
	//
	//	Protected variables
	//
	//-------------------------------------------------------------------------
	
	protected var _model:AbstractModel
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function AbstractView()
	{
		super()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function build():void
	{
	}
	
	public function dispose():void
	{
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function get model():AbstractModel
	{
		return _model
	}
	
	public function set model(value:AbstractModel):void
	{
		_model = value
	}
}
}