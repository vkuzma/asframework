package ch.allink.microsite.core
{
import ch.allink.microsite.cmsConnector.ModelFactory;

/**
 * @author Mike Walder
 **/
public class AbstractModel extends Object
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------

	protected var modelFactory:ModelFactory
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function AbstractModel()
	{
		modelFactory = new ModelFactory()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Protected methods
	//
	//-------------------------------------------------------------------------
	
	protected function fillCollection(klass:Class, values:Array):Array
	{
		//TODO: update method so it can distinguish between xml an array of objects
		if(values[0] is XML)
		{
			var collection:Array = [ ]
			for each(var s:XML in values)
			{
				collection.push(modelFactory.create(klass, s))
			}
		}	
		return collection
	}		
}
}