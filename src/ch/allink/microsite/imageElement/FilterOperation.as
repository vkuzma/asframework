package ch.allink.microsite.imageElement
{
import ch.allink.microsite.util.DisplayFactory;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Rectangle;

/**
 * The FilterOperation class is used to modify an ImageView instance.
 * You can display an ImageView instance with one or more filters from the
 * filter.filters package.
 * You can also define the visible area of the filtered ImageView instance.
 * 
 * @see ch.allink.micrositeframework.cmsview.ImageView
 * @author Vladimir Kuzma
 * @date 11.11.2010
 **/
public class FilterOperation implements IImageViewOperation
{
	//-------------------------------------------------------------------------
	//
	// Global variables
	//
	//-------------------------------------------------------------------------
	
	private var _targetSprite:Sprite
	private var _filterArea:Rectangle
	private var _imageView:ImageView
	private var originalBitmap:Bitmap
	
	/**
	 * The Mask from the imageView instance with filters.
	 **/
	public var imageViewMask:Shape
	public var imageViewArea:Rectangle
	/**
	 * An Array of filters.
	 **/
	public var filters:Array
	
	//-------------------------------------------------------------------------
	//
	// Constructor
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Creates a new FilterOperation instance.
	 **/
	public function FilterOperation()
	{
		imageViewMask = DisplayFactory.createMask()
		imageViewArea = new Rectangle()
	}
	
	//-------------------------------------------------------------------------
	//
	// Public methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * @copy IImageViewOperation#initialize()
	 **/
	public function initialize(bitmap:Bitmap):void
	{
		if(!bitmap) return
		if(imageView) dispose()
			
		originalBitmap = bitmap
			
		var bitmapData:BitmapData = originalBitmap.bitmapData
		var newBitmapData:BitmapData = bitmapData.clone()
			
		var newBitmap:Bitmap = new Bitmap(newBitmapData)
			
		_imageView = new ImageView()
		_targetSprite.addChild(imageView)
		imageView.mask = imageViewMask
		imageView.addChild(imageViewMask)
		imageView.attachBitmap(newBitmap)
	}
	
	/**
	 * Resizes the ImageView instance with one or more filters.
	 * @param sourceWidth Width of the resize area.
	 * @param sourceHeight Height of the resize area.
	 **/
	public function resize(sourceWidth:Number, sourceHeight:Number):void
	{
		if(!imageView) return
			
		if(imageViewArea.width == 0 || imageViewArea.height == 0) return
			
		imageView.attachBitmap(originalBitmap)
			
		if(_targetSprite.contains(imageView))
			_targetSprite.setChildIndex(imageView, 
										_targetSprite.numChildren - 1)
				
		imageView.resizeBitmapAspectRatioTo(sourceWidth, sourceHeight,
											ImageViewResizeAlign.CENTRE)
			
		var matrix:Matrix = new Matrix()
			
		var newBitmapData:BitmapData = new BitmapData(imageViewArea.width, imageViewArea.height)
		newBitmapData.draw(imageView.currentBitmap)
		var newBitmap:Bitmap = new Bitmap(newBitmapData)
			
		imageView.attachBitmap(newBitmap)
		imageView.currentBitmap.filters= filters
	}
	
	/**
	 * Disposes the target ImageView instance.
	 * @see #targetSprite()
	 **/
	public function dispose():void
	{
		if(!imageView) return
			if(_targetSprite.contains(imageView))
				_targetSprite.removeChild(imageView)
	}
	
	//-------------------------------------------------------------------------
	//
	// Properties
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Is the ImageView instance, that will be modified.
	 **/
	public function set targetSprite(value:Sprite):void
	{
		_targetSprite = value
	}
	
	public function get targetSprite():Sprite
	{
		return _targetSprite
	}
	
	public function get imageView():ImageView 
	{
		return _imageView 
	}
}
}