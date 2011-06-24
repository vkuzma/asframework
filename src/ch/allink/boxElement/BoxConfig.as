package ch.allink.boxElement
{
import flash.geom.Rectangle;

/**
 * @author vkuzma
 * @date Jan 29, 2011
 **/
public class BoxConfig extends Rectangle
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	public var minWidth:Number
	public var maxWidth:Number
	public var autoWidth:Boolean
	public var minHeight:Number
	public var maxHeight:Number
	public var autoHeight:Boolean
	
	public var verticalSpacing:Number
	public var autoVerticalSpacing:Boolean
	public var horizontalSpacing:Number
	public var autoHorizontalSpacing:Boolean
	
	public var verticalChildren:int
	public var autoVerticalChildren:Boolean
	public var horizontalChildren:int
	public var autoHorizontalChildren:Boolean
	
	public var paddingLeft:Number
	public var paddingRight:Number
	public var paddingTop:Number
	public var paddingBottom:Number
	
	public var marginLeft:Number
	public var marginRight:Number
	public var marginTop:Number
	public var marginBottom:Number
	
	public var verticalAlign:String
	public var horizontalAlign:String
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function BoxConfig()
	{
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	
}
}