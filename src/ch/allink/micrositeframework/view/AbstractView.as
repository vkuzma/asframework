package ch.allink.micrositeframework.view
{
	import caurina.transitions.properties.ColorShortcuts;
	
	import ch.allink.micrositeframework.model.AbstractModel;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import mx.messaging.messages.AbstractMessage;
	
	{
		ColorShortcuts.init()
	}
	
	public class AbstractView extends Sprite implements IView
	{
		protected var _model:AbstractModel
		
		public function AbstractView()
		{
			super()
		}
		
		public function build():void
		{
	
		}
		
		public function dispose():void
		{

		}
		
		public function get model():AbstractModel
		{
			return _model
		}
		
		public function set model(value:AbstractModel):void
		{
			_model = value
		}
	}
}