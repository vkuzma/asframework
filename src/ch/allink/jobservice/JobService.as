package ch.allink.jobservice
{

/**
 * @author Vladimir Kuzma
 * @date 13.11.2010
 **/
public class JobService
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var jobCollection:Vector.<Job>
	
	public var maxJobs:int
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function JobService()
	{
		jobCollection = new Vector.<Job>
			
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
			jobCollection.push(job)
	}
	
	/**
	 * Tells, that the executed Job is done. The Job instance at index 0 will be
	 * removed.
	 **/
	public function jobDone():void
	{
		if(jobCollection.length > 0) removeJob(jobCollection[0])
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
		if(jobCollection.length > 0)
		{
			if(jobCollection[0])
				jobCollection[0].execute()
		}
	}
	
	/**
	 * Removes all Job instances.
	 **/
	public function clearAllJobs():void
	{
		jobCollection = new Vector.<Job>		
	}
	
	/**
	 * Returns a Job instance by Index.
	 **/
	public function getJobByIndex(index:int):Job
	{
		return jobCollection[index]
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function get jobs():int
	{
		return jobCollection.length
	}
}
}