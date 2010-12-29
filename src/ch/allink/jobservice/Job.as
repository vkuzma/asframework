package ch.allink.jobservice
{
import flash.events.TimerEvent;
import flash.utils.Timer;

/**
 * @author Vladimir Kuzma
 * @date 13.11.2010
 **/
public class Job
{
	//-------------------------------------------------------------------------
	//
	//	Global variables
	//
	//-------------------------------------------------------------------------
	
	private var _funktion:Function
	public var params:Array
	
	public var delay:Number
	public var autoFinish:Boolean
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Creates a new Job instance.
	 **/
	public function Job(funktion:Function, options:Object = null)
	{
		_funktion = funktion
		params = null
		delay = 0
		autoFinish = false
		if(options) initOptions(options)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function timer_timerCompleteHandler(event:TimerEvent):void
	{
		_funktion.apply(null, params)
	}
	
	private function initOptions(options:Object):void
	{
		for (var key:String in options)
		{
			try
			{
				this[key] = options[key]
			}
			catch(error:Error)
			{
				error.name = "allink Error: Error #XXXX"
				error.message = "Option " + key +" doesn't exist"
				throw error
			}
		}
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Runs the function.
	 **/
	public function execute():void
	{
		if(delay > 0)
		{
			var timer:Timer = new Timer(delay * 1000, 1)
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, 
				timer_timerCompleteHandler)
			timer.start()
		}
		else
		{
			_funktion.apply(null, params)
		}
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function get funktion():Function
	{
		return _funktion
	}
}
}