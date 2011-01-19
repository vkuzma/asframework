package ch.allink.microsite.cmsConnector
{
public class CMSXmlPath
{
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function CMSXmlPath()
	{
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public static function getNavigationPathByLanguage(language:String):String
	{
		return "api/navigation/"+language+".xml"
	}
	
	public static function getPagePathByURL(page:String):String
	{
		return "api/page/"+page+".xml"
	}
	
	public static function getSoundPath():String
	{
		return "api/sound.xml"
	}
}
}