package  com.planitagency
{	
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;

	public class loader {		
		function startLoad(url,target,callBack)
		{
			var mLoader:Loader = new Loader();
			var mRequest:URLRequest = new URLRequest(url);
			mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			mLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			mLoader.load(mRequest);
			target.preloader.pl_bar.scaleX = 0;
			function onCompleteHandler(loadEvent:Event)
			{
					//trace("loaded "+url+" "+target+" "+callBack)
					var mc = target.addChild(loadEvent.currentTarget.content);
					callBack(mc);
			}
			function onProgressHandler(mProgress:ProgressEvent)
			{
				var percent:Number = mProgress.bytesLoaded/mProgress.bytesTotal;
				if(target.preloader) target.preloader.pl_bar.scaleX = percent;
			}
		}
	}
}
