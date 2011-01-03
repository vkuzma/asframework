package ch.allink.jobservice
{
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

import mx.core.DesignLayer;

/**
 * @author vkuzma
 * @date Jan 2, 2011
 **/
public class State extends EventDispatcher
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	public var name:String
	private var _jobServices:Vector.<JobService>
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function State(target:IEventDispatcher=null)
	{
		super(target)
		_jobServices = new Vector.<JobService>()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function addJobService(jobService:JobService):void
	{
		_jobServices.push(jobService)
	}
	
	public function containsInDestinations(jobService:JobService):Boolean
	{
		var contain:Boolean = false
//		for each(var currentJobService:JobService in destinaitons)
//		{
//			if(currentJobService == jobService)
//			{
//				contain = true
//				break
//			}
//		}
		return contain
	}
	
	public function containsInBeginnings(jobService:JobService):Boolean
	{
		var contain:Boolean = false
//		for each(var currentJobService:JobService in beginnings)
//		{
//			if(currentJobService == jobService)
//			{
//				contain = true
//				break
//			}
//		}
		return contain
		
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function get jobServices():Vector.<JobService>
	{
		if(!_jobServices) return new Vector.<JobService>()
		return _jobServices
	}
}
}