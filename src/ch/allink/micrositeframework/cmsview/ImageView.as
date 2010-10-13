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
import flash.media.Video;
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
	public var isLoading:Boolean
	public var loader:Loader
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
		isLoading = false
	}
	
	//-------------------------------------------------------------------------
	//
	//	Overriden methods
	//
	//-------------------------------------------------------------------------
	
	final public override function build():void
	{
		var urlRequest:URLRequest = new URLRequest(fileURL)
		loader = new Loader()
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, 
			_loader_onCompleteHandler)
		loader.load(urlRequest)
		isLoading = true
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function draw(scaleX:Number, scaleY:Number, 
						  sourceHeight:Number, sourceWidth:Number,
						  transparent:Boolean = false):void
	{
		removeChild(_currentBitmap)
		if(_currentBitmap != _loadedBitmap)
			_currentBitmap.bitmapData.dispose()
		
		
		_currentBitmap = null
		var bmpData:BitmapData = new BitmapData(sourceWidth, sourceHeight,
			transparent, 0xFFFFFF);
		var matrix:Matrix = new Matrix();
		matrix.scale(scaleX, scaleY);
		_loadedBitmap.smoothing = true;
		bmpData.draw(_loadedBitmap, matrix, null, null, null, false);
		_loadedBitmap.smoothing = false;
		_currentBitmap = new Bitmap(bmpData);
		addChild(_currentBitmap);
		
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
			
	public function resizeBitmapTo(sourceWidth:Number, sourceHeigth:Number, 
								   transparent:Boolean = false):void
	{
		if(!_loadedBitmap)
			return
		
		if (_loadedBitmap.width == sourceWidth && _loadedBitmap.height == sourceHeigth)
			return
		
		if(contains(_currentBitmap))
		{
			draw(sourceWidth / _loadedBitmap.width, 
				sourceHeigth / _loadedBitmap.height, sourceHeigth, sourceWidth)
		}
	}
	
	public function resizeBitmapAspectRatioTo(sourceWidth:Number, 
											  sourceHeight:Number, 
								   			  transparent:Boolean = false):void
	{
		if(!_loadedBitmap)
			return
		
		if (_loadedBitmap.width == sourceWidth && _loadedBitmap.height == sourceHeight)
			return
		
		if(contains(_currentBitmap))
		{
			var targetScale:Number = sourceWidth / _loadedBitmap.width
			var heightInFuture:Number = targetScale * _loadedBitmap.height
			if(heightInFuture < sourceHeight)
				targetScale =  sourceHeight / _loadedBitmap.height 
			
			draw(targetScale, targetScale, sourceHeight, sourceWidth)
		}
	}
	
	
	
	public function buildByFileID(fileID:int):void
	{
		var modelFactory:ModelFactory = new ModelFactory
		var modelReqeust:ModelRequest = modelFactory.load(Image,
			xmlPath+fileID,ModelFactory.TYPE_MODEL)
		modelReqeust.addEventListener(ResultEvent.DATA_LOADED,
										modelRequest_dataLoadedHandler)
	}
	
	public function attachBitmap(bitmap:Bitmap):void
	{
		_loadedBitmap = bitmap
		_currentBitmap = bitmap
		addChild(_currentBitmap)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function _loader_onCompleteHandler(event:Event):void
	{
		isLoading = false
		var bmp:Bitmap = event.target.content as Bitmap
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