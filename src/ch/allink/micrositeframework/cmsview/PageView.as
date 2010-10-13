package ch.allink.micrositeframework.cmsview
{
import ch.allink.micrositeframework.cmsmodel.DisplayFormatter;
import ch.allink.micrositeframework.cmsmodel.Image;
import ch.allink.micrositeframework.cmsmodel.Page;
import ch.allink.micrositeframework.cmsmodel.Section;
import ch.allink.micrositeframework.net.ModelFactory;
import ch.allink.micrositeframework.net.ModelRequest;
import ch.allink.micrositeframework.net.ResultEvent;
import ch.allink.micrositeframework.view.AbstractView;

import flash.text.TextField;
import flash.text.TextFormat;

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
	private var page:Page
	private var _displayFormatter:DisplayFormatter
	
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
	
	private function buildSectionViews(page:Page):Vector.<SectionView>
	{
		sections = page.sections
		var prevSectionView:SectionView
		sectionViews = new Vector.<SectionView>
		for each(var section:Section in sections)
		{
			var sectionView:SectionView = new SectionView(section)
			this.addChild(sectionView)
			sectionView.displayFormatter = displayFormatter
			formatSectionView(sectionView, prevSectionView)
			prevSectionView = sectionView
			sectionViews.push(sectionView)
			
			if(section.type == TEXT_IMAGE_LEFT)
				buildTextImageLeft(sectionView)
		}
		return sectionViews
	}
	
	private function formatSectionView(sectionView:SectionView,
									   prevSectionView:SectionView):void
	{
		if(displayFormatter)
		{
			if(prevSectionView != null)
			{
				var prevSection:Section = prevSectionView.section
				var extraSpacing:Number = 0
				if(prevSection.type == TEXT_IMAGE_LEFT)
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
			this.removeChild(sectionView)
			sectionView.dispose()
			sectionView = null
		}
	}
	
	private function buildTextImageLeft(sectionView:SectionView):void
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
	
	//-------------------------------------------------------------------------
	//
	//  Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function modelRequest_dataLoadedHandler(event:ResultEvent):void
	{
		page = event.model as Page
		sectionViews = buildSectionViews(page)
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