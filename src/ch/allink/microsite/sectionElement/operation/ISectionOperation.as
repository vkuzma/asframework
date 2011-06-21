package ch.allink.microsite.sectionElement.operation
{
import ch.allink.microsite.pageElement.PageFormatter;
import ch.allink.microsite.sectionElement.SectionView;


public interface ISectionOperation
{
	function build():void
	function resize(sourceWidth:Number, sourceHeight:Number):void
	function set targetView(value:SectionView):void
	function get targetView():SectionView
	function set pageFormatter(value:PageFormatter):void
	function get pageFormatter():PageFormatter
}
}