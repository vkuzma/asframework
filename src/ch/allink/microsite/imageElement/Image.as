package ch.allink.microsite.imageElement
{
import ch.allink.microsite.core.CMSAbstractModel;

public class Image extends CMSAbstractModel
{
	public var width:Number = 0
	public var height:Number = 0
	public var mimetype:String = ""
	public var imglink:String = ""
	public var extraFields:String = ""
	
	private var _description:String = ""
	
	public function Image()
	{
		super()
	}
	
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