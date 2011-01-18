package ch.allink.microsite.util
{
/**
 * @author vkuzma
 * @date Jan 14, 2011
 **/
public class ReportService
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private static var _reports:Vector.<Report>
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function ReportService()
	{
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private static function setReportEnable(object:Object, 
											state:Boolean):Boolean
	{
		for each(var report:Report in reports)
		if(report.targetObject == object) 
		{
			report.enable = state
			return true
		}
		return false
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public static function addReport(report:Report):void
	{
		reports.push(report)
	}
	
	public static function enableReportByObject(object:Object):Boolean
	{
		return setReportEnable(object, true)
	}
	
	public static function disableReportByObject(object:Object):Boolean
	{
		return setReportEnable(object, false)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	private static function get reports():Vector.<Report>
	{
		if(!_reports) _reports = new Vector.<Report>
		return _reports
	}
}
}