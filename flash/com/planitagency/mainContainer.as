package com.planitagency
{

	import flash.display.MovieClip;
	import com.planitagency.loader;

	public class mainContainer extends MovieClip
	{
		private var _mcloader:loader;
		private var _path:MovieClip;
		private var load_attempts:int = 0;
		public static const id:int = 0;
		public function mainContainer()
		{
			_mcloader = new loader();
			_path = this;
			_path.stage.showDefaultContextMenu = false;
			tryLoad()
		}
		private function indexLoaded(mc)
		{
			_path.addChild(mc);
			//mc.setID();
			trace(mc);
			removeChild(_path.preloader);
		}
		private function tryLoad()
		{
			var error:Boolean = false;
			try
			{
				_mcloader.startLoad("index.swf",_path,indexLoaded);
			}
			catch (e:Error)
			{
				trace(e);
				error = true;
			}
			finally
			{
				load_attempts++
				if(load_attempts < 5 && error) tryLoad()
			}
		}
	}
}