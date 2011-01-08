package ch.allink.microsite.navigationElement
{
public interface INavigationOperation
{
	function initialize():void
	function set targetView(value:NavigationTreeView):void
	function get targetView():NavigationTreeView
}
}