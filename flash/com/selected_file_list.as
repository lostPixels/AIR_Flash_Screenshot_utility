package com
{
	import flash.display.MovieClip;
	import com.greensock.TweenMax;

	public class selected_file_list extends MovieClip
	{
		private var _path:MovieClip;
		private var _btn_ar:Array;
		private var _ar:Array;
		public function selected_file_list()
		{
			_path = this;
			_path.visible = false;
			_btn_ar = new Array();
		}
		public function init($ar)
		{
			_ar = $ar;
			_path.visible = true;
			_path.bg.height = 0;
						
			for(var i in $ar)
			{
				var btn:file_txt_node = new file_txt_node();
				_btn_ar.push(btn);
				btn.x = 14;
				btn.y = 52 +(28*i);
				btn.txtBox.text = getTruncatedName($ar[i].url);
				TweenMax.to(btn,.01,{scaleX:0,colorTransform:{brightness:2}});
				TweenMax.to(btn,.5,{scaleX:1,colorTransform:{brightness:1},delay:(.2 + i/5)});
				_path.addChild(btn);
			}
			TweenMax.to(_path.bg,.4,{height:52+(28*(i+1)+10)});
		}
		public function setButtonToInProgress(id)
		{
			_btn_ar[id].status_mc.gotoAndStop(2);
		}
		public function setButtonToDone(id)
		{
			_btn_ar[id].status_mc.gotoAndStop(3);
		}
		private function getTruncatedName($s:String)
		{
			return $s.substr($s.lastIndexOf('/')+1,$s.length);
		}
	}

}