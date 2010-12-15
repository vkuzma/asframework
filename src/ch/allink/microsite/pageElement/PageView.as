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
	
	private var _operation:IPageOperation
	public var page:Page
	
	//-------------------------------------------------------------------------
	//
	//  Constructor
	//
	//-------------------------------------------------------------------------
	
	public function PageView()
	{
		super()
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
		var modelFactory:ModelFactory = new ModelFactory()
		var modelRequest:ModelRequest = modelFactory.load(Page, 
			CMSXmlPath.getPagePathByURL(url.slice(1)),	
			ModelFactory.TYPE_MODEL)
		modelRequest.addEventListener(ResultEvent.DATA_LOADED,
			modelRequest_dataLoadedHandler)
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
	
	//-------------------------------------------------------------------------
	//
	//  Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function modelRequest_dataLoadedHandler(event:ResultEvent):void
	{
		page = event.model as Page
		buildByPage(page)
		dispatchEvent(event)
	}
	
	//-------------------------------------------------------------------------
	//
	//  Properties
	//
	//-------------------------------------------------------------------------
	
	public function set operation(value:IPageOperation):void
	{
		_operation = value
		_operation.targetView = this
	}
	
	public function get operation():IPageOperation
	{
		return _operation
	}
	
	private function get sectionViews():Vector.<SectionView>
	{
		return operation.sectionViews
	}
}
}