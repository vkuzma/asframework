package ch.allink.microsite.cmsConnector
{
import flash.net.URLLoader;
import flash.net.URLRequest;

public class ModelLoader extends URLLoader
{
	public var klass:Class
	
	public function ModelLoader(request:URLRequest = null)
	{
		super(request)
	}
	
}
}