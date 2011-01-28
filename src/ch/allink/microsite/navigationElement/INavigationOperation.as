package ch.allink.microsite.navigationElement
{
import ch.allink.microsite.navigationElement.NavigationTreeView;

public interface INavigationOperation
{
	function initialize():void
	function set targetView(value:NavigationTreeView):void
	function get targetView():NavigationTreeView
}
}