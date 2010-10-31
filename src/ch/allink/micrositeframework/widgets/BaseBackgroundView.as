package ch.allink.micrositeframework.widgets
{
import ch.allink.micrositeframework.cmsmodel.Image;
import ch.allink.micrositeframework.cmsview.ImageView;
import ch.allink.micrositeframework.view.AbstractView;

import flash.events.Event;
import flash.events.ProgressEvent;

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
    private var enableLoading:Boolean
    
    //-------------------------------------------------------------------------
    //
    //  Constructor
    //
    //-------------------------------------------------------------------------
    
    public function BaseBackgroundView()
    {
        super()
    }
    //-------------------------------------------------------------------------
    //
    //  Overriden methods
    //
    //-------------------------------------------------------------------------
    
    public override function build():void
    {
        _imageViews = new Vector.<ImageView>
        enableLoading = true
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
        var imageView:ImageView = new ImageView(image)
        _imageViews.push(imageView)
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
           
        dispatchEvent(event)

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
}
}