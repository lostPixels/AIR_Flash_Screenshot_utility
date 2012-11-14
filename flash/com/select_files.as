package com
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.events.FileListEvent;
	import com.selected_file_list;
	import com.planitagency.CustomEvent;
	import com.buttonManager;

	public class select_files
	{
		private var _path:MovieClip;
		private var _selectedFileList:selected_file_list;

		public function select_files($p)
		{
			_path = $p;
			_selectedFileList = _path.selected_files_txt_mc;
			_path.step_1.visible = true;
			buttonManager.makeButton(_path.step_1.select_btn,browseForFiles);
		}
		private function browseForFiles(e:MouseEvent)
		{
			var directory:File = File.documentsDirectory;
			try
			{
				directory.browseForOpenMultiple("Select SWF Files to open:");
				directory.addEventListener(FileListEvent.SELECT_MULTIPLE, filesSelected);
			}
			catch (error:Error)
			{
				trace("Failed:", error.message);
			}
			
			function filesSelected(event:FileListEvent):void 
			{
				_selectedFileList.init(event.files);
				_path.dispatchEvent(new CustomEvent("FILES_SELECTED",true,false,{_file_ar:event.files}));
			}
		}
	}
}