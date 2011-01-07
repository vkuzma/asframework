package ch.allink.jobservice
{
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
	private function searchState(desiredState:State, currentState:State):int
	{
		for each(var jobService:JobService in 
				 currentState.beginJobServices)
		{
			var destinationState:State = jobService.destination
				
			if(!destinationState.beginJobServices.length) return 0
				
			if(desiredState == destinationState)
			{
				transition.addJob(new Job(jobService))
				return 1
			}
			if(searchState(desiredState, destinationState)) return 1
		}
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
		searchState(_desiredState, currentState)
		transition.addEventListener(JobEvent.COMPLETE, 
									transition_completeHandler)
		transition.addEventListener(JobEvent.COMPLETE_ALL, 
									transition_completeAllHandler)
		transition.doJob()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function transition_completeHandler(event:JobEvent):void
	{
		dispatchEvent(event)
	}
	
	private function transition_completeAllHandler(event:JobEvent):void
	{
		transition.removeEventListener(JobEvent.COMPLETE, 
									   transition_completeHandler)
		transition.removeEventListener(JobEvent.COMPLETE_ALL, 
									   transition_completeAllHandler)
		currentState = _desiredState
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