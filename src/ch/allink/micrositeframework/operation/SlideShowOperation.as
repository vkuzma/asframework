package ch.allink.micrositeframework.operation
{
    import caurina.transitions.Tweener;
    
    import ch.allink.micrositeframework.cmsmodel.Image;
    import ch.allink.micrositeframework.cmsview.ImageView;
    
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.MouseEvent;

/**
 * @author Vladimir Kuzma
 * @date 30.10.2010
 */
 
public final class SlideShowOperation extends EventDispatcher 
	implements IOperation
{

	public static const SLIDED_OUT:String = "slidedOut"
	
    //-------------------------------------------------------------------------
    //
    //  Global variables
    //
    //-------------------------------------------------------------------------
    
    private var _targetSprite:Sprite
    private var _imageViews:Vector.<ImageView>
	private var _enableClick:Boolean
    private var imageViewMask:Shape
	public var bgShadow:Sprite
    public var blendInTime:Number
	private var maskWidthOffset:Number
	
	private const indentOpenXPos:Number = -50
	private const indentRollOverXPos:Number = -100
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
		maskWidthOffset = 0
		_enableClick = true
		bgShadow = new Sprite()
    }
    
    
    //-------------------------------------------------------------------------
    //
    //  Public methods
    //
    //-------------------------------------------------------------------------
    
    public function displayFirstImageView():void
    {
		targetSprite.addChild(imageViews[0])
		imageViews[0].alpha = 0
		imageViews[0].visible = false
        blendIn(imageViews[0])
    }
    
    public function initImageView(imageView:ImageView):void
    {
	    //Wird nur beim laden der ersten imageView ausgeführt
        if(imageView == imageViews[0])
        {
			targetSprite.addChild(imageView)
            imageViewMask = createMask()
            targetSprite.addChild(imageViewMask)
            imageView.mask = imageViewMask
				
			targetSprite.addChild(bgShadow)
			bgShadow.visible = false
        }
		if(imageViews.length > 1)
		{
			if(imageView == imageViews[1])
			{
				targetSprite.addChildAt(imageView, 0)
				imageView.addEventListener(MouseEvent.CLICK, 
					imageView_1_mouseClickHandler)
				imageView.addEventListener(MouseEvent.ROLL_OVER, 
					imageView_1_rollOverHandler)
				imageView.addEventListener(MouseEvent.ROLL_OUT, 
					imageView_1_rollOutHandler)
				imageView_1_rollOutHandler(null)
				imageView.buttonMode = true
			}
		}
    }
     
    public function displayNextImageView(prevImageView:ImageView, 
        nextImageView:ImageView):void
    {
		if(_enableClick)
		{
			_enableClick = false
	        slideToNextImage()
		}
    }
    
    public function resize(sourceHeight:Number, sourceWidth:Number):void
    {
		if(imageViews)
		{
			if(imageViews.length > 0)
			{
				if(imageViews[0])
			        imageViews[0].resizeBitmapAspectRatioTo(
						sourceWidth, sourceHeight)
			}
			if(imageViews.length > 1)
			{
				if(imageViews[1])
			        imageViews[1].resizeBitmapAspectRatioTo(
						sourceWidth, sourceHeight)
			}
			if(imageViewMask)
			{
				resizeMaskByOffset(sourceHeight, sourceWidth, maskWidthOffset)
			}
		}
		
    }
    
    public function blendIn(imageView:ImageView):void
    {
        Tweener.addTween(imageView,
            {
                time: blendInTime,
                _autoAlpha: 1,
				onComplete: function():void
				{
					bgShadow.visible = true
				}
            })
    }
	
	public function unloadLastImageView():void
	{
		if(imageViews.length > 1 && targetSprite.contains(imageViews[1]))
		{
			if(imageViews[1])
			{
				imageViews[1].dispose()
				if(targetSprite.contains(imageViews[1]))
					targetSprite.removeChild(imageViews[1])
				imageViews.pop()
			}
		}
	}
	
	public function resizeMaskByOffset(sourceHeight:Number, sourceWidth:Number,
									   widthOffset:Number):void
	{
		maskWidthOffset = widthOffset
		if(imageViewMask)
		{			
			imageViewMask.height = sourceHeight
			imageViewMask.width = sourceWidth + maskWidthOffset
			bgShadow.x = imageViewMask.x + imageViewMask.width 
				- bgShadow.width
		}
		bgShadow.height = sourceHeight
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
        imageViews.pop()
        imageViewMask.x = 0
        imageViews[0].mask = imageViewMask
		bgShadow.x = imageViews[0].x + imageViews[0].width
    }
    
	private function updateBgShadow():void
	{
		
		bgShadow.x = imageViewMask.x + imageViewMask.width - bgShadow.width
	}
	
	private function slideToNextImage():void
	{
		removeEventListenersTo(imageViews[1])
		Tweener.addTween(imageViewMask,
			{
				time: maskSlideOutTime,
				x: -imageViews[0].width,
				onUpdate: updateBgShadow,
				onComplete: imageView_tweenerComplete
			})
	}
	
	private function removeEventListenersTo(imageView:ImageView):void
	{
		imageView.removeEventListener(MouseEvent.CLICK, 
			imageView_1_mouseClickHandler)
		imageView.removeEventListener(MouseEvent.ROLL_OVER, 
			imageView_1_rollOverHandler)
		imageView.removeEventListener(MouseEvent.ROLL_OUT, 
			imageView_1_rollOutHandler)
		imageView.buttonMode = false
	}
	
	public function loadAndDisplaydirectly(externFunction:Function, image:Image):void
	{
		Tweener.addTween(imageViewMask,
			{
				time: 1,
				x: 0,
				onUpdate: updateBgShadow,
				onComplete: externFunction,
				onCompleteParams: [image]
			})
	}
	
    //-------------------------------------------------------------------------
    //
    //  Event Hanlders
    //
    //-------------------------------------------------------------------------
	
	private function imageView_tweenerComplete():void
	{
		swapImageViews()
		targetSprite.swapChildren(bgShadow, imageViews[0])
		_enableClick = true
		dispatchEvent(new Event(SLIDED_OUT))
	}
	
	private function imageView_1_rollOverHandler(event:MouseEvent):void
	{
		Tweener.addTween(imageViewMask,
			{
				x: indentRollOverXPos,
				time: 0.5,
				onUpdate: updateBgShadow
			})
	}
	
	private function imageView_1_rollOutHandler(event:MouseEvent):void
	{
		Tweener.removeTweens(imageViewMask)
		Tweener.addTween(imageViewMask, 
			{
				x: indentOpenXPos,
				time: 0.5, 
				onUpdate: updateBgShadow
			})
	}
	
	public function imageView_1_mouseClickHandler(event:MouseEvent):void
	{	
		dispatchEvent(event)
		slideToNextImage()
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
	
	public function set enableClick(value:Boolean):void
	{
		_enableClick = value
	}
	
	public function get enableClick():Boolean
	{
		return _enableClick
	}
}
}