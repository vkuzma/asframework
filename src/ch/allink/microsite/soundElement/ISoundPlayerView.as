package ch.allink.microsite.soundElement
{
import ch.allink.microsite.core.IAbstractView;
import ch.allink.microsite.events.ResultEvent;

import com.greensock.loading.MP3Loader;


public interface ISoundPlayerView extends IAbstractView
{
	function mp3Loader_completeHandler(event:MP3Loader):void
	function modelRequst_dataLoadedHandler(event:ResultEvent):void
	function pauseSound():void
	function playSound():void
}
}