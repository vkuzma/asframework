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
}
}