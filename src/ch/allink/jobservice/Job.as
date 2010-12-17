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
	private var _params:Array
	
	public var delay:Number
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Creates a new Job instance.
	 **/
	public function Job(funktion:Function, params:Array = null,
						delay:Number = 0)
	{
		_funktion = funktion
		_params = params
		this.delay = delay
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
	
	public function get params():Array
	{
		return _params
	}
}
}