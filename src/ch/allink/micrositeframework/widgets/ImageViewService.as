package ch.allink.micrositeframework.widgets
{
import ch.allink.micrositeframework.cmsview.ImageView;
import ch.allink.micrositeframework.events.ImageViewServiceEvent;
import ch.allink.micrositeframework.view.AbstractView;

import flash.events.Event;
import flash.events.ProgressEvent;

/**
 * Grundfunktionen zum Verwalten von ImageView-Instanzen.
 * @author Vladimir Kuzma
 * @date 30.10.2010
 */

[Event (name='imageViewServicecomplete', 
	type="ch.allink.micrositeframework.events.ImageViewServiceEvent")]
[Event (name='imageViewServicecompleteAll', 
	type="ch.allink.micrositeframework.events.ImageViewServiceEvent")]
[Event (name='imageViewServiceProgress', 
	type="ch.allink.micrositeframework.events.ImageViewServiceEvent")]

public class ImageViewService extends AbstractView
{
    //-------------------------------------------------------------------------
    //
    //  Global Variables
    //
    //-------------------------------------------------------------------------
    
	private var _imageViews:Vector.<ImageView>
    private var imageViewIndex:int
	private var _enableLoading:Boolean
	//TODO kommt raus!
	public var maxImageViews:int
    
    //-------------------------------------------------------------------------
    //
    //  Constructor
    //
    //-------------------------------------------------------------------------
    
    public function ImageViewService()
    {
        super()
		_imageViews = new Vector.<ImageView>
		_enableLoading = true
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
    
	/**
	 * Entfernt alle ImageView-Instanzen von der DisplayList und lässt sie entfernen.
	 **/
    public override function dispose():void
    {
		if(_imageViews)
		{
			for each(var imageView:ImageView in _imageViews)
			{
				if(imageView)
				{
					imageView.dispose()
					if(this.contains(imageView))
						this.removeChild(imageView)
				}
			}
		}
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
    **/
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
                    imageView_progressHandler)
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
    
	/**
	 * Erstellt aus dem Image eine ImageView und fügt diese der Liste (imageViews)
	 * hinzu, die über preload() vorgeladen werden kann. 
	 **/
    public function addImageView(imageView:ImageView):void
    {
		if(maxImageViews == 0 || maxImageViews > _imageViews.length)
	        _imageViews.push(imageView)
    }

	/**
	 * Ladet alle von addImage() erstellte ImageView-Instanzen, die noch nicht
	 * geladen wurden.
	 * Der Ladevorgane finden nacheinander statt.
	 **/
    public function preloadImageViews():void
    {
        if(_enableLoading)
        {
            _enableLoading = false
            imageViewIndex = 0
            loadImageView()
        }
    }
    
    //-------------------------------------------------------------------------
    //
    //  Event handlers
    //
    //-------------------------------------------------------------------------
    
    private function imageView_progressHandler(event:ProgressEvent):void
    {
		var imageViewServiceEvent:ImageViewServiceEvent = 
			new ImageViewServiceEvent(ImageViewServiceEvent.PROGRESS,
				event.target as ImageView, _imageViews, event.bytesLoaded,
				event.bytesTotal)
			
		dispatchEvent(imageViewServiceEvent)
    }
    
    private function imageView_completeHandler(event:Event):void
    {
        imageViewIndex++
        loadImageView()
		var imageViewServiceEventComplete:ImageViewServiceEvent =  
			new ImageViewServiceEvent(ImageViewServiceEvent.COMPLETE,
				event.target as ImageView, _imageViews)
		dispatchEvent(imageViewServiceEventComplete)

        //Falls alle imageView-Objekte fertig geladen wurden.        
        if(imageViewIndex == _imageViews.length)
        {
            _enableLoading = true   
				
			var imageViewServiceEventCompleteAll:ImageViewServiceEvent = 
				new ImageViewServiceEvent(ImageViewServiceEvent.COMPLETE_ALL,
					event.target as ImageView, _imageViews)
            dispatchEvent(imageViewServiceEventCompleteAll)
        }
    }
    
    //-------------------------------------------------------------------------
    //
    //  Properties
    //
    //-------------------------------------------------------------------------
    
	/**
	 * Ein Vector mit allen ImageView-Instanzen.
	 **/
    public function get imageViews():Vector.<ImageView>
    {
        return _imageViews
    }
	
	/**
	 * Bei True ist ein Ladevorgang mit preload() erlaubt.
	 * Bei False wird eine Ladevorgang mit preload() ignoriert.
	 **/
	public function get enableLoading():Boolean
	{
		return _enableLoading
	}
}
}