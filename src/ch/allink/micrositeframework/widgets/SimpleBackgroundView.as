package ch.allink.micrositeframework.widgets
{
    import ch.allink.micrositeframework.cmsview.ImageView;
    import ch.allink.micrositeframework.operation.IOperation;

/**
 * Verwalten von Hintergrundbildern.
 * @author Vladimir Kuzma
 * @date 30.10.2010
 */

public class SimpleBackgroundView extends ImageViewService
{
    //-------------------------------------------------------------------------
    //
    //  Global Variables
    //
    //-------------------------------------------------------------------------
    
    private var _operation:IOperation
    
    //-------------------------------------------------------------------------
    //
    //  Constructor
    //
    //-------------------------------------------------------------------------
    
    public function SimpleBackgroundView()
    {
        super()
        this.addEventListener(ImageViewServiceEvent.COMPLETE, completeHandler)
    }
    
    //-------------------------------------------------------------------------
    //
    //  Private methods
    //
    //-------------------------------------------------------------------------
    
    private function initOperation(operation:IOperation):void
    {
        operation.targetSprite = this
        operation.imageViews = this.imageViews
    }
	
    //-------------------------------------------------------------------------
    //
    //  Overriden methods
    //
    //-------------------------------------------------------------------------
	
    /**
    * Loaded die mit addImage(image) hinzugefügten Bildermodelle nur mit Freigeabe
	* der enableClick Variable.
    */
	override public function preloadImageViews():void
	{
		if(_operation.enableClick)
			super.preloadImageViews()	
	}
	
    //-------------------------------------------------------------------------
    //
    //  Public methods
    //
    //-------------------------------------------------------------------------
    
    /**
    * Einblenden der ersten imageView (wird nur einmal ausgefuehrt)
    */
    public function displayFirstImageView():void
    {
        _operation.displayFirstImageView()
    }
    
    /**
     * Einblenden der nächsten imageView und ausblenden der ersten imageView
     */
    public function displayNextImageView():void
    {
        _operation.displayNextImageView(imageViews[0], imageViews[1])
    }
    
    /**
     * Resize methode
     */
    public function resize(sourceHeight:Number, sourceWidth:Number):void
    {
		if(_operation)
        	_operation.resize(sourceHeight, sourceWidth)
    }
    
    //-------------------------------------------------------------------------
    //
    //  Event Handlers
    //
    //-------------------------------------------------------------------------
    
    private function completeHandler(event:ImageViewServiceEvent):void
    {
        var imageView:ImageView = event.imageView
        _operation.initImageView(imageView)
    }
    
    //-------------------------------------------------------------------------
    //
    //  Properties
    //
    //-------------------------------------------------------------------------
    
    public function set operation(value:IOperation):void
    {
        _operation = value
        initOperation(_operation)
    }
}
}