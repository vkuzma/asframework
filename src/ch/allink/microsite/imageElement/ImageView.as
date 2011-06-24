package ch.allink.microsite.imageElement
{
import ch.allink.microsite.core.AbstractView;

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
	
	private var _loadedBitmap:Bitmap
	private var _currentBitmap:Bitmap
	private var _loaded:Boolean
	private var _operation:IImageViewOperation
	public var isLoading:Boolean
	public var loader:Loader
	public var image:Image
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	public function ImageView(image:Image = null)
	{
		super()
		this.image = image
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
		var urlRequest:URLRequest = new URLRequest(image.url)
		loader = new Loader()
		loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loader_progressHandler)
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_onCompleteHandler)
		loader.load(urlRequest)
		
		isLoading = true
	}
	
	public override function dispose():void
	{
		if(!loader) return 
		try
		{
			loader.close()
			loader.unload()
		}
		catch(error:Error)
		{
			
		}
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function draw(scaleX:Number, scaleY:Number, sourceHeight:Number, sourceWidth:Number,
						  xOffset:Number, yOffset:Number, transparent:Boolean):void
	{
		removeChild(currentBitmap)
		if(currentBitmap != loadedBitmap) currentBitmap.bitmapData.dispose()
		
		_currentBitmap = null
		var bmpData:BitmapData = new BitmapData(sourceWidth, sourceHeight, true, 0xFFFFFF)
		var matrix:Matrix = new Matrix()
		matrix.scale(scaleX, scaleY)
		matrix.tx = xOffset
		matrix.ty = yOffset
		loadedBitmap.smoothing = true;
		bmpData.draw(_loadedBitmap, matrix, null, null, null, false)
		loadedBitmap.smoothing = false
		_currentBitmap = new Bitmap(bmpData)
		addChild(currentBitmap)
		
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
			
	public function resizeBitmapTo(sourceWidth:Number, sourceHeigth:Number, 
								   transparent:Boolean = false):void
	{
		if(!loadedBitmap) return
		
		if(sourceWidth == 0)
			sourceWidth = loadedBitmap.width * sourceHeigth / loadedBitmap.height
			
		if(contains(currentBitmap))
		{
			draw(sourceWidth / loadedBitmap.width, sourceHeigth / loadedBitmap.height, sourceHeigth,
				sourceWidth, 0, 0, transparent)
		}
	}
	
	public function resizeBitmapAspectRatioTo(sourceWidth:Number, sourceHeight:Number,
						 		align:String = ImageViewResizeAlign.LEFT_TOP, 
								transparent:Boolean = false):void
	{
		if(!loadedBitmap) return
		if (loadedBitmap.width == sourceWidth && loadedBitmap.height == sourceHeight) return
		
		if(contains(currentBitmap))
		{
			var xOffset:Number = 0
			var yOffset:Number = 0
			var differenceX:Number = sourceWidth - loadedBitmap.width
			var differenceY:Number = sourceHeight - loadedBitmap.height
				
			var targetScale:Number = sourceWidth / loadedBitmap.width
			var heightInFuture:Number = targetScale * loadedBitmap.height
			if(heightInFuture < sourceHeight)
			{
				targetScale =  sourceHeight / loadedBitmap.height
				//xOffset sorgt dafür, dass das Bild in die Mitte von 
				//sourceWidth zentriert wird.
				if(align == ImageViewResizeAlign.CENTRE) 
					xOffset = (sourceWidth - loadedBitmap.width * targetScale) / 2
			}
			if(align == ImageViewResizeAlign.CENTRE)
				yOffset = (sourceHeight - loadedBitmap.height * targetScale) / 2
					
					
			draw(targetScale, targetScale, sourceHeight, sourceWidth, xOffset, yOffset, transparent)
			
			if(operation) operation.resize(sourceWidth, sourceHeight)
		}
	}
	
	public function attachBitmap(bitmap:Bitmap):void
	{
		if(_currentBitmap)
			if(contains(currentBitmap))	removeChild(currentBitmap)
		_loadedBitmap = bitmap
		_currentBitmap = bitmap
		_loaded = true
		isLoading = false
		addChild(currentBitmap)
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
		_loaded = true
			
		var bitmap:Bitmap = event.target.content as Bitmap
		_loadedBitmap = bitmap
		_currentBitmap = _loadedBitmap
		addChild(currentBitmap)
			
		if(operation) operation.initialize(loadedBitmap)
			
		dispatchEvent(event)
	}
	
	private function loader_progressHandler(event:ProgressEvent):void
	{
		var bubbleProgressEvent:ProgressEvent = new ProgressEvent(event.type, event.bubbles,
			event.cancelable, event.bytesLoaded, event.bytesTotal)
		dispatchEvent(bubbleProgressEvent)
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
	
	public function get loaded():Boolean
	{
		return _loaded
	}
	
	public function set operation(value:IImageViewOperation):void
	{
		_operation = value
		_operation.targetSprite = this
		if(loadedBitmap) _operation.initialize(loadedBitmap)
	}
	
	public function get operation():IImageViewOperation
	{
		return _operation
	}
}
}