package ch.allink.micrositeframework.widgets
{
import ch.allink.micrositeframework.cmsview.ImageView;

import flash.events.Event;

public class ImageViewServiceEvent extends Event
{
	//-------------------------------------------------------------------------
	//
	//	Constants
	//
	//-------------------------------------------------------------------------
	
	public static const COMPLETE:String = "imageViewServicecomplete"
	public static const COMPLETE_ALL:String	= "imageViewServicecompleteAll"
	public static const PROGRESS:String = "imageViewServiceProgress"
	
	//-------------------------------------------------------------------------
	//
	//	Global Variables
	//
	//-------------------------------------------------------------------------
	
	private var _imageView:ImageView
	private var _imageViews:Vector.<ImageView>
	private var _bytesLoaded:Number
	private var _bytesTotal:Number
	private var _progressInPercent:Number
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function ImageViewServiceEvent(type:String, imageView:ImageView,
										  imageViews:Vector.<ImageView>,
										  bytesLoaded:Number = 0,
										  bytesTotal:Number = 0)
	{
		super(type, bubbles, cancelable)
		_imageView = imageView
		_imageViews = imageViews
		_bytesLoaded = bytesLoaded
		_bytesTotal = bytesTotal
	}	
	
	//-------------------------------------------------------------------------
	//
	//	Overriden methods
	//
	//-------------------------------------------------------------------------
	
	override public function clone():Event
	{
		var bubbleEvent:ImageViewServiceEvent = new ImageViewServiceEvent(
			type, _imageView, _imageViews, _bytesLoaded, _bytesTotal)
		return bubbleEvent
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function calcWholeProgressInPercent():Number
	{
		//Prozentanteil einer ImageView-Instanz
		var partLength:Number = 100.0 / _imageViews.length
			
		//Prozentanteil der gerade ladenden ImageView-Instanz
		var currentProgressInPercent:Number = _bytesLoaded / _bytesTotal
			* 100
			
		//Prozentanteil vom Prozentanteil einer ImageView-Instanz (partLength)
		//von der gerade ladenden ImageView-Instanz (currentPgoressInPercen)
		var absolutePercent:Number = currentProgressInPercent / 100 
			* partLength
			
		//Der Index der gerade ladenen ImageView-Instanz
		var currentIndex:int = _imageViews.indexOf(_imageView)
		
		//Alle fertiggeladenen ImageView-Instanzen
		var currentLoadedPartsInPercent:Number =  (currentIndex) 
			* partLength
		
		//Prozentanteil der gerade ladenen ImageView-Instanz und allen
		//vorherig geladenen ImageView-Instanzen
		var wholeProgressInPercent:Number = currentLoadedPartsInPercent
			+ absolutePercent
			
		return wholeProgressInPercent
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function get imageView():ImageView
	{
		return _imageView
	}
	
	public function get imageViews():Vector.<ImageView>
	{
		return _imageViews
	}
	
	public function get bytesLoaded():Number
	{
		return _bytesLoaded
	}
	
	public function get bytesTotal():Number
	{
		return _bytesTotal
	}
	
	public function get wholeProgressInPercent():Number
	{
		return calcWholeProgressInPercent()
	}
}
}