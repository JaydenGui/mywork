package com.officeShow
{
	public class ColorUtils
	{
		/**
		 * no alpha
		 */
		public static function getMultipleColor(inColor:uint,multiple:Number):uint
		{
			var re:uint;
			
			var color:uint = inColor&0xffffff;
			re += (color&0xff)*multiple%0xff;
			re += (((color>>8)&0xff)*multiple%0xff)<<8;
			re += (((color>>16)&0xff)*multiple%0xff)<<16;
			
			return re;
		}
	}
}