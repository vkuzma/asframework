package ch.allink.microsite.core
{
import com.asual.swfaddress.SWFAddress;
import com.asual.swfaddress.SWFAddressEvent;

public class AbstractWebsiteView extends AbstractView
{
	public function AbstractWebsiteView()
	{
		super()
	}
	
	protected function initializeHistoryManagement():void
	{
		
		SWFAddress.addEventListener(SWFAddressEvent.CHANGE, 
									swfaddress_changeHandler, false, 0, true)
		SWFAddress.addEventListener(SWFAddressEvent.INIT, 
									swfaddress_initHandler, false, 0, true)
	}
	
	public function swfaddress_changeHandler(event:SWFAddressEvent):void
	{
		
	}
	
	public function swfaddress_initHandler(event:SWFAddressEvent):void
	{
		
	}
}
}
