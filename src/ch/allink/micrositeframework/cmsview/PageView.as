package ch.allink.micrositeframework.cmsview
{
import ch.allink.micrositeframework.cmsmodel.Page;
import ch.allink.micrositeframework.net.ModelFactory;
import ch.allink.micrositeframework.net.ModelRequest;
import ch.allink.micrositeframework.net.ResultEvent;
import ch.allink.micrositeframework.view.AbstractView;

import mx.events.ResizeEvent;

import org.osmf.media.MediaFactory;

public class PageView extends AbstractView
{
	//-------------------------------------------------------------------------
	//
	//  Variables
	//
	//-------------------------------------------------------------------------
	
	private const xmlPath:String = "./?do=xml&mode=page&pageID="
		
	//-------------------------------------------------------------------------
	//
	//  Variables
	//
	//-------------------------------------------------------------------------
	
	public var sectionView:Vector.<SectionView>
	
	//-------------------------------------------------------------------------
	//
	//  Constructor
	//
	//-------------------------------------------------------------------------
	
	public function PageView()
	{
		super()
	}
	
	//-------------------------------------------------------------------------
	//
	//  Private methods
	//
	//-------------------------------------------------------------------------
	
	//-------------------------------------------------------------------------
	//
	//  Public methods
	//
	//-------------------------------------------------------------------------
	
	public function buildByPageID(pageID:int):void
	{
		var modelFactory:ModelFactory = new ModelFactory()
		var modelRequest:ModelRequest = modelFactory.load(Page, xmlPath+pageID,
			ModelFactory.TYPE_MODEL)
		modelRequest.addEventListener(ResultEvent.DATA_LOADED,
			modelRequest_dataLoadedHandler)
			
	}
	
	//-------------------------------------------------------------------------
	//
	//  Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function modelRequest_dataLoadedHandler(event:ResultEvent):void
	{
		trace("OK")
		trace(event.collection[0])
	}
}
}