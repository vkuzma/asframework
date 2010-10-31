package ch.allink.micrositeframework.widgets
{
    import ch.allink.micrositeframework.cmsview.ImageView;
    import ch.allink.micrositeframework.operation.BaseOperation;
    import ch.allink.micrositeframework.operation.IOperation;
    
    import flash.events.Event;

/**
 * Verwalten von Hintergrundbildern.
 * @author Vladimir Kuzma
 * @date 30.10.2010
 */

public class SimpleBackgroundView extends BaseBackgroundView
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
        this.addEventListener(Event.COMPLETE, completeHandler)
    }
    
    //-------------------------------------------------------------------------
    //
    //  Private methods
    //
    //-------------------------------------------------------------------------
    
    private function initOperation(operation:IOperation):void
    {
        operation.targetSprite = this
        operation.imageViews = imageViews
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
        _operation.resize(sourceHeight, sourceWidth)
    }
    
    //-------------------------------------------------------------------------
    //
    //  Event Handlers
    //
    //-------------------------------------------------------------------------
    
    private function completeHandler(event:Event):void
    {
        var imageView:ImageView = event.target as ImageView
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