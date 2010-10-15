package ch.allink.micrositeframework.net
{
	import ch.allink.micrositeframework.model.AbstractModel;
	
	import flash.events.Event;
	
	public class ResultEvent extends Event
	{
		
		public static const DATA_LOADED:String = "dataLoaded"
		
		private var _collection:Vector.<AbstractModel>
		private var _abstractModel:AbstractModel
		private var _modelRequest:ModelRequest
		
		public function ResultEvent(type:String,
									bubbles:Boolean=false,
									cancelable:Boolean=false,
									modelRequest:ModelRequest=null,
									collection:Vector.<AbstractModel> = null,
									abstractModel:AbstractModel = null)
		{
		
			super(type, bubbles, cancelable)
			_collection = collection
			_abstractModel = abstractModel
			_modelRequest = modelRequest
		}
		
		public override function clone():Event
		{
			return new ResultEvent(type, bubbles, cancelable, _modelRequest,
					_collection, _abstractModel)
		}
		
		public function get collection():Vector.<AbstractModel>
		{
			return _collection
		}
		
		public function get request():ModelRequest
		{
			return _modelRequest
		}
		
		public function get model():AbstractModel
		{
			return _abstractModel
		}
	}
}