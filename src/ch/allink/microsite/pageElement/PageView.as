package ch.allink.microsite.pageElement
{
import ch.allink.microsite.cmsConnector.ModelFactory;
import ch.allink.microsite.cmsConnector.ModelRequest;
import ch.allink.microsite.core.AbstractView;
import ch.allink.microsite.events.ResultEvent;
import ch.allink.microsite.imageElement.Image;
import ch.allink.microsite.imageElement.ImageView;
import ch.allink.microsite.sectionElement.Section;
import ch.allink.microsite.sectionElement.SectionView;
import ch.allink.microsite.widgets.DisplayFormatter;

import flash.text.TextField;

public class PageView extends AbstractView
{
	//-------------------------------------------------------------------------
	//
	//  Constants
	//
	//-------------------------------------------------------------------------
	
	private const xmlPath:String = "./?do=xml&mode=page&pageID="
	private const TEXT_ONLY:String = "textonly"
	private const TEXT_IMAGE_LEFT:String = "textimageleft"
	private const IMAGE:String = "image"
	private const GALLERY:String = "gallery"
		
	//-------------------------------------------------------------------------
	//
	//  Variables
	//
	//-------------------------------------------------------------------------
	
	private var sectionViews:Vector.<SectionView>
	private var sections:Array
	private var _displayFormatter:DisplayFormatter
	
	public var page:Page
	public var customSectionViewOperation:Function
	
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
		clearSectionViews()
	}
	
	//-------------------------------------------------------------------------
	//
	//  Private methods
	//
	//-------------------------------------------------------------------------
	
	private function formatSectionView(sectionView:SectionView,
									   prevSectionView:SectionView):void
	{
		if(displayFormatter)
		{
			if(prevSectionView)
			{
				var prevSection:Section = prevSectionView.section
				var extraSpacing:Number = 0
				if(prevSection.files)
				{
					var image:Image = prevSection.files[0]
					extraSpacing = image.height
				}
				sectionView.y = prevSectionView.y + prevSectionView.height +
								displayFormatter.sectionVerticalSpacing +
								extraSpacing
			}
			else
			{
				sectionView.y = 0
			}
		}
	}
	
	private function clearSectionViews():void
	{
		for each(var sectionView:SectionView in sectionViews)
		{
			if(this.contains(sectionView))
				this.removeChild(sectionView)
			sectionView.dispose()
			sectionView = null
		}
	}
	
	private function buildImage(sectionView:SectionView):void
	{
		var section:Section = sectionView.section
		var image:Image = section.files[0]
		var imageView:ImageView = new ImageView(image)
		imageView.buildByFileID(image.uniqueid)
		sectionView.addChild(imageView)
		formatImageTextLeft(image, sectionView.textField)
	}
	
	
	private function formatImageTextLeft(image:Image,
										 textField:TextField):void
	{
		textField.x = image.width + displayFormatter.sectionHorizontalSpacing
	}
	
	//-------------------------------------------------------------------------
	//
	//  Public methods
	//
	//-------------------------------------------------------------------------
	
	public function buildByPageID(pageID:int):void
	{
		clearSectionViews()
		var modelFactory:ModelFactory = new ModelFactory()
		var modelRequest:ModelRequest = modelFactory.load(Page, xmlPath+pageID,
			ModelFactory.TYPE_MODEL)
		modelRequest.addEventListener(ResultEvent.DATA_LOADED,
			modelRequest_dataLoadedHandler)
	}
	
	public function buildSectionViews(page:Page):Vector.<SectionView>
	{
		clearSectionViews()
		sections = page.sections
		var prevSectionView:SectionView
		sectionViews = new Vector.<SectionView>
		for each(var section:Section in sections)
		{
			var sectionView:SectionView = new SectionView(section)
			sectionView.build()
			this.addChild(sectionView)
			sectionView.displayFormatter = displayFormatter
			sectionViews.push(sectionView)
			
			if(section.type == TEXT_IMAGE_LEFT || section.type == IMAGE)
				buildImage(sectionView)
			
			if(customSectionViewOperation != null)
				sectionView = customSectionViewOperation(sectionView)
			
			formatSectionView(sectionView, prevSectionView)
			prevSectionView = sectionView
		}
		return sectionViews
	}
	
	//-------------------------------------------------------------------------
	//
	//  Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function modelRequest_dataLoadedHandler(event:ResultEvent):void
	{
		page = event.model as Page
		sectionViews = buildSectionViews(page)
		dispatchEvent(event)
	}
	
	//-------------------------------------------------------------------------
	//
	//  Properties
	//
	//-------------------------------------------------------------------------
	
	public function set displayFormatter(value:DisplayFormatter):void
	{
		_displayFormatter = value
	}
	
	public function get displayFormatter():DisplayFormatter
	{
		return _displayFormatter
	}
}
}