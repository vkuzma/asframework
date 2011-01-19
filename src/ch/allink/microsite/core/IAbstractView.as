package ch.allink.microsite.core
{
import flash.events.IEventDispatcher;

public interface IAbstractView extends IEventDispatcher
{
	 function build():void
	 function dispose():void
}
}