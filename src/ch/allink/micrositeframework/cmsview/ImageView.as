package ch.allink.micrositeframework.cmsview
{
import ch.allink.micrositeframework.cmsmodel.Image;
import ch.allink.micrositeframework.net.ModelFactory;
import ch.allink.micrositeframework.net.ModelRequest;
import ch.allink.micrositeframework.net.ResultEvent;
import ch.allink.micrositeframework.util.CMSXmlPath;
import ch.allink.micrositeframework.view.AbstractView;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.geom.Matrix;
import flash.net.URLRequest;


[Event (name='complete', type='flash.events.Event')]

public class ImageView extends AbstractView
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	public var _imageOptions:ImageOptions
	public var isLoading:Boolean
	public var loader:Loader
	public var image:Image
	private var _loadedBitmap:Bitmap
	private var _currentBitmap:Bitmap
	private var _loaded:Boolean
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	public function ImageView(image:Image=null)
	{
		model = image
		this.image = image
		super()
		isLoading = false
		_loaded = false
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
		loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,
			loader_progressHandler)
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, 
			loader_onCompleteHandler)
		loader.load(urlRequest)
		isLoading = true
	}
	
	public override function dispose():void
	{
		loader.unload()	
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
	
	private function centreDraw(scaleX:Number, scaleY:Number, 
						  sourceHeight:Number, sourceWidth:Number,
						  xOffset:Number, yOffset:Number):void
	{
		removeChild(_currentBitmap)
		if(_currentBitmap != _loadedBitmap)
			_currentBitmap.bitmapData.dispose()
		
		
		_currentBitmap = null
		var bmpData:BitmapData = new BitmapData(sourceWidth, sourceHeight,
			false, 0xFFFFFF);
		var matrix:Matrix = new Matrix();
		matrix.scale(scaleX, scaleY);
		matrix.tx = xOffset
		matrix.ty = yOffset
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
		
		if (_loadedBitmap.width == sourceWidth 
			&& _loadedBitmap.height == sourceHeigth)
			return
		
		if(contains(_currentBitmap))
		{
			draw(sourceWidth / _loadedBitmap.width,
				sourceHeigth / _loadedBitmap.height, sourceHeigth, sourceWidth)
		}
	}
	
	public function resizeBitmapAspectRatioTo(sourceWidth:Number, 
											  sourceHeight:Number,
						 		align:String = ImageViewResizeAlign.LEFT):void
	{
		if(!_loadedBitmap)
			return
		
		if (_loadedBitmap.width == sourceWidth 
			&& _loadedBitmap.height == sourceHeight)
			return
		
		if(contains(_currentBitmap))
		{
			var xOffset:Number = 0
			var yOffset:Number = 0
			var targetScale:Number = sourceWidth / _loadedBitmap.width
			var heightInFuture:Number = targetScale * _loadedBitmap.height
			if(heightInFuture < sourceHeight)
			{
				targetScale =  sourceHeight / _loadedBitmap.height
				//xOffset sorgt dafür, dass das Bild in die Mitte von 
				//sourceWidth zentriert wird.
				if(align == ImageViewResizeAlign.CENTRE)
					xOffset = (sourceWidth - _loadedBitmap.width * targetScale) 
						/ 2
			}
			if(align == ImageViewResizeAlign.CENTRE)
				yOffset = (sourceHeight - _loadedBitmap.height * targetScale) 
					/ 2
					
			
					
			centreDraw(targetScale, targetScale, sourceHeight, sourceWidth, 
					   xOffset, yOffset)
		}
	}
	
	public  function displayWithHandCursor(value:Boolean=true):void {
		buttonMode = value;
		useHandCursor = value;
		mouseChildren = !value;
		focusRect = !value;
	}	
	
	
	public function buildByFileID(fileID:int):void
	{
		var modelFactory:ModelFactory = new ModelFactory
		var modelReqeust:ModelRequest = modelFactory.load(Image,
			CMSXmlPath.IMAGE_PATH + fileID,ModelFactory.TYPE_MODEL)
		modelReqeust.addEventListener(ResultEvent.DATA_LOADED,
										modelRequest_dataLoadedHandler)
	}
	
	public function attachBitmap(bitmap:Bitmap):void
	{
		_loadedBitmap = bitmap
		_currentBitmap = bitmap
		addChild(_currentBitmap)
	}
	
	public function closeLoading():void
	{
		loader.close()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function loader_onCompleteHandler(event:Event):void
	{
		isLoading = false
		var bmp:Bitmap = event.target.content as Bitmap
		_loadedBitmap = bmp
		_currentBitmap = _loadedBitmap
		addChild(_currentBitmap)
		_loaded = true
		dispatchEvent(event)
	}
	
	private function loader_progressHandler(event:ProgressEvent):void
	{
		dispatchEvent(event)
	}
	
	private function modelRequest_dataLoadedHandler(event:ResultEvent):void
	{
		var image:Image = event.model as Image
		model = image
		this.image = image
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
		{
			_imageOptions = new ImageOptions
			_imageOptions.width = image.width
				
		}
		
		return _imageOptions
	}
	
	public function get fileURL():String
	{
		var image:Image = Image(model)
		return imageOptions.basePath+image.uniqueid+"_"+_imageOptions.width
			+imageOptions.option1+".jpg"
	}
	
	public function get loaded():Boolean
	{
		return _loaded
	}
}
}