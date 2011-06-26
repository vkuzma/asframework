package ch.allink.microsite.pageElement
{
import ch.allink.microsite.sectionElement.SectionContentTypes;
import ch.allink.microsite.sectionElement.SectionView;
import ch.allink.microsite.sectionElement.operation.ISectionOperation;
import ch.allink.microsite.sectionElement.sectionType.TextSection;

/**
 * @author Vladimir Kuzma
 * @date 03.12.2010
 */
public final class MultipleSectionTypeOperation implements IPageOperation
{
	//-------------------------------------------------------------------------
	//
	// Variables
	//
	//-------------------------------------------------------------------------
	
	private var _targetView:PageView
	private var _pageFormatter:PageFormatter
	private var _sectionViews:Vector.<SectionView>
	private var sectionOperations:Vector.<ISectionOperation>
	
	//-------------------------------------------------------------------------
	//
	// Constructor
	//
	//-------------------------------------------------------------------------
	
	public function MultipleSectionTypeOperation():void
	{
		sectionOperations = new Vector.<ISectionOperation>
	}
	
	//-------------------------------------------------------------------------
	//
	// Private methods
	//
	//-------------------------------------------------------------------------
	
	private function missingSectionOperationError(type:String):void
	{
		var error:Error = new Error()
		error.name = "allink Error: Error #XXXX"
		error.message = "A SectionOperation with type \""+type+"\" doesen't exist"
		throw error
	}
	
	private function getSectionViewsByRegion(region:String):Vector.<SectionView>
	{
		var sectionViewsByRegion:Vector.<SectionView> = new Vector.<SectionView>
		for each(var sectionView:SectionView in sectionViews)
		{
			var section:TextSection = sectionView.section
			if(section.region == region) sectionViewsByRegion.push(sectionView)
		}
		return sectionViewsByRegion
	}
	
	private function formatSectionViewsInRegion(
		sectionViews:Vector.<SectionView>):void
	{
		var prevSectionView:SectionView
		for each(var sectionView:SectionView in sectionViews)
		{
			if(prevSectionView)
				sectionView.y = Math.round(prevSectionView.height +
					prevSectionView.y +
					pageFormatter.sectionVerticalSpacing)
			else
				sectionView.y = 0
			prevSectionView = sectionView
		}
	}
	
	//-------------------------------------------------------------------------
	//
	// Public methods
	//
	//-------------------------------------------------------------------------
	
	public function dispose():void
	{
	}
	
	/**
	 * Builds a collection of SectionView instances.
	 */
	public function buildSectionViews(sections:Array):void
	{
		dispose()
		_sectionViews = new Vector.<SectionView>
		for each(var section:TextSection in sections)
		{
			var sectionOperationClass:Class = 
				SectionContentTypes.getContentTypeByType(section.type).contentOperation
			var sectionOperation:ISectionOperation = new sectionOperationClass()
			if(!sectionOperation) missingSectionOperationError(section.type)
			
			sectionOperations.push(sectionOperation)
			var sectionView:SectionView = new SectionView(section)
			
			sectionView.operation = sectionOperation
			sectionOperation.pageFormatter = pageFormatter
			sectionView.build()
			
			targetView.addRegion(section.region)
			targetView.addToRegion(section.region, sectionView)
			
			sectionViews.push(sectionView)
		}
	}
	
	/**
	 * Sets the position of all SectionView instances.
	 */
	//TODO: The SectionView instances should be formated by the DisplayFormatter
	public function formatSectionViews():void
	{
		for (var region:String in targetView.regions)
		{
			var sectionViewsInRegion:Vector.<SectionView> =
				getSectionViewsByRegion(region)
			//TODO throw error if sectionViewsInRegion is null
			if(!sectionViewsInRegion)
			{
				trace("Allink error: " + "Region " + region + " doesn't exist.")
				continue
			}
			formatSectionViewsInRegion(sectionViewsInRegion)
		}
	}
	
	/**
	 * Resize
	 */
	public function resize(sourceWidth:Number, sourceHeight:Number):void
	{
		for each(var sectionOperation:ISectionOperation in sectionOperations)
		sectionOperation.resize(sourceWidth, sourceHeight)
	}
	
	//-------------------------------------------------------------------------
	//
	// Properties
	//
	//-------------------------------------------------------------------------
	
	/**
	 * The PageView instance, that will be modified.
	 */
	public function set targetView(value:PageView):void
	{
		_targetView = value
	}
	
	public function get targetView():PageView
	{
		return _targetView
	}
	
	public function get sectionViews():Vector.<SectionView>
	{
		return _sectionViews
	}
	
	public function set pageFormatter(value:PageFormatter):void
	{
		_pageFormatter = value
	}
	
	public function get pageFormatter():PageFormatter
	{
		if(!_pageFormatter) _pageFormatter = new PageFormatter()
		return _pageFormatter
	}
}
}