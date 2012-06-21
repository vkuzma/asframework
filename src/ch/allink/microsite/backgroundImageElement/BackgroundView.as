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
	
	public static const REQUEST_RESIZE:String = "requestResize"
	
	private var _imageOperation:IImageViewOperation
	private var oldImageView:ImageView
	private var currentImage:Image
	private var blendJobs:JobService
	public var imageView:ImageView
	/** Duration time of the blendanimation **/
	public var animationTime:Number
	/** Custom blendin operation **/
	public var blendInOperation:Function
	/** Custom blendout operation **/
	public var blendOutOperation:Function
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function BackgroundView()
	{
		super()
		animationTime = 1.2
	}
	
	//-------------------------------------------------------------------------
	//
	//	Override methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Initial object.
	 **/
	public override function build():void
	{
		imageView = new ImageView(new Image())
		oldImageView = new ImageView(new Image())
		currentImage = new Image()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function blendIn(imageView:ImageView, blendJobs:JobService):void
	{
		if(blendInOperation != null) blendInOperation(imageView, blendJobs)
		else TweenLite.to(imageView, animationTime, {autoAlpha: 1, 
						  onComplete: blendJobs.doNextJob})
	}
	
	private function blendOut(imageView:ImageView, blendJobs:JobService):void
	{
		if(blendOutOperation != null) blendOutOperation(imageView, blendJobs)
		else
			TweenLite.to(imageView, animationTime,
						 {autoAlpha: 0, onComplete: blendJobs.doNextJob})
	}
	
	private function removeImageView(imageView:ImageView):void
	{
		if(!imageView) return
		if(!contains(imageView)) return
		removeChild(imageView)
		imageView.dispose()
		imageView = null	
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Loads an builds an ImageView instance by image.
	 **/
	public function buildBackground(image:Image):Boolean
	{
		if(currentImage.url == image.url) return false
		currentImage = image
			
		var oldModel:Image = oldImageView.image 
		if(imageView.isLoading) imageView.dispose()

		oldImageView = imageView
		imageView = new ImageView(image)
		imageView.addEventListener(Event.ADDED_TO_STAGE, imageView_addedToStageHandler)
		imageView.addEventListener(Event.COMPLETE, imageView_completeHandler)
		imageView.addEventListener(ProgressEvent.PROGRESS, imageView_progressHandler)
		imageView.build()
		return true
	}
	
	/**
	 * Resize of the ImageView instance.
	 **/
	public function resize(stageWidth:Number, stageHeight:Number):void
	{
		imageView.resizeBitmapAspectRatioTo(stageWidth, stageHeight, ImageViewResizeAlign.CENTRE)
		if(imageView.operation) imageView.operation.resize(stageWidth, stageHeight)
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
			blendJobs.addJob(new Job(blendOut, {params: [oldImageView, blendJobs]}))
		blendJobs.addJob(new Job(blendIn, {params: [imageView, blendJobs]}))
		blendJobs.addJob(new Job(removeImageView, {params: [oldImageView]}))
		blendJobs.doJob()
		
		dispatchEvent(event)
	}
	
	private function imageView_progressHandler(event:ProgressEvent):void
	{
		dispatchEvent(event)
	}
	
	private function imageView_addedToStageHandler(event:Event):void 
	{
		dispatchEvent(new Event(REQUEST_RESIZE))
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Custom imageoperation.
	 **/
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