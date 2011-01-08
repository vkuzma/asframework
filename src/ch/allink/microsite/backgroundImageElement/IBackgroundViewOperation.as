package ch.allink.microsite.backgroundImageElement
{
import ch.allink.microsite.core.AbstractView;
import ch.allink.microsite.imageElement.ImageView;

/**
 * @author Vladimir Kuzma
 * @date 30.10.2010
 **/
public interface IBackgroundViewOperation
{
    function displayFirstImageView():void
    function initImageView(imageView:ImageView):void
    function displayNextImageView(prevImageView:ImageView, 
                                         nextImageView:ImageView):void
    function resize(sourceHeight:Number, sourceWidth:Number):void
                                         
    function set targetView(value:AbstractView):void
    function get targetView():AbstractView
    function set imageViews(value:Vector.<ImageView>):void
    function get imageViews():Vector.<ImageView>
	function set enableClick(value:Boolean):void
	function get enableClick():Boolean
}
}