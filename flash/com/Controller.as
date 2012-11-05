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
	import com.greensock.TweenMax;
	import com.selected_file_list;
	import com.select_files;
	import com.image_saver;
	import com.planitagency.CustomEvent;

	public class Controller
	{
		private var _path;
		private var _fileSelector:select_files;
		private var _queueManager:queue_manager;
		private var _image_saver:image_saver;
		private var _filename_ar:Array;
		
		public function Controller($p)
		{
			_path = $p;
			hideAssets();
			_path.addEventListener("FILES_SELECTED",handleSelectedFiles);
			_path.addEventListener("READY_TO_SAVE",handleFilesToSave);
			initConverter();
		}
		private function hideAssets()
		{
			_path.step_1.visible = _path.step_2.visible = _path.step_3.visible = false;
		}
		private function initConverter()
		{
			_fileSelector = new select_files(_path);
		}
		private function handleSelectedFiles(e:CustomEvent)
		{
			_filename_ar = e.arg._file_ar;
			_queueManager = new queue_manager(_path, _filename_ar);
		}
		private function handleFilesToSave(e:CustomEvent)
		{
			_image_saver = new image_saver(_path,e.arg._bitmap_ar,_filename_ar);
		}
	}
}