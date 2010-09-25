package ch.allink.micrositeframework.view
{
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;

	public class BaseWebsiteView extends AbstractView
	{
		public function BaseWebsiteView()
		{
			super()
		}
		
		protected function initializeHistoryManagement():void
		{
			
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, swfaddress_changeHandler, false, 0, true)
			SWFAddress.addEventListener(SWFAddressEvent.INIT, swfaddress_initHandler, false, 0, true)
		}
		
		public function swfaddress_changeHandler(event:SWFAddressEvent):void
		{
			
		}
		
		public function swfaddress_initHandler(event:SWFAddressEvent):void
		{
			
		}
		
	}
}