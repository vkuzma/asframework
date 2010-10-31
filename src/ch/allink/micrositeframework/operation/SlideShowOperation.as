package ch.allink.micrositeframework.operation
{
    import caurina.transitions.Tweener;
    
    import ch.allink.micrositeframework.cmsview.ImageView;
    
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.EventDispatcher;

/**
 * @author Vladimir Kuzma
 * @date 30.10.2010
 */
 
public final class SlideShowOperation extends EventDispatcher implements IOperation
{

    //-------------------------------------------------------------------------
    //
    //  Constructor
    //
    //-------------------------------------------------------------------------
    
    private var _targetSprite:Sprite
    private var _imageViews:Vector.<ImageView>
    private var imageViewMask:Shape
    public var blendInTime:Number
    
    private var maskSlideOutTime:Number
    
    //-------------------------------------------------------------------------
    //
    //  Constructor
    //
    //-------------------------------------------------------------------------
    public function SlideShowOperation()
    {
        super()
        blendInTime = 2.0
        maskSlideOutTime = 2.0
    }
    
    
    //-------------------------------------------------------------------------
    //
    //  Public methods
    //
    //-------------------------------------------------------------------------
    
    public function displayFirstImageView():void
    {
        blendIn(imageViews[0])
    }
    
    //Wird nur beim laden der ersten imageView ausgefuehrt
    public function initImageView(imageView:ImageView):void
    {
        if(imageView == imageViews [0])
        {
            imageViewMask = createMask()
            targetSprite.addChild(imageViewMask)
            imageView.mask = imageViewMask
        }
            
    }
     
    public function displayNextImageView(prevImageView:ImageView, 
        nextImageView:ImageView):void
    {
        Tweener.addTween(imageViewMask,
            {
                time: maskSlideOutTime,
                x: -imageViews[0].width,
                onComplete: swapImageViews
            })
    }
    
    public function resize(sourceHeight:Number, sourceWidth:Number):void
    {
        imageViews[0].height = sourceHeight
        imageViews[0].width = sourceWidth
        imageViews[1].height = sourceHeight
        imageViews[1].width = sourceWidth
        imageViewMask.height = sourceHeight
        imageViewMask.width = sourceWidth
    }
    
    public function blendIn(imageView:ImageView):void
    {
        Tweener.addTween(imageView,
            {
                time: blendInTime,
                _autoAlpha: 1
            })
    }
    
    //-------------------------------------------------------------------------
    //
    //  Private methods
    //
    //-------------------------------------------------------------------------
    
    private function createMask():Shape
    {
        var mask:Shape = new Shape()
        mask.graphics.beginFill(0xFF0000)
        mask.graphics.drawRect(0, 0, 1, 1)
        mask.graphics.endFill()
        return mask
    }
    
    //Tausch die erste und zweite ImageView aus 
    //(geht nur bei gleichzeitig 2 ImageViews im imageViews)
    private function swapImageViews():void
    {
        imageViews[0].dispose()
        targetSprite.removeChild(imageViews[0])
        imageViews[0] = imageViews[1]
        
        imageViewMask.x = 0
        imageViews[0].mask = imageViewMask
    }
    
    //-------------------------------------------------------------------------
    //
    //  Properties
    //
    //-------------------------------------------------------------------------
    
    public function set targetSprite(value:Sprite):void
    {
        _targetSprite = value
    }
    
    public function get targetSprite():Sprite
    {
        return _targetSprite
    }
    
    public function set imageViews(value:Vector.<ImageView>):void
    {
        _imageViews = value
    }
    
    public function get imageViews():Vector.<ImageView>
    {
        return _imageViews
    }
}
}