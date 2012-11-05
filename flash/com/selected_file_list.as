package com
{
	import flash.display.MovieClip;

	public class selected_file_list
	{
		private var _path:MovieClip;
		private var _ar:Array;
		public function selected_file_list($p:MovieClip)
		{
			_path = $p;
		}
		public function init($ar)
		{
			_ar = $ar;
			_path.visible = true;
		}

	}

}