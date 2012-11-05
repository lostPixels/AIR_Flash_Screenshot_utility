package com
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.adobe.images.JPGEncoder;
	import flash.utils.ByteArray;
	import flash.filesystem.File;
	import flash.net.FileReference;
	import flash.events.Event;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	import flash.utils.setTimeout;

	public class image_saver
	{
		private var _path:MovieClip;
		private var _bD_ar:Array;
		private var _encoder:JPGEncoder = new JPGEncoder(85);
		private var _encoded_ar:Array = new Array();
		private var _url_ar:Array;
		private var step:int = 0;
		public function image_saver($p:MovieClip, $ar:Array,$url_ar:Array)
		{
			_path = $p;
			_bD_ar = $ar;
			_url_ar = $url_ar;
			_path.step_3.visible = true;
			_path.step_3.status_txt.txtBox.text = "Encoding Images...";
			_path.step_3.save_btn.visible = false;
			startBannerEncode()
		}
		private function startSave(e:MouseEvent)
		{
			var file:File = new File();
			file.addEventListener(Event.SELECT, directorySelected);
			file.browseForDirectory("Choose a Directory");
		}
		private function directorySelected(evt:Event):void
		{
			File(evt.currentTarget).removeEventListener(Event.SELECT, directorySelected);
		   
			for(var i:int = 0; i<_encoded_ar.length; i++)
			{			   
				var image = _encoded_ar[i];
				var fileName:String = getTruncatedName(_url_ar[i].url);
				trace(fileName);
				var fl:File= new File( evt.currentTarget.nativePath+"/"+fileName+ ".jpg");
				var fs:FileStream = new FileStream();
				fs.open(fl, FileMode.WRITE);
				fs.writeBytes(image,0,image.length);
				fs.close();
			}
			_path.step_3.save_btn.visible = false;
			_path.step_3.status_txt.visible = true;
			_path.step_3.status_txt.txtBox.text = "Files saved!";
		}
		private function allBitmapsConverted()
		{
			_path.selected_files_txt_mc.setButtonToDone(step-1);
			_path.step_3.save_btn.visible = true;
			_path.step_3.status_txt.visible = false;
			_path.step_3.save_btn.addEventListener(MouseEvent.CLICK,startSave);
			trace("---ALL ADS CONVERTED---");
		}
		private function startBannerEncode()
		{
			if(step > 0) _path.selected_files_txt_mc.setButtonToDone(step-1);
			_path.selected_files_txt_mc.setButtonToInProgress(step);
			setTimeout(encodeBanner,250);
		}
		private function encodeBanner()
		{
			trace("+++ENCODE+++");
			var jpg:ByteArray = _encoder.encode(_bD_ar[step]);
			_encoded_ar.push(jpg);
			step++;
			if(step >= _bD_ar.length) allBitmapsConverted();
			else startBannerEncode();
		}
		private function getTruncatedName($s:String)
		{
			return $s.slice($s.lastIndexOf('/')+1,$s.lastIndexOf("."));
		}
	}

}