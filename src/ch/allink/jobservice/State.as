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
	private var _beginJobServices:Vector.<JobService>
	private var _destinationJobServices:Vector.<JobService>
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function State(target:IEventDispatcher=null)
	{
		super(target)
		_beginJobServices = new Vector.<JobService>()
		_destinationJobServices = new Vector.<JobService>()
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
	
	public function addDestinationJobService(jobService:JobService):void
	{
		_destinationJobServices.push(jobService)
	}
	
	public function addBeginJobService(jobService:JobService):void
	{
		_beginJobServices.push(jobService)
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
	
	public function get destinationJobServices():Vector.<JobService>
	{
		if(!_destinationJobServices) return new Vector.<JobService>()
		return _destinationJobServices
	}
	
	public function get beginJobServices():Vector.<JobService>
	{
		if(!_beginJobServices) return new Vector.<JobService>()
		return _beginJobServices
	}
}
}