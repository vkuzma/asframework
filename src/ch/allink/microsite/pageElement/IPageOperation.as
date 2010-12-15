package ch.allink.microsite.pageElement
{
import ch.allink.microsite.sectionElement.SectionView;

public interface IPageOperation
{
	function buildSectionViews(sections:Array):void
	function formatSectionViews():void
	function dispose():void
	function resize(sourceWidth:Number, sourceHeight:Number):void
	function set targetView(value:PageView):void
	function get targetView():PageView
	function get sectionViews():Vector.<SectionView>
	function set pageFormatter(value:PageFormatter):void
	function get pageFormatter():PageFormatter
}
}