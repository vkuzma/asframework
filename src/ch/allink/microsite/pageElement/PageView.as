package ch.allink.microsite.pageElement
{
import ch.allink.microsite.cmsConnector.CMSXmlPath;
import ch.allink.microsite.cmsConnector.ModelFactory;
import ch.allink.microsite.core.AbstractView;
import ch.allink.microsite.events.ResultEvent;
import ch.allink.microsite.sectionElement.SectionView;
import ch.allink.microsite.sectionElement.sectionType.TextSection;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.utils.Dictionary;

public class PageView extends AbstractView
{
	//-------------------------------------------------------------------------
	//
	//  Variables
	//
	//-------------------------------------------------------------------------
	
	public var page:Page
	public var regions:Dictionary
	private var modelFactory:ModelFactory 
	private var _operation:IPageOperation
	private var _isLoading:Boolean
	
	//-------------------------------------------------------------------------
	//
	//  Constructor
	//
	//-------------------------------------------------------------------------
	
	public function PageView(operation:IPageOperation = null)
	{
		super()
		if(operation) this.operation = operation
	}
	
	//-------------------------------------------------------------------------
	//
	//  Overriden methods
	//
	//-------------------------------------------------------------------------
	
	public override function build():void
	{
		_isLoading = false
		regions = new Dictionary()
	}
	
	
	public override function dispose():void
	{
		clearSectionViews(sectionViews)
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
			var section:TextSection = sectionView.section
			var regionContainer:Sprite = regionByName(section.region)
			if(regionContainer.contains(sectionView))
				regionContainer.removeChild(sectionView)
			sectionView.dispose()
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
	public function buildPageByURL(url:String, modelClass:Class = null):void
	{
		if(!modelClass) modelClass = Page
		if(isLoading) stopLoading()
		modelFactory = new ModelFactory()
		modelFactory.addEventListener(ResultEvent.DATA_LOADED, modelRequest_dataLoadedHandler)
		modelFactory.load(modelClass, CMSXmlPath.getPagePathByURL(url),	ModelFactory.TYPE_MODEL)
		_isLoading = true
	}
	
	/**
	 * Will be builded by the Page instance.
	 **/	
	public function buildByPage(page:Page):void
	{
		if(sectionViews) clearSectionViews(sectionViews)
		var sections:Array = page.sections
 		operation.buildSectionViews(sections)
		operation.formatSectionViews()
			
	}
	
	public function stopLoading():void
	{
		modelFactory.stopLoading()
	}
	
	/**
	 * Adds a new regioncontainer.
	 **/
	public function addRegion(region:String):void
	{
		if(!regions[region])
		{
			var regionContainer:Sprite = new Sprite()
			addChild(regionContainer)
			regions[region] = regionContainer
		}
	}
	
	/**
	 * Adds a displayObject to a region by name.
	 **/
	public function addToRegion(name:String, displayObject:DisplayObject):void
	{
		regionByName(name).addChild(displayObject)
	}
	
	/**
	 * Returns a regioncontainer bei regionname.
	 **/
	public function regionByName(name:String):Sprite
	{
		if(!regions[name]) addRegion(name)
		return regions[name]
	}
	
	//-------------------------------------------------------------------------
	//
	//  Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function modelRequest_dataLoadedHandler(event:ResultEvent):void
	{
		dispose()
		build()
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
		if(!_operation) throw new Error("No operation available, PageView can be only used with a IPageOperation!")
		return _operation
	}
	
	public function get isLoading():Boolean
	{
		return _isLoading
	}
}
}