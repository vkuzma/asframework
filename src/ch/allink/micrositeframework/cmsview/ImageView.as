package ch.allink.micrositeframework.cmsview
{
import ch.allink.micrositeframework.cmsmodel.Image;
import ch.allink.micrositeframework.net.ModelFactory;
import ch.allink.micrositeframework.net.ModelRequest;
import ch.allink.micrositeframework.net.ResultEvent;
import ch.allink.micrositeframework.view.AbstractView;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.geom.Matrix;
import flash.net.URLRequest;

import org.osmf.media.MediaFactory;

public class ImageView extends AbstractView
{
	//-------------------------------------------------------------------------
	//
	//	Constants
	//
	//-------------------------------------------------------------------------
	
	private const xmlPath:String = "./?do=xml&mode=resource&fileID="
		
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	public var _imageOptions:ImageOptions
	private var _loader:Loader
	private var _loadedBitmap:Bitmap
	private var _currentBitmap:Bitmap
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	public function ImageView(image:Image=null)
	{
		model = image
		super()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Overriden methods
	//
	//-------------------------------------------------------------------------
	
	public override function build():void
	{
		var urlRequest:URLRequest = new URLRequest(fileURL)
		_loader = new Loader()
		_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, 
			_loader_onCompleteHandler)
		_loader.load(urlRequest)
		
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
			
	public function resizeBitmapTo(w:Number, h:Number, 
								   transparent:Boolean = false):void
	{
		if(!_loadedBitmap)
		{
			return
		}
		
		if (_loadedBitmap.width == w && _loadedBitmap.height == h)
		{
			return
		}
		
		if(contains(_currentBitmap))
		{
			removeChild(_currentBitmap)
			if(_currentBitmap != _loadedBitmap)
				_currentBitmap.bitmapData.dispose()
			_currentBitmap = null
			var bmpData:BitmapData = new BitmapData(w, h, 
				transparent, 0xFFFFFF);
			var m:Matrix = new Matrix();
			m.scale(w / _loadedBitmap.width, h / _loadedBitmap.height);
			_loadedBitmap.smoothing = true;
			bmpData.draw(_loadedBitmap, m, null, null, null, true);
			_loadedBitmap.smoothing = false;
			_currentBitmap = new Bitmap(bmpData);
			addChild(_currentBitmap);
		}
	}
	
	public function buildByPageID(pageID:int):void
	{
		var modelFactory:ModelFactory = new ModelFactory
		var modelReqeust:ModelRequest = modelFactory.load(Image,
			xmlPath+pageID,ModelFactory.TYPE_MODEL)
		modelReqeust.addEventListener(ResultEvent.DATA_LOADED,
										modelRequest_dataLoadedHandler)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function _loader_onCompleteHandler(event:Event):void
	{
		var bmp:Bitmap = Bitmap(_loader.content)
		_loadedBitmap = bmp
		_currentBitmap = _loadedBitmap
		addChild(_currentBitmap)
		dispatchEvent(event)
	}
	
	private function modelRequest_dataLoadedHandler(event:ResultEvent):void
	{
		var image:Image = event.model as Image
		model = image
		build()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function get loadedBitmap():Bitmap
	{
		return _loadedBitmap
	}
	
	public function get currentBitmap():Bitmap
	{
		return _currentBitmap
	}
	
	public function get imageOptions():ImageOptions
	{
		if(!_imageOptions)
			_imageOptions = new ImageOptions
		
		return _imageOptions
	}
	
	public function get fileURL():String
	{
		var image:Image = Image(model)
		return imageOptions.basePath+image.uniqueid+"_"+image.width
			+imageOptions.option1+".jpg"
		
	}
	
}
}