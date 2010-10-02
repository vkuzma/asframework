package ch.allink.micrositeframework.cmsview
{
	import ch.allink.micrositeframework.cmsmodel.Image;
	import ch.allink.micrositeframework.view.AbstractView;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import mx.events.Request;
	
	import org.osmf.events.LoaderEvent;
	
	public class ImageView extends AbstractView
	{
		public var _imageOptions:ImageOptions
		private var _loader:Loader
		
		public function ImageView()
		{
			super();
		}
		
		public function get fileURL():String
		{
			var image:Image = Image(model)
			return imageOptions.basePath+image.uniqueid+"_"+image.width+imageOptions.option1+".jpg"
		}
		
		public override function build():void
		{
			var urlRequest:URLRequest = new URLRequest(fileURL)
			_loader = new Loader()
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _loader_onCompleteHandler)
			_loader.load(urlRequest)
			
		}
		
		private function _loader_onCompleteHandler(event:LoaderEvent):void
		{
			trace("loaded")
		}
				
		public function get imageOptions():ImageOptions
		{
			if(!_imageOptions)
				_imageOptions = new ImageOptions
					
			return _imageOptions
		}
		
	}
}