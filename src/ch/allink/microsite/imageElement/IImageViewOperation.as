package ch.allink.microsite.imageElement
{
import flash.display.Bitmap;
import flash.display.Sprite;

public interface IImageViewOperation
{
	/**
	 * Creates a new ImageView instance with bitmap and adds imageViewMask to
	 * the created ImageView instance.
	 **/
	function initialize(bitmap:Bitmap):void
		
	function resize(sourceWidth:Number, sourceHeight:Number):void
	/**
	 * Resizes the ImageView instance with one or more filters.
	 * @param sourceWidth Width of the resize area.
	 * @param sourceHeight Height of the resize area.
	 **/
	function set targetSprite(value:Sprite):void
}
}