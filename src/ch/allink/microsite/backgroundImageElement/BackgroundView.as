package ch.allink.microsite.backgroundImageElement
{
import caurina.transitions.Tweener;

import ch.allink.microsite.core.AbstractModel;
import ch.allink.microsite.core.AbstractView;
import ch.allink.microsite.imageElement.Image;
import ch.allink.microsite.imageElement.ImageView;

import flash.events.Event;

public class BackgroundView extends AbstractView
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var oldImageView:ImageView
	public var imageView:ImageView
	public var animationTime:Number
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function BackgroundView(model:AbstractModel=null)
	{
		super()
		imageView = new ImageView(new Image())
		oldImageView = new ImageView(new Image())
		animationTime = 2
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function blendIn(imageView:ImageView):void
	{
		Tweener.addTween(imageView,
			{
				time: animationTime,
				_autoAlpha: 1
			})
	}
	
	private function blendOut(imageView:ImageView):void
	{
		Tweener.addTween(imageView,
			{
				time: animationTime,
				_autoAlpha: 0,
				onComplete: function():void
				{
					imageView = null
				}
			})
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function buildBG(image:Image):void
	{
		var oldModel:Image = oldImageView.image 
		var model:Image = imageView.image
		if(oldModel.url != image.url ||
		   imageView.currentBitmap == null)
		{
			if(imageView.isLoading)
				imageView.loader.close()
					
			imageView = new ImageView(image)
			imageView.addEventListener(Event.ADDED_TO_STAGE, imageView_addedHandler)
			imageView.addEventListener(Event.COMPLETE, imageView_completeHandler)
			oldImageView = imageView
			imageView.build()
		}
	}
	
	public function resize():void
	{
		if (imageView.currentBitmap)
			imageView.resizeBitmapAspectRatioTo(stage.stageWidth, stage.stageHeight)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function imageView_completeHandler(event:Event):void
	{
		var imageView:ImageView = event.target as ImageView
		imageView.visible = false
		imageView.alpha = 0
		if(oldImageView.currentBitmap != null)
			blendOut(oldImageView)
		this.addChild(imageView)
		blendIn(imageView)
		dispatchEvent(event)
	}
	
	private function imageView_addedHandler(event:Event):void 
	{
		resize()
	}
}
}