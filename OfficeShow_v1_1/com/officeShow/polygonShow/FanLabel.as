package com.officeShow.polygonShow
{
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class FanLabel extends Sprite
	{
		public static const len:Number = 100;
		public static const innerLen:Number = 30;
		public static const _radian:Number = Math.PI/14;
		
		private var fanPosList:Array;
		private var textField:TextField;
		public function FanLabel()
		{
			super();
			this.mouseChildren = false;
			this.mouseEnabled = false;
			
			var xInner:Number = innerLen*Math.cos(radian);
			var yInner:Number = -innerLen*Math.sin(radian);
			var xOut:Number = len*Math.cos(radian);
			var yOut:Number = -len*Math.sin(radian);
				
			fanPosList = [xInner,yInner,xInner,-yInner,xOut,-yOut,xOut,yOut];
			
			this.graphics.beginGradientFill(GradientType.LINEAR,[0x80AED2,0x93C1E5],[1,1],[0,255]);//(0x71A1C7);
			this.graphics.moveTo(fanPosList[0],fanPosList[1]);
//			this.graphics.lineTo(fanPosList[2],fanPosList[3]);
			this.graphics.curveTo(innerLen+1,0,fanPosList[2],fanPosList[3]);
			this.graphics.lineTo(fanPosList[4],fanPosList[5]);
//			this.graphics.lineTo(fanPosList[6],fanPosList[7]);
			this.graphics.curveTo(len+4,0,fanPosList[6],fanPosList[7]);
			this.graphics.endFill();
			
			textField = new TextField();
			textField.width = 64;
			var fSize:int = 10;
			textField.defaultTextFormat = new TextFormat("微软雅黑",fSize,0xffffff,null,null,null,null,null,TextFormatAlign.CENTER);
			textField.x = innerLen + 6;
			textField.y = -fSize/2-2;
			textField.mouseEnabled = false;
			this.addChild(textField);
			
			text = "7000-9000元";
		}
		
		
		public function set text(value:String):void
		{
			textField.text = value;
		}
		
		public function get radian():Number
		{
			return _radian;
		}
	}
}