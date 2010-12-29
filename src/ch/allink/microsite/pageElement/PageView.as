package ch.allink.microsite.pageElement
{
import ch.allink.microsite.cmsConnector.CMSXmlPath;
import ch.allink.microsite.cmsConnector.ModelFactory;
import ch.allink.microsite.cmsConnector.ModelRequest;
import ch.allink.microsite.core.AbstractView;
import ch.allink.microsite.events.ResultEvent;
import ch.allink.microsite.sectionElement.SectionView;

public class PageView extends AbstractView
{
	//-------------------------------------------------------------------------
	//
	//  Variables
	//
	//-------------------------------------------------------------------------
	
	public var page:Page
	private var _operation:IPageOperation
	private var _isLoading:Boolean
	private var modelRequest:ModelRequest
	
	//-------------------------------------------------------------------------
	//
	//  Constructor
	//
	//-------------------------------------------------------------------------
	
	public function PageView()
	{
		super()
		_isLoading = false
		build()
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
		operation.dispose()
	}
	
	//-------------------------------------------------------------------------
	//
	//  Private methods
	//
	//-------------------------------------------------------------------------
	
	private function clearSectionViews(sectionViews:Vector.<SectionView>):void
	{
		for each(var sectionView:SectionView in sectionViews)
		{
			if(sectionView)
			{
				if(contains(sectionView))
					removeChild(sectionView)
				sectionView.dispose()
			}
		}
		sectionViews = null
	}
	
	//-------------------------------------------------------------------------
	//
	//  Public methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Loads a Page instance by the pageid and will be buildded by the loaded Page instance.
	 **/
	public function buildPageByURL(url:String):void
	{ 
		if(isLoading) stopLoading()
		var modelFactory:ModelFactory = new ModelFactory()
		modelRequest = modelFactory.load(Page, CMSXmlPath.getPagePathByURL(url),	
										 ModelFactory.TYPE_MODEL)
		modelRequest.addEventListener(ResultEvent.DATA_LOADED,
			modelRequest_dataLoadedHandler)
		_isLoading = true
	}
	
	/**
	 * Will be builded by the Page instance.
	 **/	
	public function buildByPage(page:Page):void
	{
		if(sectionViews)
			clearSectionViews(sectionViews)
		var sections:Array = page.sections
		operation.buildSectionViews(sections)
		operation.formatSectionViews()
	}
	
	public function stopLoading():void
	{
		modelRequest.dispose()
	}
	
	//-------------------------------------------------------------------------
	//
	//  Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function modelRequest_dataLoadedHandler(event:ResultEvent):void
	{
		_isLoading = false
		page = event.model as Page
		buildByPage(page)
		dispatchEvent(event)
	}
	
	//-------------------------------------------------------------------------
	//
	//  Properties
	//
	//-------------------------------------------------------------------------
	
	public function get sectionViews():Vector.<SectionView>
	{
		return operation.sectionViews
	}
	
	public function set operation(value:IPageOperation):void
	{
		_operation = value
		_operation.targetView = this
	}
	
	public function get operation():IPageOperation
	{
		return _operation
	}
	
	
	public function get isLoading():Boolean
	{
		return _isLoading
	}
}
}