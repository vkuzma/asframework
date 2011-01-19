package ch.allink.microsite.soundElement
{
import ch.allink.microsite.cmsConnector.CMSXmlPath;
import ch.allink.microsite.cmsConnector.ModelFactory;
import ch.allink.microsite.cmsConnector.ModelRequest;
import ch.allink.microsite.events.ResultEvent;
import ch.allink.microsite.events.SoundPlayerEvent;
import ch.allink.microsite.scrollPaneElement.ScrollPaneView;

import com.greensock.events.LoaderEvent;
import com.greensock.loading.MP3Loader;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.ProgressEvent;

/**
 * @author vkuzma
 * @date Jan 19, 2011
 **/
public class SoundPlayerController extends EventDispatcher
{
	//-------------------------------------------------------------------------
	//
	//	Variables
	//
	//-------------------------------------------------------------------------
	
	private var _sounds:Vector.<Track>
	private var _soundPlayerView:ISoundPlayerView
	private var mp3Loader:MP3Loader
	private var _currentIndex:int
	public var autoPlay:Boolean
	
	//-------------------------------------------------------------------------
	//
	//	Constructor
	//
	//-------------------------------------------------------------------------
	
	public function SoundPlayerController()
	{
		super()
		autoPlay = false
		_currentIndex = 0
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function pauseSound():void
	{
		mp3Loader.pauseSound()
//		soundPlayerView.pauseSound()
	}
	
	private function playSound():void
	{
		mp3Loader.playSound()
//		soundPlayerView.playSound()
	}
	
	private function assignListeners(soundPlayerView:ISoundPlayerView):void
	{
		soundPlayerView.addEventListener(SoundPlayerEvent.PAUSE, 
										 soundPlayerView_pauseHandler)
		soundPlayerView.addEventListener(SoundPlayerEvent.PLAY, 
										 soundPlayerView_playHandler)
		soundPlayerView.addEventListener(SoundPlayerEvent.PLAYPAUSE, 
										 soundPlayerView_playPauseHandler)
	}
	
	private function doFunctionOnSoundPlayerClip(funktion:Function, 
												 params:Array):void
	{
		if(soundPlayerView)
			Object(soundPlayerView).apply(funktion, params)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function buildTrackByIndex(index:int):void
	{
		currentIndex = index
		buildByTrack(tracks[currentIndex])
	}
	
	public function buildByTrack(track:Track):void
	{
		mp3Loader = new MP3Loader(track.url)
		mp3Loader.addEventListener(LoaderEvent.COMPLETE, 
								   mp3Loader_completeHandler, false, 0, true)
		mp3Loader.addEventListener(LoaderEvent.PROGRESS, 
								   mp3Loader_progressHandler, false, 0, true)
		mp3Loader.load()
	}
	
	public function buildNextTrack():void
	{
		currentIndex++
		buildByTrack(tracks[currentIndex])
	}
	
	public function buildPrevTrack():void
	{
		currentIndex--
		buildByTrack(tracks[currentIndex])
	}
	
	public function stop():void
	{
		pauseSound()
		currentIndex = 0
	}
	
	public function playPause():void
	{
		if(mp3Loader.paused) playSound()
		else pauseSound()
	}
	
	public function loadTracks():void
	{
		var modelFactory:ModelFactory = new ModelFactory()
		var modelRequst:ModelRequest = modelFactory.load(Track,
			CMSXmlPath.getSoundPath(), ModelFactory.TYPE_COLLECTION)
		modelRequst.addEventListener(ResultEvent.DATA_LOADED, 
									 modelRequst_dataLoadedHandler)
	}
	
	public function addTrack(track:Track):void
	{
		tracks.push(track)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Event handlers
	//
	//-------------------------------------------------------------------------
	
	private function modelRequst_dataLoadedHandler(event:ResultEvent):void
	{
		tracks = Vector.<Track>(event.collection)
		doFunctionOnSoundPlayerClip(modelRequst_dataLoadedHandler, [event])
		dispatchEvent(new SoundPlayerEvent(SoundPlayerEvent.MODELS_LOADED))
	}
	
	private function mp3Loader_completeHandler(event:LoaderEvent):void
	{
		if(autoPlay) playSound()
		else pauseSound()
		dispatchEvent(new Event(Event.COMPLETE))
//		soundPlayerView.mp3Loader_completeHandler(event)
		dispatchEvent(new SoundPlayerEvent(SoundPlayerEvent.SOUND_LOADED))
	}
	
	private function soundPlayerView_pauseHandler(event:SoundPlayerEvent):void
	{
		
	}
	
	private function soundPlayerView_playHandler(event:SoundPlayerEvent):void
	{
		
	}
	
	private function soundPlayerView_playPauseHandler(
		event:SoundPlayerEvent):void
	{
		
	}
	
	private function mp3Loader_progressHandler(event:LoaderEvent):void
	{
		var progressEvent:SoundPlayerEvent = new SoundPlayerEvent(
			SoundPlayerEvent.PROGRESS, false, false, mp3Loader.progress)
		dispatchEvent(progressEvent)
			
	}
	
	//-------------------------------------------------------------------------
	//
	//	Properties
	//
	//-------------------------------------------------------------------------
	
	public function set tracks(value:Vector.<Track>):void
	{
		_sounds = value
	}
	
	public function get tracks():Vector.<Track>
	{
		if(!_sounds) _sounds = new Vector.<Track>()
		return _sounds
	}
	
	public function set soundPlayerView(value:ISoundPlayerView):void
	{
		_soundPlayerView = value
		assignListeners(_soundPlayerView)
	}
	
	public function get soundPlayerView():ISoundPlayerView
	{
		return _soundPlayerView
	}
	
	public function set currentIndex(value:int):void
	{
		_currentIndex = value
		if(_currentIndex >= tracks.length) _currentIndex = 0
		else if(_currentIndex < 0) _currentIndex = tracks.length - 1
	}
	
	public function get currentIndex():int
	{
		return _currentIndex
	}
}
}