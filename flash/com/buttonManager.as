package com {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	
	public class buttonManager {
		
		public static var _buttonsEnabled:Boolean = true;

		public static function makeButton(_button:MovieClip, funct:Function)
		{
			_button.addEventListener(MouseEvent.MOUSE_OVER,btnOver);
			_button.addEventListener(MouseEvent.MOUSE_OUT,btnOut);
			_button.buttonMode = true;
			_button.clickHandler = funct;
			_button.addEventListener(MouseEvent.CLICK,btnClicked);
		}
		public static function btnClicked(e:MouseEvent)
		{
			TweenMax.to(e.currentTarget,.01,{colorTransform:{exposure:2}});
			TweenMax.to(e.currentTarget,.3,{colorTransform:{exposure:1},delay:.01});
			if(_buttonsEnabled) e.currentTarget.clickHandler(e);
		}
		public static function btnOver(e:MouseEvent)
		{
			if(_buttonsEnabled) TweenMax.to(e.currentTarget,.15,{colorTransform:{exposure:1.1}});
		}
		public static function btnOut(e:MouseEvent)
		{
			TweenMax.to(e.currentTarget,.3,{colorTransform:{exposure:1}});
		}
	}
	
}
