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
	
	
	public var url:String = ""
	public var name:String = ""
	public var order:int = 0
	
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function Track()
	{
		super()
	}
	
}
}