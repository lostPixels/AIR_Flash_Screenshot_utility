package com
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import com.planitagency.CustomEvent;

	public class queue_manager
	{
		private var _path:MovieClip;
		private var _loader:Loader;
		private var _urlArray:Array;
		private var _loaded_movie_ar:Array = new Array();
		private var _loadCount:int = 0;
		private var _container:MovieClip = new MovieClip();
		private var _waitTimer:Timer;
		private var _statusTimer:Timer;
		private var _bitmapDataObjects_ar:Array = new Array();
		private var timer_delay:int;
		private var seconds_into_timer:int = 0;
		
		public function queue_manager($p, $ar)
		{
			_path = $p;
			_urlArray = $ar;
			_path.step_2.visible = true;
			_path.step_2.preview_txt.visible = false;
			_path.step_2.queue_start.progress_mc.visible = false;
			buttonManager.makeButton(_path.step_2.queue_start.start_btn,processSWFs);
		}
		public function Update($ar)
		{
			trace("//////UPDATE QUEUE MANAGER//////");
			_path.step_2.queue_start.sec_txt.text = timer_delay;
			_loadCount = 0;
			clearImagesPreview();
			_urlArray = $ar;
			_loaded_movie_ar = new Array();
			_path.step_2.visible = true;
			_path.step_2.preview_txt.visible = false;
			_path.step_2.queue_start.progress_mc.visible = false;
			_path.step_2.queue_start.visible = true;
		}
		public function Close()
		{
			_path.step_2.visible = false;	
		}
		private function processSWFs(e:MouseEvent)
		{
			_bitmapDataObjects_ar = new Array();
			timer_delay = _path.step_2.queue_start.sec_txt.text;
			_waitTimer = new Timer(timer_delay*1000,1);
			_statusTimer = new Timer(1000,timer_delay);
			_waitTimer.addEventListener(TimerEvent.TIMER_COMPLETE,takeScreenShot);
			_statusTimer.addEventListener(TimerEvent.TIMER,updateTimer);
			initLoadFiles();
		}
		private function updateTimer(e:TimerEvent)
		{
			seconds_into_timer++;
			_path.step_2.queue_start.sec_txt.text = timer_delay - seconds_into_timer;
		}
		private function takeScreenShot(e:TimerEvent)
		{
			var bd:BitmapData;
			for(var i in _loaded_movie_ar)
			{
				var banner = _loaded_movie_ar[i];
				trace(banner.contentLoaderInfo.width);
				bd = new BitmapData(banner.contentLoaderInfo.width,banner.contentLoaderInfo.height,false);
				bd.draw(banner);
				_bitmapDataObjects_ar.push(bd);
			}
			_path.step_2.queue_start.visible = false;
			pushImagesToPreview();
			_path.dispatchEvent(new CustomEvent("READY_TO_SAVE",true,false,{_bitmap_ar:_bitmapDataObjects_ar}));
		}
		private function clearImagesPreview()
		{
			if(_path.step_2.img_container.numChildren > 0)
			{
				while(_path.step_2.img_container.numChildren > 0)
				{
					_path.step_2.img_container.removeChildAt(0);
				}
			}
		}
		private function pushImagesToPreview()
		{
			var maxWidth:int = 475;
			var oS:int = 0;
			for(var i=0; i<_bitmapDataObjects_ar.length; i++)
			{
				var bD:Bitmap = new Bitmap(_bitmapDataObjects_ar[i]);
				var bitmap = _path.step_2.img_container.addChild(bD);
				bitmap.x = oS;
				oS+= bitmap.width + 10;
			}
			_path.step_2.preview_txt.visible = true;
			_path.step_2.img_container.width = 475;
			_path.step_2.img_container.scaleY = _path.step_2.img_container.scaleX;
			if(_path.step_2.img_container.height > 115)
			{
				_path.step_2.img_container.height = 125;
				_path.step_2.img_container.scaleX = _path.step_2.img_container.scaleY;
			}
		}
		private function initLoadFiles()
		{
			loadSwf( _urlArray[_loadCount].nativePath ,swfLoaded);
		}
		
		private function swfLoaded($d:Loader)
		{
			_loaded_movie_ar.push(_container.addChild($d));
			_loadCount++;
			if(_loadCount < _urlArray.length) initLoadFiles();
			else{
				_path.step_2.queue_start.progress_mc.visible = true;
				_waitTimer.start();
				_statusTimer.start();
			}
		}
		
		private function loadSwf(url:String,callBack:Function)
		{
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			_loader.load(new URLRequest("file://"+url));
			
			function onCompleteHandler(loadEvent:Event)
			{
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onCompleteHandler);
				callBack(loadEvent.currentTarget.loader);
			}
		}

	}

}