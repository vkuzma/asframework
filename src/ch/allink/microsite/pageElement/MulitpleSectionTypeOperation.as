package ch.allink.microsite.pageElement
{
import ch.allink.microsite.core.AbstractView;
import ch.allink.microsite.sectionElement.ISectionOperation;
import ch.allink.microsite.sectionElement.Section;
import ch.allink.microsite.sectionElement.SectionView;

public final class MulitpleSectionTypeOperation implements IPageOperation
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _targetView:PageView
	private var sections:Array
	private var _sectionViews:Vector.<SectionView>
	private var sectionOperations:ISectionOperation
	private var prevSectionView:SectionView
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function MulitpleSectionTypeOperation()
	{
		_sectionViews = new Vector.<SectionView>
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function layout(prevSectionView:SectionView, 
							sectionView:SectionView):void
	{
		if(prevSectionView)
			sectionView.y = prevSectionView.y + prevSectionView.operation.height
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function dispose():void
	{
		
	}
	
	public function buildSectionViews(section:Section, i:int, sections:Array)
		:void
	{
		var sectionOperation:ISectionOperation = 
			getOperationByFormat(section.format)
		var sectionView:SectionView = new SectionView(section)
		sectionView.operation = sectionOperation
		sectionView.build()
		targetView.addChild(sectionView)
		layout(prevSectionView, sectionView)
		prevSectionView = sectionView
		_sectionViews.push(sectionView)
	}
	
	public function getOperationByFormat(format:String):ISectionOperation
	{
		var operationByFormat:ISectionOperation
		for each(var operation:ISectionOperation in sectionOperations)
		{
			if(operation.FORMAT == format)
				operationByFormat = operation
		}
		return operationByFormat
	}
	
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function set targetView(value:AbstractView):void
	{
		_targetView = value as PageView
	}
	
	public function get targetView():AbstractView
	{
		return _targetView
	}
	
	public function get sectionViews():Vector.<SectionView>
	{
		return _sectionViews
	}
}
}