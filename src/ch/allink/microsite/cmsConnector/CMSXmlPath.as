package ch.allink.microsite.cmsConnector
{


public class CMSXmlPath
{
//	public static const PAGE_PATH:String = "./?do=xml&mode=page&pageID="
	public static const PAGES_PATH:String = "./?do=xml&mode=pages&pageIDs="
//	public static const NAVIGATION_PATH:String = "api/navigation/de.xml"
	public static const IMAGE_PATH:String = "./?do=xml&mode=resource&fileID="

	public function CMSXmlPath()
	{
	}
	
	public static function getNavigationPathByLanguage(language:String):String
	{
		return "api/navigation/"+language+".xml"
	}
	
	public static function getPagePathByURL(page:String):String
	{
		return "api/page/"+page+".xml"
	}
}
}