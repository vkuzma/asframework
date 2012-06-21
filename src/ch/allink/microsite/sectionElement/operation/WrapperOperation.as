package ch.allink.microsite.sectionElement.operation
{
import ch.allink.microsite.pageElement.PageFormatter;
import ch.allink.microsite.sectionElement.SectionView;
import ch.allink.microsite.sectionElement.sectionType.WrapperSection;

import flash.utils.Dictionary;

import flashx.textLayout.operations.CopyOperation;

/**
 * @author vkuzma
 * @date Jun 26, 2011
 **/
public class WrapperOperation implements ISectionOperation
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private static var operations:Dictionary = new Dictionary()
	private var currentOperation:Object
	private var _targetView:SectionView
	private var model:Object
	private var _pageFormatter:PageFormatter
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function WrapperOperation()
	{
	}
	
	public function build():void
	{
		currentOperation.build()
	}
	
	public function resize(sourceWidth:Number, sourceHeight:Number):void
	{
		currentOperation.resize(sourceWidth, sourceHeight)
	}
	
	public function set targetView(value:SectionView):void
	{
		_targetView = value
		model = _targetView.section
		currentOperation = operations[model.type]
		currentOperation.targetView = value
	}
	
	public function get targetView():SectionView
	{
		return _targetView
	}
	
	public function set pageFormatter(value:PageFormatter):void
	{
		_pageFormatter = value
		currentOperation.pageFormatter = value
	}
	
	public function get pageFormatter():PageFormatter
	{
		return _pageFormatter
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public static function addOperation(type:String, operation:Class):void
	{
		operations[type] = new operation()
	}
	
	
	public function dispose():void
	{
		currentOperation.dispose()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function get contentType():String
	{
		return ""
	}
	
}
}