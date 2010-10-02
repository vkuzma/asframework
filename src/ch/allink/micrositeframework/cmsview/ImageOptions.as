package ch.allink.micrositeframework.cmsview
{
public class ImageOptions
{
		public var width:Number
		public var height:Number
		public var blackAndWhite:Boolean = false
		public var square:Boolean = false
		public var options:String
		public var basePath:String = "./cached/"

	public function ImageOptions()
	{
		
	}

	public function get option1():String
	{
		if(blackAndWhite)
			return "_gray"
		
		if(square)
			return "_square"
	
		return ""
	}
	
}
}