package ch.allink.microsite.backgroundImageElement
{
import ch.allink.jobservice.Job;
import ch.allink.jobservice.JobService;
import ch.allink.microsite.core.AbstractModel;
import ch.allink.microsite.core.AbstractView;
import ch.allink.microsite.imageElement.IImageViewOperation;
import ch.allink.microsite.imageElement.Image;
import ch.allink.microsite.imageElement.ImageView;
import ch.allink.microsite.imageElement.ImageViewResizeAlign;

import com.greensock.TweenLite;
import com.greensock.plugins.AutoAlphaPlugin;
import com.greensock.plugins.TweenPlugin;

import flash.events.Event;
import flash.events.ProgressEvent;

[Event (name='complete', type='flash.events.Event')]
[Event (name='progress', type='flash.events.ProgressEvent')]

{
	TweenPlugin.activate([AutoAlphaPlugin])	
}

public class BackgroundView extends AbstractView
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var oldImageView:ImageView
	private var _imageOperation:IImageViewOperation
	private var currentImage:Image
	private var blendJobs:JobService
	public var imageView:ImageView
	public var animationTime:Number
	public var blendInOperation:Function
	public var blendOutOperation:Function
	
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
		animationTime = 1.2
		currentImage = new Image()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function blendIn(imageView:ImageView):void
	{
		if(blendInOperation != null) blendInOperation(imageView)
		else TweenLite.to(imageView, animationTime, {autoAlpha: 1})
	}
	
	private function blendOut(imageView:ImageView, blendJobs:JobService):void
	{
		if(blendOutOperation != null) blendOutOperation(imageView, blendJobs)
		else
			TweenLite.to(imageView, animationTime,
				{
					autoAlpha: 0,
					onComplete: function():void
					{
						blendJobs.doNextJob()
						removeChild(imageView)
						imageView.dispose()
						imageView = null
					}
				})
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function buildBackground(image:Image):void
	{
		if(currentImage.url == image.url) return
		currentImage = image
			
		var oldModel:Image = oldImageView.image 
		if(oldModel.url != image.url ||
		   imageView.currentBitmap == null)
		{
			if(imageView.isLoading) imageView.dispose()

			oldImageView = imageView
				
			imageView = new ImageView(image)
			imageView.addEventListener(Event.ADDED_TO_STAGE, 
									   imageView_addedHandler)
			imageView.addEventListener(Event.COMPLETE, 
									   imageView_completeHandler)
			imageView.addEventListener(ProgressEvent.PROGRESS, 
									   imageView_progressHanlder)
			imageView.build()
		}
	}
	
	public function resize():void
	{
		if (imageView.currentBitmap)
		{
			imageView.resizeBitmapAspectRatioTo(stage.stageWidth, 
				stage.stageHeight, ImageViewResizeAlign.CENTRE)
			if(imageView.operation)
				imageView.operation.resize(stage.stageWidth, stage.stageHeight)
		}
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function imageView_completeHandler(event:Event):void
	{
		var imageView:ImageView = event.target as ImageView
		if(imageOperation) imageView.operation = imageOperation
		imageView.visible = false
		imageView.alpha = 0
		addChild(imageView)
		
		blendJobs = new JobService()
		if(oldImageView.currentBitmap != null)
			blendJobs.addJob(new Job(blendOut, 
									 {params: [oldImageView, blendJobs]}))
		blendJobs.addJob(new Job(blendIn, {params: [imageView]}))
		blendJobs.doJob()
		
		dispatchEvent(event)
	}
	
	private function imageView_progressHanlder(event:ProgressEvent):void
	{
		dispatchEvent(event)
	}
	
	private function imageView_addedHandler(event:Event):void 
	{
		resize()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function set imageOperation(value:IImageViewOperation):void
	{
		_imageOperation = value
	}
	
	public function get imageOperation():IImageViewOperation
	{
		return _imageOperation
	}
}
}