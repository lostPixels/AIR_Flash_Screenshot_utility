package com
{
	import flash.events.Event;

	public class CustomEvent extends Event
	{
		public var arg:*;
		public function CustomEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, a = null)
		{
			super(type, bubbles, cancelable);
			arg = a;
		}
		override public function clone():Event
		{
			return new CustomEvent(type, bubbles, cancelable, arg);
		}
	}
}


/*

var vars = "VARIABLE"
path.dispatchEvent( new CustomEvent("user_data_loaded",true,false,vars) );

path.addEventListener("user_data_loaded",dataLoaded);
function dataLoaded(e:CustomEvent)
{
	trace("Data loaded"+e.arg);
	initGameScreen();
}
*/