package ch.allink.jobservice
{
import flash.events.EventDispatcher;
import flash.events.TimerEvent;
import flash.utils.Timer;

/**
 * @author Vladimir Kuzma
 * @date 13.11.2010
 **/
public class Job extends EventDispatcher
{
	//-------------------------------------------------------------------------
	//
	//	Global variables
	//
	//-------------------------------------------------------------------------
	
	private var _funktion:Function
	private var _jobService:JobService
	
	public var parentJobService:JobService
	public var params:Array
	public var delay:Number
	public var autoFinish:Boolean
	public var finishState:String
	public var beginState:String
	public var returnValue:Object
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Creates a new Job instance.
	 **/
	public function Job(jobOperation:Object, options:Object = null)
	{
		if(jobOperation is Function)
			_funktion = jobOperation as Function
		else if(jobOperation is JobService)
			_jobService = jobOperation as JobService
				
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
		startOperation()
		dispatchEvent(new JobEvent(JobEvent.EXECUTED))
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
	
	private function startOperation():void
	{
		if(funktion != null) returnValue = funktion.apply(null, params)
		else if(jobService) jobService.doJob()
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
			startOperation()
			dispatchEvent(new JobEvent(JobEvent.EXECUTED))
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
	
	public function get jobService():JobService
	{
		return _jobService
	}
}
}