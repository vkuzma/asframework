package ch.allink.microsite.pageElement
{
import ch.allink.microsite.sectionElement.Section;
import ch.allink.microsite.sectionElement.SectionView;
import ch.allink.microsite.sectionElement.operation.ISectionOperation;
import ch.allink.microsite.sectionElement.operation.TextImageOperation;
import ch.allink.microsite.sectionElement.operation.TextOperation;

/**
 * @author Vladimir Kuzma
 * @date 03.12.2010
 */
public final class MulitpleSectionTypeOperation implements IPageOperation
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _targetView:PageView
	private var _pageFormatter:PageFormatter
	private var _sectionViews:Vector.<SectionView>
	private var sectionOperationClasses:Vector.<Class>
	private var sectionOperations:Vector.<ISectionOperation>
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function MulitpleSectionTypeOperation()
	{
		sectionOperationClasses = new Vector.<Class>
		sectionOperationClasses.push(TextImageOperation)
		sectionOperationClasses.push(TextOperation)
		sectionOperations = new Vector.<ISectionOperation>
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function missingSectionOperationError(type:String):void
	{
		var error:Error = new Error()
		error.name = "allink Error: Error #XXXX"
		error.message = "A SectionOperation with type \""+type+"\" doesen't exist"
		throw error
	}
	
	/**
	 * Returns an instance of a Class with the desired format.
	 * @format Format of the Section, also known as contenttpe in FeinCMS.
	 */
	private function getOperationByFormat(format:String):ISectionOperation
	{
		var operationByFormat:ISectionOperation
		for each(var operation:Class in sectionOperationClasses)
		{
			if(operation.FORMAT == format)
			{
				operationByFormat = new operation()
				break
			}
		}
		return operationByFormat
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
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
		for each(var section:Section in sections)
		{
			var sectionOperation:ISectionOperation = 
				getOperationByFormat(section.type)
			if(!sectionOperation) missingSectionOperationError(section.type)
				
			sectionOperations.push(sectionOperation)
			sectionOperation.pageFormatter = pageFormatter
			var sectionView:SectionView = new SectionView(section)
			targetView.addChild(sectionView)
			sectionView.operation = sectionOperation
			sectionView.build()
			targetView.addChild(sectionView)
			_sectionViews.push(sectionView)
		}
	}
	
	/**
	 * Sets the position of all SectionView instances.
	 */
	//TODO: The SectionView instances should be formated by the DisplayFormatter
	public function formatSectionViews():void
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
	
	/**
	 * Resize
	 */
	public function resize(sourceWidth:Number, sourceHeight:Number):void
	{
		for each(var sectionOperation:ISectionOperation in sectionOperations)
			sectionOperation.resize(sourceWidth, sourceHeight)
	}
	
	/**
	 * Adds a contenttype class to the contenttype collection.
	 */
	public function addContentType(contentType:Class):void
	{
		sectionOperationClasses.push(contentType)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
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
		if(!_pageFormatter)
			_pageFormatter = new PageFormatter()
		return _pageFormatter
	}
}
}