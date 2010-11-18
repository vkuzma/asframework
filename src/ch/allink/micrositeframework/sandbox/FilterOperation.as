package ch.allink.micrositeframework.sandbox
{
import ch.allink.micrositeframework.cmsview.ImageView;
import ch.allink.micrositeframework.cmsview.ImageViewResizeAlign;

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
	private var imageView:ImageView
	
	/**
	 * The Mask from the imageView instance with filters.
	 **/
	public var imageViewMask:Shape
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
		imageViewMask = createMask()
	}
	
	//-------------------------------------------------------------------------
	//
	// Private methods
	//
	//-------------------------------------------------------------------------
	
	private function createMask():Shape
	{
		var mask:Shape = new Shape()
		mask.graphics.beginFill(0x00FFFF)
		mask.graphics.drawRect(0, 0, 1, 1)
		mask.graphics.endFill()
			
		return mask
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
		if(!bitmap)
			return
			
		if(imageView)
			dispose()
			
		var bitmapData:BitmapData = bitmap.bitmapData
		var newBitmapData:BitmapData = bitmapData.clone()
			
		var newBitmap:Bitmap = new Bitmap(newBitmapData)
		newBitmap.filters = filters
			
		imageView = new ImageView()
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
		if(!imageView)
			return
			
		if(_targetSprite.contains(imageView))
			_targetSprite.setChildIndex(imageView, 
										_targetSprite.numChildren - 1)
				
		imageView.resizeBitmapAspectRatioTo(sourceWidth, sourceHeight,
											ImageViewResizeAlign.CENTRE)
	}
	
	/**
	 * Disposes the target ImageView instance.
	 * @see #targetSprite()
	 **/
	public function dispose():void
	{
		if(imageView)
		{
			if(_targetSprite.contains(imageView))
				_targetSprite.removeChild(imageView)
		}
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
}
}