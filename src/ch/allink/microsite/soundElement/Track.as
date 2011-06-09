package ch.allink.microsite.soundElement
{
import ch.allink.microsite.core.AbstractModel;

/**
 * @author vkuzma
 * @date Jan 19, 2011
 **/
public class Track extends AbstractModel
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _url:String = ""
	private var _name:String = ""
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function Track()
	{
		super()
	}
	
	public function set url(value:String):void
	{
		_url = value
		var splitedUrl:Array = _url.split("/")
	}
	
	public function get url():String
	{
		return _url
	}
	
	public function set name(value:String):void
	{
		_name = value
	}
	
	public function get name():String
	{
		return _name
	}
}
}