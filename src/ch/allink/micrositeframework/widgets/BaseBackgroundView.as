package ch.allink.micrositeframework.widgets
{
import ch.allink.micrositeframework.cmsmodel.Image;
import ch.allink.micrositeframework.cmsview.ImageView;
import ch.allink.micrositeframework.view.AbstractView;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.ProgressEvent;

import flashx.textLayout.compose.IVerticalJustificationLine;

/**
 * Grundfunktionen zum verwalten von imageView-Objecte
 * @author Vladimir Kuzma
 * @date 30.10.2010
 */

public class BaseBackgroundView extends AbstractView
{
    //-------------------------------------------------------------------------
    //
    //  Constants
    //
    //-------------------------------------------------------------------------
    
    public static const COMPLETE_ALL:String = "completeAll"
		
    //-------------------------------------------------------------------------
    //
    //  Global Variables
    //
    //-------------------------------------------------------------------------
    
    protected var _imageViews:Vector.<ImageView>
    private var imageViewIndex:int
    public var enableLoading:Boolean
	public var maxImageViews:int
    
    //-------------------------------------------------------------------------
    //
    //  Constructor
    //
    //-------------------------------------------------------------------------
    
    public function BaseBackgroundView()
    {
        super()
		_imageViews = new Vector.<ImageView>
		enableLoading = true
		maxImageViews = 0
    }
    //-------------------------------------------------------------------------
    //
    //  Overriden methods
    //
    //-------------------------------------------------------------------------
    
    public override function build():void
    {
    }
    
    public override function dispose():void
    {
        _imageViews = null
    }
    
    //-------------------------------------------------------------------------
    //
    //  Private methods
    //
    //-------------------------------------------------------------------------
    
    /**
    * Ladet alle imageView-Objekte in der imageViews, die noch nicht geladen 
    * wurden. Das Laden erflogt hintereinander.
    */
    private function loadImageView():void
    {
        if(imageViewIndex < _imageViews.length)
        {
	        var imageView:ImageView = _imageViews[imageViewIndex]
            //Falls das Bild schon geladen wurde, dan lade das naechste
            if(imageView.loaded)
            {
                imageViewIndex++
                loadImageView()
            }
            else
            {
                imageView.addEventListener(ProgressEvent.PROGRESS, 
                    imageView_progressEvent)
                imageView.addEventListener(Event.COMPLETE,
                    imageView_completeHandler)
                imageView.build()
            }
        }
    }
    
    //-------------------------------------------------------------------------
    //
    //  Public methods
    //
    //-------------------------------------------------------------------------
    
    public function addImage(image:Image):void
    {
		if(maxImageViews == 0 || maxImageViews > _imageViews.length)
		{
	        var imageView:ImageView = new ImageView(image)
	        _imageViews.push(imageView)
		}
    }

    public function preloadImageViews():void
    {
        if(enableLoading)
        {
            enableLoading = false
            imageViewIndex = 0
            loadImageView()
        }
    }
    
    public function swapImageViews(firstImageView:ImageView, 
        secondImageView:ImageView):void
    {
        var tempImageView:ImageView
        tempImageView = firstImageView
        firstImageView = secondImageView
        secondImageView = tempImageView
    }
    
    //-------------------------------------------------------------------------
    //
    //  Event handlers
    //
    //-------------------------------------------------------------------------
    
    private function imageView_progressEvent(event:ProgressEvent):void
    {
        dispatchEvent(event)
    }
    
    private function imageView_completeHandler(event:Event):void
    {
        imageViewIndex++
        loadImageView()
		var bubbleEvent:BackgroundViewEvent = new BackgroundViewEvent(
			BackgroundViewEvent.COMPLETE, false, false,
			event.target as ImageView)
		dispatchEvent(bubbleEvent)

        //Falls alle imageView-Objekte fertig geladen wurden.        
        if(imageViewIndex == _imageViews.length)
        {
            dispatchEvent(new Event(COMPLETE_ALL))
            enableLoading = true   
        }
    }
    
    //-------------------------------------------------------------------------
    //
    //  Properties
    //
    //-------------------------------------------------------------------------
    
    public function get imageViews():Vector.<ImageView>
    {
        return _imageViews
    }
	
	public function get currentImageView():ImageView
	{
		var targetImageView:ImageView
		
		if(imageViews.length > 0)
			targetImageView = imageViews[0]
				
		return targetImageView
	}
}
}