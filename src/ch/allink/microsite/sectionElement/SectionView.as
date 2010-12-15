package ch.allink.microsite.sectionElement
{
import ch.allink.microsite.core.AbstractView;
import ch.allink.microsite.imageElement.Image;
import ch.allink.microsite.imageElement.ImageView;

import flash.text.TextField;
import ch.allink.microsite.sectionElement.operation.ISectionOperation;

public class SectionView extends AbstractView
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _operation:ISectionOperation
	private var imageViews:Vector.<ImageView>
	private var images:Array
	public var section:Section
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function SectionView(section:Section = null)
	{
		super()
		this.section = section
	}
	
	//-------------------------------------------------------------------------
	//
	//	Overriden methods
	//
	//-------------------------------------------------------------------------
	
	final public override function build():void
	{
		if(section.files)
		{
			images = section.files
			imageViews = buildImageViews(images)
		}
		operation.build()
	}
	
	public override function dispose():void
	{
		imageViews = null
		images = null
 	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function buildImageViews(images:Array):Vector.<ImageView>
	{
		var imageViews:Vector.<ImageView> = new Vector.<ImageView>
		for each(var image:Image in images)
		{
			var imageView:ImageView = new  ImageView(image)
			imageViews.push(imageView)
		}
		return imageViews
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	
	public function set operation(value:ISectionOperation):void
	{
		_operation = value
		_operation.targetView = this
	}
	
	public function get operation():ISectionOperation
	{
		return _operation
	}
}
}