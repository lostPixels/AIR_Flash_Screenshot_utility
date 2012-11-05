package com
{
	// Planit Agency - James Merrill \\
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.MovieClip;
	import flash.events.*;
	import com.Controller;
	
	public class index extends MovieClip
	{
		private var _path:MovieClip;
		private var _controller:Controller;
		public function index():void
		{
			_path = this;
			_controller = new Controller(this);
		}
	}
}