package ch.allink.micrositeframework.operation
{
    import ch.allink.micrositeframework.cmsview.ImageView;
    
    import flash.display.DisplayObject;
    import flash.display.Sprite;

/**
 * @author Vladimir Kuzma
 * @date 30.10.2010
 */
     
public interface IOperation
{
    function displayFirstImageView():void
    function initImageView(imageView:ImageView):void
    function displayNextImageView(prevImageView:ImageView, 
                                         nextImageView:ImageView):void
    function resize(sourceHeight:Number, sourceWidth:Number):void
                                         
    function set targetSprite(value:Sprite):void
    function get targetSprite():Sprite
    function set imageViews(value:Vector.<ImageView>):void
    function get imageViews():Vector.<ImageView>
	function set enableClick(value:Boolean):void
	function get enableClick():Boolean
}
}