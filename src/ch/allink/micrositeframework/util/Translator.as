package ch.allink.micrositeframework.util
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.System;
	import flash.utils.Dictionary;
	
	import spark.components.mediaClasses.VolumeBar;

	public class Translator
	{
		private var dictionaries:Object
		private var currentLanguage:String = ""
		private var loader:URLLoader
		private var files:Object
		
		public function Translator()
		{
			dictionaries = new Object
			files = new Object
		}
		
		public function addFile(langCode:String, url:String):void
		{
			files[langCode] = url;
		}
		
		public function load():void
		{
			for each( var url:String in files)
			{
				loader = new URLLoader()
				var request:URLRequest = new URLRequest(url)
				loader.addEventListener(Event.COMPLETE, loader_completeHandler)
				loader.load(request)
			}
		}
		
		private function loader_completeHandler(event:Event):void
		{
			var string:String = String(URLLoader(event.target).data)
			var lines:Array = string.split("\n")
			var msgid:String = ""
			var msg:String = ""
			dictionaries['de'] = {}
				
			for each(var line:String in lines)
			{	
				if(StringUtil.beginsWith(line, "msgid"))
				{
					msgid = extractLabel(line)
				}
				else if(StringUtil.beginsWith(line, "msgstr"))
				{
					msg = extractLabel(line)
					trace(msgid)
					trace(msg)
					dictionaries['de'][msgid] = msg
				}
			}
			
			currentLanguage = 'de'
				
			trace('translated:')
			trace(_("Welcome to my site."))
		}
		
		private function extractLabel(line:String):String
		{
			var rawString:String = String(line.match(/(["])(?:(?=(\\?))\2.)*?\1/)[0])
			return rawString.substr(1, rawString.length-2)
		}
		
		public function setCurrentLanguage(lang:String):void
		{
			currentLanguage = lang
		}
		
		public function _(key:String):String
		{
			return dictionaries[currentLanguage][key]
		}
	}
}