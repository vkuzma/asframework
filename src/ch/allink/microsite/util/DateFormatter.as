package ch.allink.microsite.util
{
import ch.allink.microsite.widgets.YoutubePlayer;

import flash.utils.Dictionary;

/**
 * @author vkuzma
 * @date Jun 15, 2011
 **/
public class DateFormatter
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private static const months:Array = ["Januar", "Februar", "März", "April", "Mai", "Juni",
	"Juli", "August", "September", "November", "December"]
		
	public static const US:String = "us"
	public static const DAY_MONTH_YEAR:String = "dayMonthYear"
		
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function DateFormatter()
	{
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
	
	public static function transformDate(dateString:String, fromFormat:String, toFormat:String):String
	{
		var transformedDataString:String = ""
		var date:Date
		if(fromFormat == US)
		{
			var tempDate:Array 
			tempDate = dateString.split("-")
			date = new Date(tempDate[0], tempDate[1], tempDate[2])
		}
		
		if(toFormat == DAY_MONTH_YEAR)
			transformedDataString = date.day + ". " + months[date.month] + " " + date.fullYear
			
		return transformedDataString
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
	
	
}
}