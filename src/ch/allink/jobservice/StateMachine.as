package ch.allink.jobservice
{
import ch.allink.microsite.util.Report;
import ch.allink.microsite.util.ReportService;

import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

/**
 * @author vkuzma
 * @date Dec 30, 2010
 **/
public class StateMachine extends EventDispatcher
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var report:Report
	private var transition:JobService
	private var _desiredState:State
	
	public var currentState:State
	public var states:Vector.<State>
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function StateMachine(target:IEventDispatcher=null)
	{
		report = new Report(this)
		ReportService.addReport(report)
		
		super(target)
		states = new Vector.<State>()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	/**
	 * This algorithm iterate rekursive through all states and transitions.
	 * At first, every transition will be added to the main transition.
	 * If the destination of the transition doesen't match the disired state,
	 * the tranistion will be removed backward rekursive.
	 */
	private function searchState(transition:JobService, 
								 desiredState:State, currentState:State, 
								 ignoreBeginingStates:Vector.<State>):int
	{
		report.indent++
		report.print("--------------STEP----------------")
		for each(var jobService:JobService in 
				 currentState.beginJobServices)
		{
			var destinationState:State = jobService.destination
			report.print("Current transition: " + jobService.name)
			report.print("Current beginningstate: " + jobService.beginning.name)
			report.print("Current destinationstate: " + destinationState.name)
				
			if(desiredState == destinationState)
			{
				report.print("State found")
				transition.addJob(new Job(jobService))
				return 1
			}
			
			if(!destinationState.beginJobServices.length) 
			{
				report.print("No transitions in " + destinationState.name)
				return 0
			}
				
			ignoreBeginingStates.push(currentState)
			report.print("Ignore: " + currentState.name)
			report.print("Go to destination " + destinationState.name + 
						 " allowed: " + 
						 !(ignoreBeginingStates.indexOf(destinationState) != 
						 -1))
			if(ignoreBeginingStates.indexOf(destinationState) != -1) 
			{
				report.print("Try another transition with another destination")
				report.print("------------NEXTITEM-------------")
				continue
			}
			if(searchState(transition, desiredState, destinationState,
						   ignoreBeginingStates))
			{
				transition.addJob(new Job(jobService))
				return 1
			}
			report.print("------------NEXTITEM--------------")
		}
		report.print("------------ENDSTEP---------------")
		report.indent--
		return 0
	}
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function addState(state:State):void
	{
		states.push(state)
	}
	
	public function moveToState(state:State):void
	{
		_desiredState = state
		transition = new JobService()
		report.print("Targetstate: " + state.name)
		report.print("START: searchState")
		report.print("------------------------")
		searchState(transition, _desiredState, currentState, new Vector.<State>)
		report.indent = 0
		report.print("END: searchState")
		report.print("------------------------")
		if(transition.jobCollection.length == 0)
			trace("Allink error: Destination state not found") 
		transition.jobCollection.reverse()		
		transition.addEventListener(JobEvent.COMPLETE_ALL, 
									transition_completeAllHandler, false, 0, 
									true)
		transition.doJob()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function transition_completeAllHandler(event:JobEvent):void
	{
		currentState = _desiredState
		report.print("Transition complete, " + currentState.name + " reached.")
		dispatchEvent(event)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function desiredState():State
	{
		return _desiredState
	}
}
}