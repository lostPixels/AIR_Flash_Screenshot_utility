package com
{
	// Planit Agency - James Merrill \\

	public class utils
	{
		public function getRandomNumber($low:Number,$high:Number):Number
		{
			return Math.floor(Math.random() * ((1 + $high) - $low)) + $low;
		}
		private function randomizeArray($array:Array):Array
		{
			var _length:Number = $array.length;
			var mixed:Array = $array.slice();
			var rn:Number;
			var it:Number;
			var el:Object;
			for (it = 0; it < _length; it++)
			{
				el = mixed[it];
				rn = Math.floor(Math.random() * _length);
				mixed[it] = mixed[rn];
				mixed[rn] = el;
			}
			return mixed;
		}
		public function removeAllSpaces($s)
		{
			return $s.replace(/\s+/g, '');
		}
	}
}