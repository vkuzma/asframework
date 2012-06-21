package ch.allink.microsite.soundElement
{
import ch.allink.jobservice.Job;
import ch.allink.jobservice.JobService;
import ch.allink.jobservice.JobUtils;
import ch.allink.microsite.cmsConnector.CMSXmlPath;
import ch.allink.microsite.cmsConnector.ModelFactory;
import ch.allink.microsite.events.ResultEvent;
import ch.allink.microsite.events.SoundPlayerEvent;

import com.greensock.TweenLite;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.MP3Loader;

import flash.events.*;

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
	private var mp3LoaderOld:MP3Loader
	private var _currentIndex:int
	private var _currentTrack:Track
	public var autoPlay:Boolean
	public var blendInTime:Number
	public var blendOutTime:Number
	public var loop:Boolean
	
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
		blendInTime = 0
		blendOutTime = 0
		loop = false
	}
	
	//-------------------------------------------------------------------------
	//
	//	Private methods
	//
	//-------------------------------------------------------------------------
	
	private function slideVolumeTo(mp3Loader:MP3Loader, volume:Number,blendTime:Number,
								   jobService:JobService):void
	{
		TweenLite.killTweensOf(mp3Loader)
		TweenLite.to(mp3Loader, blendTime, {volume: volume, onComplete: jobService.doNextJob})
	}
	
	private function pauseSound(mp3Loader:MP3Loader, jobService:JobService = null):void
	{
		var pauseActions:JobService = new JobService()
		//Slided volume
		pauseActions.addJob(new Job(slideVolumeTo, {params: [mp3Loader, 0, blendOutTime,
			pauseActions]}))
		//Stops the sound
		pauseActions.addJob(new Job(mp3Loader.pauseSound, {autoFinish: true}))
		if(jobService) pauseActions.addJob(new Job(jobService.doNextJob, {autoFinish: true}))
		pauseActions.doJob()
		dispatchEvent(new SoundPlayerEvent(SoundPlayerEvent.PAUSE))
	}
	
	private function playSound(mp3Loader:MP3Loader, jobService:JobService = null):void
	{
		mp3Loader.volume = 0
		mp3Loader.playSound()
		var pauseActions:JobService = new JobService()
		//Slided volume
		pauseActions.addJob(new Job(slideVolumeTo, {params: [mp3Loader, 1, blendInTime,
			pauseActions]}))
		//Play the sound
		if(jobService) pauseActions.addJob(new Job(jobService.doNextJob, {autoFinish: true}))
		//Removes playActions
		pauseActions.doJob()
		dispatchEvent(new SoundPlayerEvent(SoundPlayerEvent.PLAY))
	}
	
	private function stopSound(mp3Loader:MP3Loader, jobService:JobService = null):void
	{
		var stopActions:JobService = new JobService()
		//Slided volume
		stopActions.addJob(new Job(slideVolumeTo, {params: [mp3Loader, 0, blendOutTime,
			stopActions]}))
		//Stops the sound
		stopActions.addJob(new Job(mp3Loader.pauseSound, {autoFinish: true}))
		//Unload the sound
		stopActions.addJob(new Job(mp3Loader.unload, {autoFinish: true}))
		if(jobService) stopActions.addJob(new Job(jobService.doNextJob, {autoFinish: true}))
		//Removes playActions
		stopActions.addJob(new Job(JobUtils.setValue, {params: [stopActions, null]}))
		stopActions.doJob()
	}
	
	private function assignListeners(soundPlayerView:ISoundPlayerView):void
	{
//		soundPlayerView.addEventListener(SoundPlayerEvent.PAUSE, 
//										 soundPlayerView_pauseHandler)
//		soundPlayerView.addEventListener(SoundPlayerEvent.PLAY, 
//										 soundPlayerView_playHandler)
//		soundPlayerView.addEventListener(SoundPlayerEvent.PLAYPAUSE, 
//										 soundPlayerView_playPauseHandler)
	}
	
	private function doFunctionOnSoundPlayerClip(funktion:Function, params:Array):void
	{
		if(soundPlayerView) Object(soundPlayerView).apply(funktion, params)
	}
	
	//-------------------------------------------------------------------------
	//
	//	Public methods
	//
	//-------------------------------------------------------------------------
	
	public function loadTrackByIndex(index:int):void
	{
		currentIndex = index
		loadTrackBy(tracks[currentIndex])
	}
	
	public function loadTrackByName(name:String):void
	{
		for each(var track:Track in tracks)
			if(track.name == name)
			{
				currentIndex = tracks.indexOf(track)
				loadTrackBy(tracks[currentIndex])
				break
			}
	}
	
	public function loadTrackBy(track:Track):void
	{
		_currentTrack = track
			
		var soundActions:JobService = new JobService()
		if(mp3Loader) 
		{
			mp3LoaderOld = mp3Loader
			soundActions.addJob(new Job(stopSound, {params: [mp3LoaderOld, soundActions]}))
		}
		mp3Loader = new MP3Loader(track.url)
		mp3Loader.volume = 0
		mp3Loader.addEventListener(LoaderEvent.COMPLETE, mp3Loader_completeHandler, false, 0, true)
		mp3Loader.addEventListener(LoaderEvent.PROGRESS, mp3Loader_progressHandler, false, 0, true)
		soundActions.addJob(new Job(mp3Loader.load, {autoFinish: true}))
		soundActions.addJob(new Job(JobUtils.setValue, {params: [soundActions, null]}))
		soundActions.doJob()
	}
	
	public function loadNextTrack():void
	{
		currentIndex++
		loadTrackBy(tracks[currentIndex])
	}
	
	public function loadPrevTrack():void
	{
		currentIndex--
		loadTrackBy(tracks[currentIndex])
	}
	
	public function stop():void
	{
		stopSound(mp3Loader)
		currentIndex = 0
	}
	
	public function playPause():void
	{
		if(!mp3Loader) return
		if(mp3Loader.soundPaused) playSound(mp3Loader)
		else pauseSound(mp3Loader)
	}
	
	public function pause():void
	{
		pauseSound(mp3Loader)
	}
	
	public function play():void
	{
		if(!mp3Loader) return
		playSound(mp3Loader)
	}
	
	public function loadTrackModels():void
	{
		var modelFactory:ModelFactory = new ModelFactory()
		modelFactory.addEventListener(ResultEvent.DATA_LOADED, modelRequst_dataLoadedHandler)
		modelFactory.load(Track, CMSXmlPath.getSoundPath(), ModelFactory.TYPE_COLLECTION)
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
	
	protected function modelRequst_dataLoadedHandler(event:ResultEvent):void
	{
		tracks = Vector.<Track>(event.collection)
		doFunctionOnSoundPlayerClip(modelRequst_dataLoadedHandler, [event])
		dispatchEvent(new SoundPlayerEvent(SoundPlayerEvent.MODELS_LOADED))
	}
	
	private function mp3Loader_completeHandler(event:LoaderEvent):void
	{
		var mp3Loader:MP3Loader = event.target as MP3Loader
		mp3Loader.addEventListener(MP3Loader.SOUND_COMPLETE, mp3Loader_soundCompleteHandler)
		if(autoPlay) playSound(mp3Loader)
		else pauseSound(mp3Loader)
		dispatchEvent(new Event(Event.COMPLETE))
 		dispatchEvent(new SoundPlayerEvent(SoundPlayerEvent.SOUND_LOADED))
	}
	
	private function soundPlayerView_pauseHandler(event:SoundPlayerEvent):void
	{
		
	}
	
	private function soundPlayerView_playHandler(event:SoundPlayerEvent):void
	{
	}
	
	private function soundPlayerView_playPauseHandler(event:SoundPlayerEvent):void
	{
		
	}
	
	private function mp3Loader_progressHandler(event:LoaderEvent):void
	{
		var progressEvent:SoundPlayerEvent = new SoundPlayerEvent(
			SoundPlayerEvent.PROGRESS, false, false, mp3Loader.progress)
		dispatchEvent(progressEvent)
			
	}
	
	private function mp3Loader_soundCompleteHandler(event:Event):void
	{
		var mp3Loader:MP3Loader = event.target as MP3Loader
		if(loop) 
		{
			mp3Loader.playProgress = 0
			mp3Loader.playSound()
		}
		if(autoPlay)
		{
			loadNextTrack()
		}
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
	
	public function get currentTrack():Track
	{
		return _currentTrack
	}
	
	public function get isPlaying():Boolean
	{
		if(mp3Loader.soundPaused) return false
		else return true
	}
	
	public function get soundTime():Number
	{
		return mp3Loader.soundTime
	}
	
	public function get duration():Number
	{
		return mp3Loader.duration
	}
	
	public function set soundTime(value:Number):void
	{
		mp3Loader.soundTime = value
	}
}
}