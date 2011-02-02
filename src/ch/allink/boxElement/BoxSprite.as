package ch.allink.boxElement
{
import flash.display.DisplayObject;
import flash.display.Sprite;

/**
 * @author vkuzma
 * @date Jan 29, 2011
 **/
public class BoxSprite extends Sprite
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _boxConfig:BoxConfig
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function BoxSprite()
	{
		super()
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
	
	/**
	 * Adds a BoxSprite instance to the collection.
	 **/
	public function addBoxChild(boxSprite:DisplayObject):void
	{
		
	}
	
	/**
	 * Arranges the BoxSprite childinstances.
	 **/
	public function arrangeBoxes():void
	{
		
	}
	
	/**
	 * Return a BoxSprite instance according to the columns and row index.
	 **/
	public function getBoxByIndex(column:int, row:int):BoxSprite
	{
		return null
	}
	
	/**
	 * Returns a vector with BoxSprite instances in the desired column.
	 **/
	public function getColumnByIndex(column:int):Vector.<BoxSprite>
	{
		return null
	}
	
	/**
	 * Returns a vector with BoxSprite instances in the desired row.
	 **/
	public function getRowByIndex(row:int):Vector.<BoxSprite>
	{
		return null
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
	
	/**
	 * Number of columns.
	 **/
	public function get columns():int
	{
		return 0
	}
	
	/**
	 * Number of rows.
	 **/
	public function get rows():int
	{
		return 0
	}
	
	public function get totalWidth():Number
	{
		return 0
	}
	
	public function get totalHeight():Number
	{
		return 0
	}
	
	public function set boxConfig(value:BoxConfig):void
	{
		_boxConfig = value
	}
	
	public function get boxConfig():BoxConfig
	{
		if(!_boxConfig) _boxConfig = new BoxConfig()
		return _boxConfig
	}
}
}