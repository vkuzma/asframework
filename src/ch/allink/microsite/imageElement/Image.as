package ch.allink.microsite.imageElement
{
import ch.allink.microsite.core.AbstractModel;

public class Image extends AbstractModel
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _description:String
	public var width:Number
	public var height:Number
	public var url:String
	public var type:String = "ImageContentType"
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function Image()
	{
		super()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function set description(value:String):void
	{
		_description = value
	}
	
	public function get description():String
	{
		return _description
	}
}
}