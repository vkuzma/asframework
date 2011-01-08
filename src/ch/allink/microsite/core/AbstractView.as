package ch.allink.microsite.core
{
import caurina.transitions.properties.*;

import flash.display.Sprite;

{
	ColorShortcuts.init()
	DisplayShortcuts.init()
	FilterShortcuts.init()
}

public class AbstractView extends Sprite implements IAbstractView
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