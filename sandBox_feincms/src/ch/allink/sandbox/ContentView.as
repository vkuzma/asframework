package ch.allink.sandbox
{
import ch.allink.microsite.core.AbstractView;
import ch.allink.microsite.pageElement.MultipleSectionTypeOperation;
import ch.allink.microsite.pageElement.PageView;



public class ContentView extends AbstractView
{
	//-------------------------------------------------------------------------
	//
	//	Variablels
	//
	//-------------------------------------------------------------------------
	
	private var pageView:PageView
	
	//-------------------------------------------------------------------------
	//
	//	Constructore
	//
	//-------------------------------------------------------------------------
	
	public function ContentView()
	{
	}
	
	//-------------------------------------------------------------------------
	//
	//	Override methods
	//
	//-------------------------------------------------------------------------
	
	public override function build():void
	{
		var pageOperation:MultipleSectionTypeOperation = new MultipleSectionTypeOperation()
		
		pageOperation.pageFormatter = Config.pageFormatter
			
		pageView = new PageView()
		addChild(pageView)
		pageView.operation = pageOperation
		pageView.build()
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function buildPageByURL(url:String):void
	{
		pageView.buildPageByURL(url)
	}
	
	public function resize(sourceWidth:Number, sourceHeigth:Number):void
	{
				
	}
}
}