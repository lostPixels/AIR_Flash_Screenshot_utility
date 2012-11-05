package com
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.filesystem.File;
	import flash.events.MouseEvent;
	import flash.events.FileListEvent;
	import com.selected_file_list;

	public class Controller
	{
		private var _path;
		private var _loader:Loader;
		private var _selectedFileList:selected_file_list;
		
		public function Controller($p)
		{
			_path = $p;
			_selectedFileList = new selected_file_list(_path.selected_files_txt_mc);
			
			_path.swf_loader_mc.visible = false;
			_path.selected_files_txt_mc.visible = false;			
			_path.select_btn.buttonMode = true;
			_path.select_btn.addEventListener(MouseEvent.CLICK,browseForFiles);
		}
		private function showSelectedFiles(txt)
		{
			//_path.selected_files_txt_mc.visible = true;
			//_path.selected_files_txt_mc.txt.htmlText = txt;
		}
		private function browseForFiles(e:MouseEvent)
		{
			var directory:File = File.documentsDirectory;
			try
			{
				directory.browseForOpenMultiple("Select Directory");
				directory.addEventListener(FileListEvent.SELECT_MULTIPLE, filesSelected);
			}
			catch (error:Error)
			{
				trace("Failed:", error.message);
			}
			
			function filesSelected(event:FileListEvent):void 
			{
				_path.swf_loader_mc.visible = true;
				/*for (var i:uint = 0; i < event.files.length; i++) 
				{
					
					txt += event.files[i].nativePath+"<br>";
				}*/
				_selectedFileList.init(event.files);
				loadFiles(event.files);
			}
		}
		private function loadFiles($ar:Array)
		{
			loadSwf($ar[0].nativePath,swfLoaded);
		}
		
		private function swfLoaded($d)
		{
			trace($d);
			_path.addChild($d);
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