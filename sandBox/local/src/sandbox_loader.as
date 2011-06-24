package
{
import ch.allink.microsite.allinkWebsite.SiteLoader;

import com.greensock.events.LoaderEvent;
import com.greensock.loading.SWFLoader;

import flash.display.LoaderInfo;
import flash.events.Event;
import flash.text.TextField;

/**
 * @author Vladimir Kuzma
 **/
public final class sandbox_loader extends SiteLoader
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var loadingTextField:TextField
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function sandbox_loader()
	{
		super()
		var params:Object = LoaderInfo(root.loaderInfo).parameters
		websiteFileName = String(params.main_swf_path)
		build()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Protected methods
	//
	//-------------------------------------------------------------------------
	
	protected override function build():void
	{
		super.build()
		loadingTextField = new TextField()
		addChild(loadingTextField)
		loadingTextField.visible = false
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	protected override function resizeHandler(event:Event):void
	{
		super.resizeHandler(event)
	}
	
	protected override function swfLoader_progressHandler(
		event:LoaderEvent):void
	{
		super.swfLoader_progressHandler(event)
		var swfLoader:SWFLoader = event.target as SWFLoader
		loadingTextField.visible = true
		loadingTextField.text = Math.round(swfLoader.progress * 100).toString()
	}
	
	protected override function swfLoader_completeHandler(
		event:LoaderEvent):void
	{
		super.swfLoader_completeHandler(event)
		removeChild(loadingTextField)
		loadingTextField = null
	}
}
}