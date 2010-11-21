package ch.allink.microsite.sectionElement
{
import ch.allink.microsite.core.AbstractView;

public interface ISectionOperation
{
	function set targetView(value:AbstractView):void
	function get targetView():AbstractView
	function get FORMAT():String
	function get height():Number
}
}