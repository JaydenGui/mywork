package com.officeShow.circleShow
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class TooltipSprite extends Sprite
	{
		private var txt:TextField;
		
		public function TooltipSprite()
		{
			super();
			txt = new TextField();
			txt.defaultTextFormat = new TextFormat("微软雅黑",12,0xffffff);
			this.addChild(txt);
		}
		
		public function set data(value:String):void
		{
			txt.text = value;
			txt.width = txt.textWidth + 5;
			txt.height = txt.textHeight + 2;
			graphics.clear();
			graphics.lineStyle(1,0xcccccc,0.8);
			graphics.beginFill(0x0,0.8);
			graphics.drawRect(0,0,txt.width+10,txt.height+6);
			graphics.endFill();
			txt.x = 5;
			txt.y = 3;
		}
	}
}