package ch.allink.jobservice
{
import flash.events.EventDispatcher;

/**
 * @author Vladimir Kuzma
 * @date 13.11.2010
 **/
public class JobService extends EventDispatcher
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _jobCollection:Vector.<Job>
	private var freezedJobCollection:Vector.<Job>
	private var _freezed:Boolean
	
	private var _destination:State
	private var _beginning:State
	public var maxJobs:int
	public var name:String
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function JobService()
	{
		addEventListener(JobEvent.COMPLETE_ALL, completeAllHandler)
		_jobCollection = new Vector.<Job>
		_freezed = false
		maxJobs = 0
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 *	Removes all Job instances with null value from the jobCollection.
	 **/
	private function reSortJobs(jobCollection:Vector.<Job>):void
	{
		//Bubblesort
		do
		{
			var swapedJob:Boolean = false
			var numJobCollection:int = jobCollection.length
			for(var i:int = 0; i < numJobCollection; i++)
			{
				if(jobCollection[i] == null)
				{
					swapedJob = true				
					if(i + 1 == numJobCollection)
					{
						jobCollection.pop()
					}
					else
					{
						jobCollection[i] = jobCollection[i + 1]
						jobCollection[i + 1] = null
					}
				}
			}
		}
		while(swapedJob)
	}
	
	private function getIndexIDByJob(job:Job, jobCollection:Vector.<Job>):int
	{
		var indexByJob:int = -1
		var numJobsCollection:int = jobCollection.length
		for(var i:int = 0; i < numJobsCollection; i++)
		{
			if(jobCollection[i] == job)
				indexByJob = i
		}
		
		return indexByJob
	}
	
	/**
	 * Clones a entire jobCollection.
	 **/
	private function cloneJobCollection(jobCollection:Vector.<Job>):Vector.<Job>
	{
		var clonedJobCollection:Vector.<Job> = new Vector.<Job>()
		for each(var job:Job in jobCollection)
			clonedJobCollection.push(job)
		return clonedJobCollection
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Adds a Job instance to the jobCollection. The Job instances wait in a queue
	 * to be executed.
	 **/
	public function addJob(job:Job):void
	{
		if(maxJobs > jobCollection.length || maxJobs == 0)
		{
			job.parentJobService = this
			jobCollection.push(job)
		}
	}
	
	/**
	 * Tells, that the executed Job is done. The Job instance at index 0 will be
	 * removed.
	 **/
	public function jobDone():void
	{
		if(jobCollection.length > 0) jobCollection.shift()
		if(jobCollection.length == 0)
			dispatchEvent(new JobEvent(JobEvent.COMPLETE_ALL)) 
	}
	
	/**
	 * Remove 
	 **/
	public function removeJob(job:Job):void
	{
		var jobIndex:int = getIndexIDByJob(job, jobCollection)
		jobCollection[jobIndex] = null
		reSortJobs(jobCollection)
	}
	
	/**
	 * Does the next Job in the queue (jobCollection).
	 **/
	public function doJob():void
	{
		if(jobCollection.length == 0) return
			
		var currentJob:Job = jobCollection[0]
			
		//execute and call job as finished
		if(currentJob.autoFinish)
		{
			currentJob.addEventListener(JobEvent.EXECUTED,
										currentJob_executedHandler, false, 0,
										true)
			currentJob.execute()
		}
		//execute and call job manually as finished
		else
		{
			if(currentJob.jobService)
			currentJob.jobService.addEventListener(JobEvent.COMPLETE_ALL, 
											childJobService_completeAllHandler)
			currentJob.execute()
		}
	}
	
	/**
	 * Has the same effect like executing jobDone() and doJob() one after another.
	 **/
	public function doNextJob():void
	{
		jobDone()
		doJob()
	}
	
	/**
	 * Removes all Job instances.
	 **/
	public function clearAllJobs():void
	{
		_jobCollection = new Vector.<Job>		
	}
	
	/**
	 * Returns a Job instance by Index.
	 **/
	public function getJobByIndex(index:int):Job
	{
		return _jobCollection[index]
	}
	
	
	public function pop():Job
	{
		return _jobCollection.pop()
	}
	
	/**
	 * Saves the current jobs collection. When all jobs are done or 
	 * clear() will be called, the job collection will be reset to the state of
	 * the freeze() call.
	 **/
	public function freeze():void
	{
		freezedJobCollection = cloneJobCollection(_jobCollection)
		_freezed = true
	}
	
	/**
	 * Removes all job instances from the collection. If previous freeze() has 
	 * been called, the job collection will be reset to the state of the freeze()
	 * call.
	 **/
	public function clear():void
	{
		if(freezed) _jobCollection = cloneJobCollection(freezedJobCollection)
		else _jobCollection = new Vector.<Job>
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function currentJob_executedHandler(event:JobEvent):void
	{
		var currentJob:Job = event.target as Job
		
		doNextJob()
	}
	
	private function completeAllHandler(event:JobEvent):void
	{
		clear()
	}
	
	private function childJobService_completeAllHandler(event:JobEvent):void
	{
		var jobService:JobService = event.target as JobService
		jobService.removeEventListener(JobEvent.COMPLETE_ALL, 
									   childJobService_completeAllHandler)
		doNextJob()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	/**
	 * Current number of added job instances.
	 **/
	public function get jobs():int
	{
		return _jobCollection.length
	}
	
	public function get isWorking():Boolean
	{
		var _isWorking:Boolean = false
			
		if(jobs > 0) _isWorking = true
		return _isWorking
	}
	
	/**
	 * By true, the jobCollection was freezed and can be reset by clear().
	 **/
	public function get freezed():Boolean
	{
		return _freezed
	}
	
	public function set destination(value:State):void
	{
		_destination = value
		_destination.addDestinationJobService(this)
	}
	
	public function get destination():State
	{
		return _destination
	}
	
	/**
	 * Beginning state of this transition.
	 **/
	public function set beginning(value:State):void
	{
		_beginning = value
		_beginning.addBeginJobService(this)
	}
	
	public function get beginning():State
	{
		return _beginning
	}
	
	public function get jobCollection():Vector.<Job>
	{
		return _jobCollection
	}
}
}