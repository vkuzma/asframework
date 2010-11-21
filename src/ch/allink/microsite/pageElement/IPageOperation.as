package ch.allink.microsite.pageElement
{
import ch.allink.microsite.core.AbstractView;
import ch.allink.microsite.sectionElement.ISectionOperation;
import ch.allink.microsite.sectionElement.Section;
import ch.allink.microsite.sectionElement.SectionView;

public interface IPageOperation
{
	function buildSectionViews(section:Section, i:int, sections:Array):void
	function dispose():void
	function set targetView(value:AbstractView):void
	function get targetView():AbstractView
	function get sectionViews():Vector.<SectionView>
}
}