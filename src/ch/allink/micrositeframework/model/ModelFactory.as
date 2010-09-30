package ch.allink.micrositeframework.model
{
	
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.events.Request;
	
	
	[Event (name='modelLoaded', type='ch.allink.micrositeframework.model.ModelEvent')]
	
	public class ModelFactory extends EventDispatcher
	{
		
		private var loader:ModelLoader
		
		public function ModelFactory(target:IEventDispatcher=null)
		{
			super(target)
		}
		
		public function loadCollectionFromURL(klass:Class, url:String):void
		{
			loadData(klass, url, loader_completeHandler)
		}
		
		public function loadModelFromURL(klass:Class, url:String):void
		{
			loadData(klass, url, loader_modelCompleteHandler)
		}
		
		private function loadData(klass:Class, url:String, callback:Function):void
		{
			if(loader)
			{
				loader.close()
			}
			loader = new ModelLoader()	
			loader.addEventListener(IOErrorEvent.IO_ERROR, loader_ioerrorHandler, false, 0, true)
			loader.addEventListener(Event.COMPLETE, callback, false, 0, true)
			var request:URLRequest = new URLRequest(url)
			loader.klass = klass
			loader.load(request)
		}
		
		private function loader_modelCompleteHandler(e:Event):void
		{
			var loader:ModelLoader = ModelLoader(e.target)
			var xml:XML = new XML(loader.data)
			var model:AbstractModel = create(loader.klass, xml)
			var modelEvent:ModelEvent = new ModelEvent(ModelEvent.MODEL_LOADED)
			modelEvent.klass = loader.klass
			modelEvent.model = model
			dispatchEvent(modelEvent)
		}
		
		private function loader_ioerrorHandler(e:IOErrorEvent):void
		{
			trace(e.text)
		}
		
		private function loader_completeHandler(e:Event):void
		{
			var loader:ModelLoader = ModelLoader(e.target)
			var xml:XML = new XML(loader.data)
			var collection:Vector.<AbstractModel> = createCollection(loader.klass, xml)
			var modelEvent:ModelCollectionEvent = new ModelCollectionEvent(ModelCollectionEvent.MODEL_COLLECTION_LOADED)
			modelEvent.klass = loader.klass
			modelEvent.collection = collection
			dispatchEvent(modelEvent)
		}
		
		public function create(klass:Class, xml:XML):AbstractModel
		{
			var model:AbstractModel = new klass
			
			try{
				var attributes:XMLList = xml.attributes()
				for each (var attribute:XML in attributes)
				{
					model[attribute.name().toString()] = attribute.toString()
				}
				var nodes:XMLList = xml.children()
				for each(var node:XML in nodes)
				{
					var value:Object;
					if (node.hasComplexContent())
					{
						var collection:Array = new Array()
						var children:XMLList = node.children()
						for each (var subnode:XML in children)
						{
							collection.push(subnode)
						}
						value = collection
					}
					else
					{
						value = node.toString()
					}
					model[node.name()] = value
				}
			}
			catch(e:Error)
			{
				throw e
			}
			return model;
		}
		
		public function createCollection(klass:Class, xml:XML):Vector.<AbstractModel>
		{
			var result:Vector.<AbstractModel> = new Vector.<AbstractModel>
			for each(var node:XML in xml.children())
			{
				result.push(create(klass, node))
			}
			
			return result
		}
	}
}