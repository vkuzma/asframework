package ch.allink.microsite.util
{


/**
 * @author vkuzma
 * @date Jan 14, 2011
 **/
public class Report
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _targetObject:Object
	public var enable:Boolean
	public var indent:int
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function Report(targetObject:Object)
	{
		_targetObject = targetObject
		enable = false
		indent = 0
	}
	
	private function makeIndents(indent:int):String
	{
		var indents:String = ""
		for(var i:int = 0; i < indent; i++) indents += "\t"
		return indents
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
		
	public function print(output:String):void
	{
		if(enable)	trace(makeIndents(indent) + output)
	}
	
	public function get targetObject():Object
	{
		return _targetObject
	}
}
}